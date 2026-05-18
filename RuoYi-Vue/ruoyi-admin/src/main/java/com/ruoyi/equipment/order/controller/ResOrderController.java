package com.ruoyi.equipment.order.controller;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.service.IResOrderService;

/**
 * 预约订单Controller
 * 
 * @author ganyu
 * @date 2026-05-07
 */
@RestController
@RequestMapping("/system/resOrder")
public class ResOrderController extends BaseController
{
    @Autowired
    private IResOrderService resOrderService;

    /**
     * 查询预约订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:list')")
    @GetMapping("/list")
    public TableDataInfo list(ResOrder resOrder)
    {
        startPage();
        List<ResOrder> list = resOrderService.selectResOrderList(resOrder);
        return getDataTable(list);
    }

    /**
     * 查询我的预约订单
     */
    @GetMapping("/myList")
    public TableDataInfo myList(ResOrder resOrder)
    {
        startPage();
        List<ResOrder> list = resOrderService.selectMyOrderList(resOrder);
        return getDataTable(list);
    }

    /**
     * 导出预约订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:export')")
    @Log(title = "预约订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ResOrder resOrder)
    {
        List<ResOrder> list = resOrderService.selectResOrderList(resOrder);
        ExcelUtil<ResOrder> util = new ExcelUtil<ResOrder>(ResOrder.class);
        util.exportExcel(response, list, "预约订单数据");
    }

    /**
     * 获取预约订单详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:query')")
    @GetMapping(value = "/{orderId}")
    public AjaxResult getInfo(@PathVariable("orderId") Long orderId)
    {
        return success(resOrderService.selectResOrderById(orderId));
    }

    /**
     * 新增预约订单
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:add')")
    @Log(title = "预约订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ResOrder resOrder)
    {
        return toAjax(resOrderService.insertResOrder(resOrder));
    }

    /**
     * 修改预约订单
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:edit')")
    @Log(title = "预约订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ResOrder resOrder)
    {
        return toAjax(resOrderService.updateResOrder(resOrder));
    }

    /**
     * 删除预约订单
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:remove')")
    @Log(title = "预约订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds)
    {
        return toAjax(resOrderService.deleteResOrderByIds(orderIds));
    }

    /**
     * 审批通过
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:approve')")
    @Log(title = "预约订单审批", businessType = BusinessType.UPDATE)
    @PutMapping("/approve/{orderId}")
    public AjaxResult approve(@PathVariable Long orderId)
    {
        return toAjax(resOrderService.approveOrder(orderId));
    }

    /**
     * 审批拒绝
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:approve')")
    @Log(title = "预约订单拒绝", businessType = BusinessType.UPDATE)
    @PutMapping("/reject/{orderId}")
    public AjaxResult reject(@PathVariable Long orderId, @RequestBody Map<String, String> params)
    {
        String rejectReason = params.get("rejectReason");
        return toAjax(resOrderService.rejectOrder(orderId, rejectReason));
    }

    /**
     * 归还设备
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:return')")
    @Log(title = "预约订单归还", businessType = BusinessType.UPDATE)
    @PutMapping("/return/{orderId}")
    public AjaxResult returnOrder(@PathVariable Long orderId, @RequestBody Map<String, String> params)
    {
        String returnStatus = params.get("returnStatus");
        return toAjax(resOrderService.returnOrder(orderId, returnStatus));
    }
}