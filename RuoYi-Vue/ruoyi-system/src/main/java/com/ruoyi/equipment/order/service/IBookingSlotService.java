package com.ruoyi.equipment.order.service;

import java.util.List;

/**
 * 预约时间槽服务接口
 * 基于 Redis 分布式锁 + Lua 原子脚本实现设备+时间槽的预占与释放
 *
 * @author ganyu
 * @date 2026-06-12
 */
public interface IBookingSlotService {

    /**
     * 对指定设备在指定日期的时间槽进行预占（原子操作）
     * <p>
     * 流程：
     * 1. 对每个槽位依次获取分布式锁
     * 2. 通过 Lua 脚本原子检查 (当前占用 + 请求数量) <= 最大容量
     * 3. 如果通过，预占成功；否则回滚已预占的槽位并返回失败
     *
     * @param equipmentId 设备ID
     * @param date        预约日期 (yyyy-MM-dd)
     * @param slotIndices 需要预占的槽位索引列表
     * @param quantity    预约数量
     * @param maxCapacity 该设备单槽最大容量
     * @return true=预占成功, false=容量不足
     */
    boolean tryOccupySlots(Long equipmentId, String date, List<Integer> slotIndices,
                           int quantity, int maxCapacity);

    /**
     * 释放已预占的时间槽
     *
     * @param equipmentId 设备ID
     * @param date        预约日期
     * @param slotIndices 槽位索引列表
     * @param quantity    释放数量
     */
    void releaseSlots(Long equipmentId, String date, List<Integer> slotIndices, int quantity);

    /**
     * 查询指定设备+日期+槽位的当前占用数量
     *
     * @param equipmentId 设备ID
     * @param date        日期
     * @param slotIndex   槽位索引
     * @return 当前占用数
     */
    int getSlotOccupancy(Long equipmentId, String date, int slotIndex);
}
