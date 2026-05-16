package com.ruoyi.equipment.order.mapper;

import java.util.List;
import com.ruoyi.equipment.order.domain.ResOrder;

/**
 * 预约订单Mapper接口
 * 
 * @author ganyu
 * @date 2026-05-07
 */
public interface ResOrderMapper
{
    public ResOrder selectResOrderById(Long orderId);

    public List<ResOrder> selectResOrderList(ResOrder resOrder);

    public List<ResOrder> selectResOrderListByUserId(ResOrder resOrder);

    public int insertResOrder(ResOrder resOrder);

    public int updateResOrder(ResOrder resOrder);

    public int deleteResOrderById(Long orderId);

    public int deleteResOrderByIds(Long[] orderIds);
}