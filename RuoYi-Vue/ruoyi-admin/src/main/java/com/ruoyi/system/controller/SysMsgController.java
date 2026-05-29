package com.ruoyi.system.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SysMsg;
import com.ruoyi.system.service.ISysMsgService;

@RestController
@RequestMapping("/system/msg")
public class SysMsgController extends BaseController
{
    @Autowired
    private ISysMsgService sysMsgService;

    @PreAuthorize("@ss.hasPermi('system:msg:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysMsg msg)
    {
        startPage();
        List<SysMsg> list = sysMsgService.selectSysMsgList(msg);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('system:msg:query')")
    @GetMapping("/{msgId}")
    public AjaxResult getInfo(@PathVariable("msgId") Long msgId)
    {
        return success(sysMsgService.selectSysMsgById(msgId));
    }

    @PreAuthorize("@ss.hasPermi('system:msg:add')")
    @PostMapping
    public AjaxResult add(@RequestBody SysMsg msg)
    {
        msg.setSenderId(SecurityUtils.getUserId());
        msg.setSenderName(SecurityUtils.getUsername());
        msg.setCreateBy(SecurityUtils.getUsername());
        return toAjax(sysMsgService.insertSysMsg(msg));
    }

    @PreAuthorize("@ss.hasPermi('system:msg:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody SysMsg msg)
    {
        msg.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(sysMsgService.updateSysMsg(msg));
    }

    @PreAuthorize("@ss.hasPermi('system:msg:remove')")
    @DeleteMapping("/{msgIds}")
    public AjaxResult remove(@PathVariable Long[] msgIds)
    {
        return toAjax(sysMsgService.deleteSysMsgByIds(msgIds));
    }

    @GetMapping("/myList")
    public TableDataInfo myList(SysMsg msg)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        List<SysMsg> list = sysMsgService.selectMyMsgList(userId, msg);
        return getDataTable(list);
    }

    @GetMapping("/unreadCount")
    public AjaxResult unreadCount()
    {
        Long userId = SecurityUtils.getUserId();
        Long count = sysMsgService.getUnreadCount(userId);
        return success(count);
    }

    @PutMapping("/read")
    public AjaxResult read(@RequestBody List<Long> msgIds)
    {
        Long userId = SecurityUtils.getUserId();
        sysMsgService.markAsRead(userId, msgIds);
        return success();
    }

    @PutMapping("/readAll")
    public AjaxResult readAll()
    {
        Long userId = SecurityUtils.getUserId();
        sysMsgService.markAllAsRead(userId);
        return success();
    }
}