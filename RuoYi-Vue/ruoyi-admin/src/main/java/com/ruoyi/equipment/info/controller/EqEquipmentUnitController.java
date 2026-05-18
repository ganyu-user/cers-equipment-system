package com.ruoyi.equipment.info.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.equipment.unit.domain.EqEquipmentUnit;
import com.ruoyi.equipment.unit.mapper.EqEquipmentUnitMapper;
import com.ruoyi.equipment.info.domain.EqEquipment;
import com.ruoyi.equipment.info.mapper.EqEquipmentMapper;

@RestController
@RequestMapping("/system/equipment/unit")
public class EqEquipmentUnitController extends BaseController
{
    @Autowired
    private EqEquipmentUnitMapper eqEquipmentUnitMapper;

    @Autowired
    private EqEquipmentMapper eqEquipmentMapper;

    @PreAuthorize("@ss.hasPermi('system:equipment:list')")
    @GetMapping("/list")
    public TableDataInfo list(EqEquipmentUnit eqEquipmentUnit)
    {
        startPage();
        List<EqEquipmentUnit> list = eqEquipmentUnitMapper.selectEqEquipmentUnitList(eqEquipmentUnit);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('system:equipment:edit')")
    @Log(title = "设备单元", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EqEquipmentUnit eqEquipmentUnit)
    {
        EqEquipmentUnit oldUnit = eqEquipmentUnitMapper.selectEqEquipmentUnitById(eqEquipmentUnit.getUnitId());
        if (oldUnit == null)
        {
            return error("设备单元不存在");
        }

        String oldStatus = oldUnit.getStatus();
        String newStatus = eqEquipmentUnit.getStatus();

        eqEquipmentUnit.setUpdateTime(DateUtils.getNowDate());
        int rows = eqEquipmentUnitMapper.updateEqEquipmentUnit(eqEquipmentUnit);

        if (!oldStatus.equals(newStatus))
        {
            syncEquipmentStock(oldUnit.getEquipmentId(), oldStatus, newStatus);
        }

        return toAjax(rows);
    }

    @PreAuthorize("@ss.hasPermi('system:equipment:edit')")
    @Log(title = "设备单元", businessType = BusinessType.UPDATE)
    @PutMapping("/batch")
    public AjaxResult batchEdit(@RequestBody Map<String, Object> params)
    {
        @SuppressWarnings("unchecked")
        List<Integer> idList = (List<Integer>) params.get("unitIds");
        if (idList == null || idList.isEmpty())
        {
            return error("请选择至少一个设备单元");
        }

        Long[] unitIds = idList.stream().map(Long::valueOf).toArray(Long[]::new);
        String status = (String) params.get("status");
        String returnStatus = (String) params.get("returnStatus");
        String damageRemark = (String) params.get("damageRemark");

        if (status != null && !status.isEmpty())
        {
            for (Long unitId : unitIds)
            {
                EqEquipmentUnit oldUnit = eqEquipmentUnitMapper.selectEqEquipmentUnitById(unitId);
                if (oldUnit != null && !status.equals(oldUnit.getStatus()))
                {
                    syncEquipmentStock(oldUnit.getEquipmentId(), oldUnit.getStatus(), status);
                }
            }
        }

        int rows = eqEquipmentUnitMapper.batchUpdateEqEquipmentUnit(unitIds, status, returnStatus, damageRemark);
        return toAjax(rows);
    }

    private void syncEquipmentStock(Long equipmentId, String oldStatus, String newStatus)
    {
        EqEquipment equipment = eqEquipmentMapper.selectEqEquipmentByEquipmentId(equipmentId);
        if (equipment == null) return;

        boolean oldUnusable = "2".equals(oldStatus) || "3".equals(oldStatus);
        boolean newUnusable = "2".equals(newStatus) || "3".equals(newStatus);

        if (oldUnusable && !newUnusable)
        {
            equipment.setRemainStock(equipment.getRemainStock() + 1);
        }
        else if (!oldUnusable && newUnusable)
        {
            equipment.setRemainStock(Math.max(equipment.getRemainStock() - 1, 0));
        }
        else
        {
            return;
        }

        equipment.setUpdateTime(DateUtils.getNowDate());
        eqEquipmentMapper.updateEqEquipment(equipment);
    }
}