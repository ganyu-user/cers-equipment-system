package com.ruoyi.equipment.order.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.equipment.order.mapper.ResOrderMapper;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.service.IResOrderService;

/**
 * 预约订单Service业务层处理
 * 
 * @author ganyu
 * @date 2026-05-07
 */
@Service
public class ResOrderServiceImpl implements IResOrderService
{
    @Autowired
    private ResOrderMapper resOrderMapper;

    @Override
    public ResOrder selectResOrderById(Long orderId)
    {
        return resOrderMapper.selectResOrderById(orderId);
    }

    @Override
    public List<ResOrder> selectResOrderList(ResOrder resOrder)
    {
        return resOrderMapper.selectResOrderList(resOrder);
    }

    @Override
    public int insertResOrder(ResOrder resOrder)
    {
        resOrder.setCreateTime(DateUtils.getNowDate());
        return resOrderMapper.insertResOrder(resOrder);
    }

    @Override
    public int updateResOrder(ResOrder resOrder)
    {
        resOrder.setUpdateTime(DateUtils.getNowDate());
        return resOrderMapper.updateResOrder(resOrder);
    }

    @Override
    public int deleteResOrderByIds(Long[] ids)
    {
        return resOrderMapper.deleteResOrderByIds(ids);
    }

    @Override
    public int deleteResOrderById(Long orderId)
    {
        return resOrderMapper.deleteResOrderById(orderId);
    }
}
