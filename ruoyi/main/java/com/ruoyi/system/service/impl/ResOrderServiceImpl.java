package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ResOrderMapper;
import com.ruoyi.system.domain.ResOrder;
import com.ruoyi.system.service.IResOrderService;

/**
 * 设备预约单管理Service业务层处理
 * 
 * @author ganyu
 * @date 2026-05-07
 */
@Service
public class ResOrderServiceImpl implements IResOrderService 
{
    @Autowired
    private ResOrderMapper resOrderMapper;

    /**
     * 查询设备预约单管理
     * 
     * @param orderId 设备预约单管理主键
     * @return 设备预约单管理
     */
    @Override
    public ResOrder selectResOrderByOrderId(Long orderId)
    {
        return resOrderMapper.selectResOrderByOrderId(orderId);
    }

    /**
     * 查询设备预约单管理列表
     * 
     * @param resOrder 设备预约单管理
     * @return 设备预约单管理
     */
    @Override
    public List<ResOrder> selectResOrderList(ResOrder resOrder)
    {
        return resOrderMapper.selectResOrderList(resOrder);
    }

    /**
     * 新增设备预约单管理
     * 
     * @param resOrder 设备预约单管理
     * @return 结果
     */
    @Override
    public int insertResOrder(ResOrder resOrder)
    {
        resOrder.setCreateTime(DateUtils.getNowDate());
        return resOrderMapper.insertResOrder(resOrder);
    }

    /**
     * 修改设备预约单管理
     * 
     * @param resOrder 设备预约单管理
     * @return 结果
     */
    @Override
    public int updateResOrder(ResOrder resOrder)
    {
        resOrder.setUpdateTime(DateUtils.getNowDate());
        return resOrderMapper.updateResOrder(resOrder);
    }

    /**
     * 批量删除设备预约单管理
     * 
     * @param orderIds 需要删除的设备预约单管理主键
     * @return 结果
     */
    @Override
    public int deleteResOrderByOrderIds(Long[] orderIds)
    {
        return resOrderMapper.deleteResOrderByOrderIds(orderIds);
    }

    /**
     * 删除设备预约单管理信息
     * 
     * @param orderId 设备预约单管理主键
     * @return 结果
     */
    @Override
    public int deleteResOrderByOrderId(Long orderId)
    {
        return resOrderMapper.deleteResOrderByOrderId(orderId);
    }
}
