package com.ruoyi.equipment.order.service;

import java.util.List;
import com.ruoyi.equipment.order.domain.ResOrder;

/**
 * 预约订单Service接口
 * 
 * @author ganyu
 * @date 2026-05-07
 */
public interface IResOrderService
{
    /**
     * 查询预约订单
     * 
     * @param orderId 预约订单ID
     * @return 预约订单
     */
    public ResOrder selectResOrderById(Long orderId);

    /**
     * 查询预约订单列表
     * 
     * @param resOrder 预约订单
     * @return 预约订单集合
     */
    public List<ResOrder> selectResOrderList(ResOrder resOrder);

    /**
     * 新增预约订单
     * 
     * @param resOrder 预约订单
     * @return 结果
     */
    public int insertResOrder(ResOrder resOrder);

    /**
     * 修改预约订单
     * 
     * @param resOrder 预约订单
     * @return 结果
     */
    public int updateResOrder(ResOrder resOrder);

    /**
     * 批量删除预约订单
     * 
     * @param ids 需要删除的预约订单ID
     * @return 结果
     */
    public int deleteResOrderByIds(Long[] ids);

    /**
     * 删除预约订单信息
     * 
     * @param orderId 预约订单ID
     * @return 结果
     */
    public int deleteResOrderById(Long orderId);
}
