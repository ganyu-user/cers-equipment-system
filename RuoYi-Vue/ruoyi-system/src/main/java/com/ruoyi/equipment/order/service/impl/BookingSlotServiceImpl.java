package com.ruoyi.equipment.order.service.impl;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;
import com.ruoyi.equipment.order.service.IBookingSlotService;

/**
 * 预约时间槽服务实现
 * <p>
 * 核心设计：
 * <ul>
 *   <li>时间分片：将每天划分为 N 个固定长度的时间槽（默认30分钟）</li>
 *   <li>分布式锁：使用 Redis SET NX EX 对 (设备ID + 日期 + 槽位) 加锁，防止并发冲突</li>
 *   <li>Lua 原子脚本：在锁保护下，原子执行"检查容量 + 递增占用"操作</li>
 *   <li>回滚机制：若任一槽位预占失败，自动释放已成功预占的槽位</li>
 * </ul>
 *
 * Redis Key 设计：
 * <pre>
 *   槽位占用计数: res:slot:{equipmentId}:{date}:{slotIndex}  → Integer
 *   槽位分布式锁: res:slot:lock:{equipmentId}:{date}:{slotIndex}  → String (SET NX)
 * </pre>
 *
 * @author ganyu
 * @date 2026-06-12
 */
@Service
public class BookingSlotServiceImpl implements IBookingSlotService {

    private static final Logger log = LoggerFactory.getLogger(BookingSlotServiceImpl.class);

    /** 槽位占用计数 Key 前缀 */
    private static final String SLOT_KEY_PREFIX = "res:slot:";

    /** 槽位分布式锁 Key 前缀 */
    private static final String SLOT_LOCK_PREFIX = "res:slot:lock:";

    /** 分布式锁超时时间（秒），防止死锁 */
    private static final long LOCK_TIMEOUT_SECONDS = 10;

    /** 获取锁的最大等待时间（毫秒） */
    private static final long LOCK_WAIT_MS = 3000;

    /** 获取锁的重试间隔（毫秒） */
    private static final long LOCK_RETRY_INTERVAL_MS = 100;

    /** 槽位占用数据的 TTL（秒）：预约日期 + 7天过期 */
    private static final long SLOT_TTL_SECONDS = Duration.ofDays(7).getSeconds();

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    /** Lua 脚本：原子检查并预占槽位 */
    private final DefaultRedisScript<Long> occupyScript;

    /** Lua 脚本：释放槽位 */
    private final DefaultRedisScript<Long> releaseScript;

    /** Lua 脚本：读取槽位占用 */
    private final DefaultRedisScript<Long> readScript;

    public BookingSlotServiceImpl() {
        this.occupyScript = buildOccupyScript();
        this.releaseScript = buildReleaseScript();
        this.readScript = buildReadScript();
    }

    // ==================== Lua 脚本定义 ====================

    /**
     * 预占 Lua 脚本
     * <p>
     * KEYS[1]: 槽位占用计数 Key
     * ARGV[1]: 请求预占数量
     * ARGV[2]: 最大容量
     * ARGV[3]: TTL（秒）
     * <p>
     * 返回值: 1=预占成功, 0=容量不足
     */
    private static DefaultRedisScript<Long> buildOccupyScript() {
        DefaultRedisScript<Long> script = new DefaultRedisScript<>();
        script.setResultType(Long.class);
        script.setScriptText(
            "local current = redis.call('GET', KEYS[1])\n" +
            "local requested = tonumber(ARGV[1])\n" +
            "local maxCap = tonumber(ARGV[2])\n" +
            "local ttl = tonumber(ARGV[3])\n" +
            "if current and tonumber(current) + requested > maxCap then\n" +
            "    return 0\n" +
            "end\n" +
            "local newVal = redis.call('INCRBY', KEYS[1], requested)\n" +
            "redis.call('EXPIRE', KEYS[1], ttl)\n" +
            "return 1"
        );
        return script;
    }

    /**
     * 释放 Lua 脚本
     * <p>
     * KEYS[1]: 槽位占用计数 Key
     * ARGV[1]: 释放数量
     * <p>
     * 返回值: 释放后的剩余数量（最小为0）
     */
    private static DefaultRedisScript<Long> buildReleaseScript() {
        DefaultRedisScript<Long> script = new DefaultRedisScript<>();
        script.setResultType(Long.class);
        script.setScriptText(
            "local current = redis.call('GET', KEYS[1])\n" +
            "if not current then return 0 end\n" +
            "local release = tonumber(ARGV[1])\n" +
            "local newVal = math.max(0, tonumber(current) - release)\n" +
            "redis.call('SET', KEYS[1], newVal)\n" +
            "return newVal"
        );
        return script;
    }

    /**
     * 读取槽位占用 Lua 脚本
     * <p>
     * KEYS[1]: 槽位占用计数 Key
     * <p>
     * 返回值: 当前占用数量
     */
    private static DefaultRedisScript<Long> buildReadScript() {
        DefaultRedisScript<Long> script = new DefaultRedisScript<>();
        script.setResultType(Long.class);
        script.setScriptText(
            "local current = redis.call('GET', KEYS[1])\n" +
            "if not current then return 0 end\n" +
            "return tonumber(current)"
        );
        return script;
    }

    // ==================== Key 构建 ====================

    private String slotKey(Long equipmentId, String date, int slotIndex) {
        return SLOT_KEY_PREFIX + equipmentId + ":" + date + ":" + slotIndex;
    }

    private String lockKey(Long equipmentId, String date, int slotIndex) {
        return SLOT_LOCK_PREFIX + equipmentId + ":" + date + ":" + slotIndex;
    }

    // ==================== 分布式锁 ====================

    /**
     * 尝试获取分布式锁（自旋等待）
     */
    private boolean tryAcquireLock(String lockKey) {
        long deadline = System.currentTimeMillis() + LOCK_WAIT_MS;
        while (System.currentTimeMillis() < deadline) {
            Boolean acquired = stringRedisTemplate.opsForValue()
                .setIfAbsent(lockKey, "1", Duration.ofSeconds(LOCK_TIMEOUT_SECONDS));
            if (Boolean.TRUE.equals(acquired)) {
                return true;
            }
            try {
                Thread.sleep(LOCK_RETRY_INTERVAL_MS);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return false;
            }
        }
        return false;
    }

    /**
     * 释放分布式锁
     */
    private void releaseLock(String lockKey) {
        stringRedisTemplate.delete(lockKey);
    }

    // ==================== 核心业务方法 ====================

    @Override
    public boolean tryOccupySlots(Long equipmentId, String date, List<Integer> slotIndices,
                                   int quantity, int maxCapacity) {
        if (slotIndices == null || slotIndices.isEmpty()) {
            return false;
        }

        // 按槽位索引排序，确保加锁顺序一致，避免死锁
        List<Integer> sortedSlots = new ArrayList<>(slotIndices);
        Collections.sort(sortedSlots);

        // 记录已成功预占的槽位，用于回滚
        List<Integer> occupiedSlots = new ArrayList<>();

        try {
            for (Integer slotIndex : sortedSlots) {
                String lockKey = lockKey(equipmentId, date, slotIndex);

                // Step 1: 获取分布式锁
                if (!tryAcquireLock(lockKey)) {
                    log.warn("获取槽位锁超时, equipmentId={}, date={}, slot={}", equipmentId, date, slotIndex);
                    rollbackOccupied(equipmentId, date, occupiedSlots, quantity);
                    return false;
                }

                try {
                    // Step 2: Lua 原子脚本检查容量 + 预占（使用 StringRedisTemplate 确保参数正确序列化）
                    String key = slotKey(equipmentId, date, slotIndex);
                    Long result = stringRedisTemplate.execute(
                        occupyScript,
                        Collections.singletonList(key),
                        String.valueOf(quantity),
                        String.valueOf(maxCapacity),
                        String.valueOf(SLOT_TTL_SECONDS)
                    );

                    if (result == null || result == 0) {
                        log.info("槽位容量不足, equipmentId={}, date={}, slot={}, qty={}, max={}",
                            equipmentId, date, slotIndex, quantity, maxCapacity);
                        rollbackOccupied(equipmentId, date, occupiedSlots, quantity);
                        return false;
                    }

                    occupiedSlots.add(slotIndex);
                } finally {
                    releaseLock(lockKey);
                }
            }

            log.info("时间槽预占成功, equipmentId={}, date={}, slots={}, qty={}",
                equipmentId, date, sortedSlots, quantity);
            return true;

        } catch (Exception e) {
            log.error("时间槽预占异常, equipmentId={}, date={}, slots={}", equipmentId, date, sortedSlots, e);
            rollbackOccupied(equipmentId, date, occupiedSlots, quantity);
            return false;
        }
    }

    /**
     * 回滚已预占的槽位
     */
    private void rollbackOccupied(Long equipmentId, String date,
                                   List<Integer> occupiedSlots, int quantity) {
        for (Integer slotIndex : occupiedSlots) {
            try {
                String key = slotKey(equipmentId, date, slotIndex);
                stringRedisTemplate.execute(
                    releaseScript,
                    Collections.singletonList(key),
                    String.valueOf(quantity)
                );
            } catch (Exception e) {
                log.error("回滚槽位失败, equipmentId={}, date={}, slot={}", equipmentId, date, slotIndex, e);
            }
        }
    }

    @Override
    public void releaseSlots(Long equipmentId, String date, List<Integer> slotIndices, int quantity) {
        if (slotIndices == null || slotIndices.isEmpty()) {
            return;
        }

        for (Integer slotIndex : slotIndices) {
            try {
                String key = slotKey(equipmentId, date, slotIndex);
                stringRedisTemplate.execute(
                    releaseScript,
                    Collections.singletonList(key),
                    String.valueOf(quantity)
                );
            } catch (Exception e) {
                log.error("释放槽位失败, equipmentId={}, date={}, slot={}", equipmentId, date, slotIndex, e);
            }
        }

        log.info("时间槽释放完成, equipmentId={}, date={}, slots={}, qty={}",
            equipmentId, date, slotIndices, quantity);
    }

    @Override
    public int getSlotOccupancy(Long equipmentId, String date, int slotIndex) {
        try {
            String key = slotKey(equipmentId, date, slotIndex);
            Long result = stringRedisTemplate.execute(
                readScript, Collections.singletonList(key));
            return result != null ? result.intValue() : 0;
        } catch (Exception e) {
            log.error("查询槽位占用失败, equipmentId={}, date={}, slot={}", equipmentId, date, slotIndex, e);
            return 0;
        }
    }
}
