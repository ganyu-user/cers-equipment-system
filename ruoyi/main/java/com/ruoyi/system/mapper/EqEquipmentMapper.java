package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EqEquipment;

/**
 * 设备Mapper接口
 * 
 * @author ganyu
 * @date 2026-05-06
 */
public interface EqEquipmentMapper 
{
    /**
     * 查询设备
     * 
     * @param equipmentId 设备主键
     * @return 设备
     */
    public EqEquipment selectEqEquipmentByEquipmentId(Long equipmentId);

    /**
     * 查询设备列表
     * 
     * @param eqEquipment 设备
     * @return 设备集合
     */
    public List<EqEquipment> selectEqEquipmentList(EqEquipment eqEquipment);

    /**
     * 新增设备
     * 
     * @param eqEquipment 设备
     * @return 结果
     */
    public int insertEqEquipment(EqEquipment eqEquipment);

    /**
     * 修改设备
     * 
     * @param eqEquipment 设备
     * @return 结果
     */
    public int updateEqEquipment(EqEquipment eqEquipment);

    /**
     * 删除设备
     * 
     * @param equipmentId 设备主键
     * @return 结果
     */
    public int deleteEqEquipmentByEquipmentId(Long equipmentId);

    /**
     * 批量删除设备
     * 
     * @param equipmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEqEquipmentByEquipmentIds(Long[] equipmentIds);
}
