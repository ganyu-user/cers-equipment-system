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
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.equipment.order.domain.ResOrder;
import com.ruoyi.equipment.order.service.IResOrderService;
import com.ruoyi.equipment.order.task.OrderMsgTask;
import com.ruoyi.system.domain.SysUserProfile;
import com.ruoyi.system.service.ISysUserProfileService;

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

    @Autowired
    private ISysUserProfileService sysUserProfileService;

    @Autowired
    private OrderMsgTask orderMsgTask;

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
     * 归还设备（直接归还，兼容旧逻辑）
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:return')")
    @Log(title = "预约订单归还", businessType = BusinessType.UPDATE)
    @PutMapping("/return/{orderId}")
    public AjaxResult returnOrder(@PathVariable Long orderId, @RequestBody Map<String, String> params)
    {
        String returnStatus = params.get("returnStatus");
        return toAjax(resOrderService.returnOrder(orderId, returnStatus));
    }

    /**
     * 用户发起归还申请
     */
    @PutMapping("/initiateReturn/{orderId}")
    public AjaxResult initiateReturn(@PathVariable Long orderId)
    {
        return toAjax(resOrderService.initiateReturn(orderId));
    }

    /**
     * 管理员核验归还
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:return')")
    @Log(title = "归还核验", businessType = BusinessType.UPDATE)
    @PutMapping("/verifyReturn/{orderId}")
    public AjaxResult verifyReturn(@PathVariable Long orderId, @RequestBody Map<String, Object> params)
    {
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> verifyDetails = (List<Map<String, Object>>) params.get("verifyDetails");
        return toAjax(resOrderService.verifyReturn(orderId, verifyDetails));
    }

    /**
     * 获取归还核验明细
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:query')")
    @GetMapping("/returnDetail/{orderId}")
    public AjaxResult getReturnDetail(@PathVariable Long orderId)
    {
        return success(resOrderService.getReturnDetailList(orderId));
    }

    /**
     * 用户端新增预约（无需特殊权限）
     */
    @PostMapping("/userAdd")
    public AjaxResult userAdd(@RequestBody ResOrder resOrder)
    {
        resOrder.setUserId(SecurityUtils.getUserId());
        return toAjax(resOrderService.insertResOrder(resOrder));
    }

    /**
     * 用户取消预约
     */
    @PutMapping("/cancel/{orderId}")
    public AjaxResult cancel(@PathVariable Long orderId)
    {
        return toAjax(resOrderService.cancelOrder(orderId));
    }

    /**
     * 用户端预约详情（无需特殊权限，只能查自己的）
     */
    @GetMapping("/userDetail/{orderId}")
    public AjaxResult userDetail(@PathVariable("orderId") Long orderId)
    {
        ResOrder order = resOrderService.selectResOrderById(orderId);
        if (order == null)
        {
            return error("订单不存在");
        }
        Long currentUserId = SecurityUtils.getUserId();
        if (!currentUserId.equals(order.getUserId()))
        {
            return error("只能查看自己的订单");
        }
        return success(order);
    }

    /**
     * 获取当前登录用户的个人资料
     */
    @GetMapping("/myProfile")
    public AjaxResult myProfile()
    {
        Long userId = SecurityUtils.getUserId();
        SysUserProfile profile = sysUserProfileService.selectSysUserProfileByUserId(userId);
        return success(profile != null ? profile : new SysUserProfile());
    }

    /**
     * 管理员催还
     */
    @PreAuthorize("@ss.hasPermi('system:resOrder:edit')")
    @Log(title = "催还提醒", businessType = BusinessType.UPDATE)
    @PutMapping("/urgeReturn/{orderId}")
    public AjaxResult urgeReturn(@PathVariable Long orderId)
    {
        int result = orderMsgTask.urgeReturn(orderId);
        return result > 0 ? success("催还消息已发送") : error("催还失败，请检查订单状态");
    }
}
