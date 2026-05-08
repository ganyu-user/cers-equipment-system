package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ResOrder;

/**
 * 设备预约单管理Service接口
 * 
 * @author ganyu
 * @date 2026-05-07
 */
public interface IResOrderService 
{
    /**
     * 查询设备预约单管理
     * 
     * @param orderId 设备预约单管理主键
     * @return 设备预约单管理
     */
    public ResOrder selectResOrderByOrderId(Long orderId);

    /**
     * 查询设备预约单管理列表
     * 
     * @param resOrder 设备预约单管理
     * @return 设备预约单管理集合
     */
    public List<ResOrder> selectResOrderList(ResOrder resOrder);

    /**
     * 新增设备预约单管理
     * 
     * @param resOrder 设备预约单管理
     * @return 结果
     */
    public int insertResOrder(ResOrder resOrder);

    /**
     * 修改设备预约单管理
     * 
     * @param resOrder 设备预约单管理
     * @return 结果
     */
    public int updateResOrder(ResOrder resOrder);

    /**
     * 批量删除设备预约单管理
     * 
     * @param orderIds 需要删除的设备预约单管理主键集合
     * @return 结果
     */
    public int deleteResOrderByOrderIds(Long[] orderIds);

    /**
     * 删除设备预约单管理信息
     * 
     * @param orderId 设备预约单管理主键
     * @return 结果
     */
    public int deleteResOrderByOrderId(Long orderId);
}
