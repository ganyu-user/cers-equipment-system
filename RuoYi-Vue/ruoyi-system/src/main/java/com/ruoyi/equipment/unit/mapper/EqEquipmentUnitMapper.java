package com.ruoyi.equipment.unit.mapper;

import java.util.List;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;

public interface EqEquipmentUnitMapper
{
    public EqEquipmentUnit selectEqEquipmentUnitById(Long unitId);

    public List<EqEquipmentUnit> selectEqEquipmentUnitList(EqEquipmentUnit eqEquipmentUnit);

    public List<EqEquipmentUnit> selectAvailableUnitsByEquipmentId(Long equipmentId);

    public int insertEqEquipmentUnit(EqEquipmentUnit eqEquipmentUnit);

    public int batchInsertEqEquipmentUnit(List<EqEquipmentUnit> unitList);

    public int updateEqEquipmentUnit(EqEquipmentUnit eqEquipmentUnit);

    public int deleteEqEquipmentUnitById(Long unitId);

    public int deleteEqEquipmentUnitByEquipmentId(Long equipmentId);
}