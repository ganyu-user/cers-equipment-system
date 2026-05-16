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
    public ResOrder selectResOrderById(Long orderId);

    public List<ResOrder> selectResOrderList(ResOrder resOrder);

    public List<ResOrder> selectMyOrderList(ResOrder resOrder);

    public int insertResOrder(ResOrder resOrder);

    public int updateResOrder(ResOrder resOrder);

    public int deleteResOrderByIds(Long[] ids);

    public int deleteResOrderById(Long orderId);

    public int approveOrder(Long orderId);

    public int rejectOrder(Long orderId, String rejectReason);

    public int returnOrder(Long orderId, String returnStatus, String damageRemark);
}