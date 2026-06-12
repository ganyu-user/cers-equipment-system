package com.ruoyi.equipment.order.util;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 时间槽分片工具类
 * 将一天划分为固定长度的时间槽，实现时间段→槽位索引的映射
 *
 * @author ganyu
 * @date 2026-06-12
 */
public class SlotSegment {

    /** 每个时间槽的分钟数（默认30分钟） */
    public static final int SLOT_MINUTES = 30;

    /** 一天内的最大槽位数（24 * 60 / SLOT_MINUTES） */
    public static final int MAX_SLOTS_PER_DAY = 24 * 60 / SLOT_MINUTES;

    /** 默认每日开始时间 08:00 */
    public static final LocalTime DAY_START = LocalTime.of(8, 0);

    /** 默认每日结束时间 22:00 */
    public static final LocalTime DAY_END = LocalTime.of(22, 0);

    /**
     * 获取指定时间所属的槽位索引（0-based，从 DAY_START 开始计算）
     *
     * @param time 时间
     * @return 槽位索引，-1 表示不在可预约时段内
     */
    public static int getSlotIndex(LocalTime time) {
        if (time.isBefore(DAY_START) || !time.isBefore(DAY_END)) {
            return -1;
        }
        return (int) java.time.Duration.between(DAY_START, time).toMinutes() / SLOT_MINUTES;
    }

    /**
     * 获取槽位索引对应的时间段起始时间
     *
     * @param slotIndex 槽位索引
     * @return 该槽位的起始时间
     */
    public static LocalTime getSlotStartTime(int slotIndex) {
        return DAY_START.plusMinutes((long) slotIndex * SLOT_MINUTES);
    }

    /**
     * 获取槽位索引对应的时间段结束时间
     *
     * @param slotIndex 槽位索引
     * @return 该槽位的结束时间
     */
    public static LocalTime getSlotEndTime(int slotIndex) {
        return DAY_START.plusMinutes((long) (slotIndex + 1) * SLOT_MINUTES);
    }

    /**
     * 将一个时间段（起始时间 ~ 结束时间）拆分为覆盖的槽位索引列表
     *
     * @param startTime 开始时间
     * @param endTime   结束时间（不包含）
     * @return 覆盖的槽位索引列表
     */
    public static List<Integer> getCoveredSlots(LocalTime startTime, LocalTime endTime) {
        List<Integer> slots = new ArrayList<>();
        int startSlot = getSlotIndex(startTime);
        int endSlot = getSlotIndex(endTime.minusMinutes(1));

        if (startSlot < 0 || endSlot < 0) {
            return slots;
        }

        for (int i = startSlot; i <= endSlot && i < MAX_SLOTS_PER_DAY; i++) {
            slots.add(i);
        }
        return slots;
    }

    /**
     * 将一天内的连续槽位索引压缩为区间描述字符串
     * 用于存储到订单中，如 "2026-06-12:4,5,6,7"
     *
     * @param date  日期
     * @param slots 槽位列表
     * @return 压缩字符串
     */
    public static String toSlotString(LocalDate date, List<Integer> slots) {
        StringBuilder sb = new StringBuilder();
        sb.append(date.toString()).append(":");
        for (int i = 0; i < slots.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(slots.get(i));
        }
        return sb.toString();
    }

    /**
     * 从槽位字符串中解析出日期和槽位列表
     */
    public static SlotRange parseSlotString(String slotString) {
        if (slotString == null || slotString.isEmpty()) {
            return null;
        }
        String[] parts = slotString.split(":");
        if (parts.length != 2) {
            return null;
        }
        LocalDate date = LocalDate.parse(parts[0]);
        String[] idxArr = parts[1].split(",");
        List<Integer> slots = new ArrayList<>();
        for (String idx : idxArr) {
            slots.add(Integer.parseInt(idx.trim()));
        }
        return new SlotRange(date, slots);
    }

    /**
     * 时间槽区间
     */
    public static class SlotRange {
        public final LocalDate date;
        public final List<Integer> slotIndices;

        public SlotRange(LocalDate date, List<Integer> slotIndices) {
            this.date = date;
            this.slotIndices = slotIndices;
        }
    }
}
