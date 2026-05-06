package com.ruoyi.system.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.EqEquipment;
import com.ruoyi.system.service.IEqEquipmentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备Controller
 * 
 * @author ganyu
 * @date 2026-05-06
 */
@RestController
@RequestMapping("/system/equipment")
public class EqEquipmentController extends BaseController
{
    @Autowired
    private IEqEquipmentService eqEquipmentService;

    /**
     * 查询设备列表
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:list')")
    @GetMapping("/list")
    public TableDataInfo list(EqEquipment eqEquipment)
    {
        startPage();
        List<EqEquipment> list = eqEquipmentService.selectEqEquipmentList(eqEquipment);
        return getDataTable(list);
    }

    /**
     * 导出设备列表
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:export')")
    @Log(title = "设备", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EqEquipment eqEquipment)
    {
        List<EqEquipment> list = eqEquipmentService.selectEqEquipmentList(eqEquipment);
        ExcelUtil<EqEquipment> util = new ExcelUtil<EqEquipment>(EqEquipment.class);
        util.exportExcel(response, list, "设备数据");
    }

    /**
     * 获取设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:query')")
    @GetMapping(value = "/{equipmentId}")
    public AjaxResult getInfo(@PathVariable("equipmentId") Long equipmentId)
    {
        return success(eqEquipmentService.selectEqEquipmentByEquipmentId(equipmentId));
    }

    /**
     * 新增设备
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:add')")
    @Log(title = "设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EqEquipment eqEquipment)
    {
        return toAjax(eqEquipmentService.insertEqEquipment(eqEquipment));
    }

    /**
     * 修改设备
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:edit')")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EqEquipment eqEquipment)
    {
        return toAjax(eqEquipmentService.updateEqEquipment(eqEquipment));
    }

    /**
     * 删除设备
     */
    @PreAuthorize("@ss.hasPermi('system:equipment:remove')")
    @Log(title = "设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{equipmentIds}")
    public AjaxResult remove(@PathVariable Long[] equipmentIds)
    {
        return toAjax(eqEquipmentService.deleteEqEquipmentByEquipmentIds(equipmentIds));
    }
}
