package com.ruoyi.equipment.info.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.service.IEqEquipmentService;
import com.ruoyi.equipment.category.service.IEqCategoryService;

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

    @Autowired
    private IEqCategoryService eqCategoryService;

    @Override
    public EqEquipment selectEqEquipmentByEquipmentId(Long equipmentId)
    {
        return eqEquipmentMapper.selectEqEquipmentByEquipmentId(equipmentId);
    }

    @Override
    public List<EqEquipment> selectEqEquipmentList(EqEquipment eqEquipment)
    {
        if (eqEquipment.getCategoryId() != null)
        {
            List<Long> categoryIds = eqCategoryService.selectChildrenCategoryIds(eqEquipment.getCategoryId());
            eqEquipment.setCategoryIds(categoryIds);
        }
        return eqEquipmentMapper.selectEqEquipmentList(eqEquipment);
    }

    @Override
    public int insertEqEquipment(EqEquipment eqEquipment)
    {
        eqEquipment.setCreateTime(DateUtils.getNowDate());
        
        if (eqEquipment.getDelFlag() == null || eqEquipment.getDelFlag().isEmpty()) {
            eqEquipment.setDelFlag("0");
        }
        
        if (eqEquipment.getRemainStock() == null && eqEquipment.getTotalStock() != null) {
            eqEquipment.setRemainStock(eqEquipment.getTotalStock());
        }
        
        if (eqEquipment.getCreateBy() == null || eqEquipment.getCreateBy().isEmpty()) {
            eqEquipment.setCreateBy(SecurityUtils.getUsername());
        }
        
        return eqEquipmentMapper.insertEqEquipment(eqEquipment);
    }

    @Override
    public int updateEqEquipment(EqEquipment eqEquipment)
    {
        eqEquipment.setUpdateTime(DateUtils.getNowDate());
        return eqEquipmentMapper.updateEqEquipment(eqEquipment);
    }

    @Override
    public int deleteEqEquipmentByEquipmentIds(Long[] equipmentIds)
    {
        return eqEquipmentMapper.deleteEqEquipmentByEquipmentIds(equipmentIds);
    }

    @Override
    public int deleteEqEquipmentByEquipmentId(Long equipmentId)
    {
        return eqEquipmentMapper.deleteEqEquipmentByEquipmentId(equipmentId);
    }
}
