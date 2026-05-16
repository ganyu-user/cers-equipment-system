package com.ruoyi.equipment.info.service.impl;

import java.util.ArrayList;
import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.service.IEqEquipmentService;
import com.ruoyi.equipment.category.service.IEqCategoryService;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;
import com.ruoyi.equipment.unit.mapper.EqEquipmentUnitMapper;

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

    @Autowired
    private EqEquipmentUnitMapper eqEquipmentUnitMapper;

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
    @Transactional(rollbackFor = Exception.class)
    public int insertEqEquipment(EqEquipment eqEquipment)
    {
        eqEquipment.setCreateTime(DateUtils.getNowDate());

        if (eqEquipment.getDelFlag() == null || eqEquipment.getDelFlag().isEmpty()) {
            eqEquipment.setDelFlag("0");
        }

        if (eqEquipment.getTrackUnit() == null || eqEquipment.getTrackUnit().isEmpty()) {
            eqEquipment.setTrackUnit("0");
        }

        if (eqEquipment.getRemainStock() == null && eqEquipment.getTotalStock() != null) {
            eqEquipment.setRemainStock(eqEquipment.getTotalStock());
        }

        if (eqEquipment.getCreateBy() == null || eqEquipment.getCreateBy().isEmpty()) {
            eqEquipment.setCreateBy(SecurityUtils.getUsername());
        }

        int rows = eqEquipmentMapper.insertEqEquipment(eqEquipment);

        if ("1".equals(eqEquipment.getTrackUnit()) && eqEquipment.getTotalStock() != null && eqEquipment.getTotalStock() > 0)
        {
            String prefix = eqEquipment.getUnitCodePrefix();
            if (prefix == null || prefix.trim().isEmpty())
            {
                prefix = eqEquipment.getEquipmentName();
            }

            List<EqEquipmentUnit> unitList = new ArrayList<>();
            for (int i = 1; i <= eqEquipment.getTotalStock(); i++)
            {
                EqEquipmentUnit unit = new EqEquipmentUnit();
                unit.setEquipmentId(eqEquipment.getEquipmentId());
                unit.setUnitCode(prefix + "-" + String.format("%03d", i));
                unit.setStatus("0");
                unit.setCreateTime(DateUtils.getNowDate());
                unitList.add(unit);
            }
            eqEquipmentUnitMapper.batchInsertEqEquipmentUnit(unitList);
        }

        return rows;
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
