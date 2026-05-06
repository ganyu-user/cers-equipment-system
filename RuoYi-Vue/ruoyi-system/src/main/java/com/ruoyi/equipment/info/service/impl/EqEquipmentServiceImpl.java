package com.ruoyi.equipment.info.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.service.IEqEquipmentService;

/**
 * 设备Service业务层处理
 * 
 * @author ganyu
 * @date 2026-05-06
 */
@Service
public class EqEquipmentServiceImpl implements IEqEquipmentService 
{
    @Autowired
    private EqEquipmentMapper eqEquipmentMapper;

    /**
     * 查询设备
     * 
     * @param equipmentId 设备主键
     * @return 设备
     */
    @Override
    public EqEquipment selectEqEquipmentByEquipmentId(Long equipmentId)
    {
        return eqEquipmentMapper.selectEqEquipmentByEquipmentId(equipmentId);
    }

    /**
     * 查询设备列表
     * 
     * @param eqEquipment 设备
     * @return 设备
     */
    @Override
    public List<EqEquipment> selectEqEquipmentList(EqEquipment eqEquipment)
    {
        return eqEquipmentMapper.selectEqEquipmentList(eqEquipment);
    }

    /**
     * 新增设备
     * 
     * @param eqEquipment 设备
     * @return 结果
     */
    @Override
    public int insertEqEquipment(EqEquipment eqEquipment)
    {
        eqEquipment.setCreateTime(DateUtils.getNowDate());
        return eqEquipmentMapper.insertEqEquipment(eqEquipment);
    }

    /**
     * 修改设备
     * 
     * @param eqEquipment 设备
     * @return 结果
     */
    @Override
    public int updateEqEquipment(EqEquipment eqEquipment)
    {
        eqEquipment.setUpdateTime(DateUtils.getNowDate());
        return eqEquipmentMapper.updateEqEquipment(eqEquipment);
    }

    /**
     * 批量删除设备
     * 
     * @param equipmentIds 需要删除的设备主键
     * @return 结果
     */
    @Override
    public int deleteEqEquipmentByEquipmentIds(Long[] equipmentIds)
    {
        return eqEquipmentMapper.deleteEqEquipmentByEquipmentIds(equipmentIds);
    }

    /**
     * 删除设备信息
     * 
     * @param equipmentId 设备主键
     * @return 结果
     */
    @Override
    public int deleteEqEquipmentByEquipmentId(Long equipmentId)
    {
        return eqEquipmentMapper.deleteEqEquipmentByEquipmentId(equipmentId);
    }
}
