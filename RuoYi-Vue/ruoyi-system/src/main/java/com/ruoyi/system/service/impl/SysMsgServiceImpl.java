package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SysMsg;
import com.ruoyi.system.domain.SysMsgRead;
import com.ruoyi.system.mapper.SysMsgMapper;
import com.ruoyi.system.mapper.SysMsgReadMapper;
import com.ruoyi.system.service.ISysMsgService;

@Service
public class SysMsgServiceImpl implements ISysMsgService
{
    @Autowired
    private SysMsgMapper sysMsgMapper;

    @Autowired
    private SysMsgReadMapper sysMsgReadMapper;

    @Override
    public SysMsg selectSysMsgById(Long msgId)
    {
        return sysMsgMapper.selectSysMsgById(msgId);
    }

    @Override
    public List<SysMsg> selectSysMsgList(SysMsg msg)
    {
        return sysMsgMapper.selectSysMsgList(msg);
    }

    @Override
    public List<SysMsg> selectMyMsgList(Long userId, SysMsg msg)
    {
        msg.setUserId(userId);
        return sysMsgMapper.selectSysMsgListByUserId(msg);
    }

    @Override
    public Long getUnreadCount(Long userId)
    {
        return sysMsgReadMapper.countUnreadByUserId(userId);
    }

    @Override
    public int insertSysMsg(SysMsg msg)
    {
        msg.setCreateTime(DateUtils.getNowDate());
        return sysMsgMapper.insertSysMsg(msg);
    }

    @Override
    public int updateSysMsg(SysMsg msg)
    {
        msg.setUpdateTime(DateUtils.getNowDate());
        return sysMsgMapper.updateSysMsg(msg);
    }

    @Override
    public int deleteSysMsgByIds(Long[] msgIds)
    {
        return sysMsgMapper.deleteSysMsgByIds(msgIds);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendMsgToUser(Long userId, String msgType, String title, String content, Long orderId)
    {
        SysMsg msg = new SysMsg();
        msg.setMsgType(msgType);
        msg.setTitle(title);
        msg.setContent(content);
        msg.setOrderId(orderId);
        msg.setSenderId(null);
        msg.setSenderName("系统");
        msg.setPriority("normal");
        msg.setTargetType("user");
        msg.setTargetId(String.valueOf(userId));
        msg.setCreateBy("system");
        msg.setCreateTime(DateUtils.getNowDate());
        sysMsgMapper.insertSysMsg(msg);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendMsgToAll(String msgType, String title, String content)
    {
        SysMsg msg = new SysMsg();
        msg.setMsgType(msgType);
        msg.setTitle(title);
        msg.setContent(content);
        msg.setSenderId(null);
        msg.setSenderName("系统");
        msg.setPriority("normal");
        msg.setTargetType("all");
        msg.setCreateBy("system");
        msg.setCreateTime(DateUtils.getNowDate());
        sysMsgMapper.insertSysMsg(msg);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendMsgToRole(String roleKey, String msgType, String title, String content, Long orderId)
    {
        SysMsg msg = new SysMsg();
        msg.setMsgType(msgType);
        msg.setTitle(title);
        msg.setContent(content);
        msg.setOrderId(orderId);
        msg.setSenderId(null);
        msg.setSenderName("系统");
        msg.setPriority("normal");
        msg.setTargetType("role");
        msg.setTargetRole(roleKey);
        msg.setCreateBy("system");
        msg.setCreateTime(DateUtils.getNowDate());
        sysMsgMapper.insertSysMsg(msg);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void markAsRead(Long userId, List<Long> msgIds)
    {
        Date now = DateUtils.getNowDate();
        List<SysMsgRead> list = new ArrayList<>();
        for (Long msgId : msgIds)
        {
            SysMsgRead read = new SysMsgRead();
            read.setMsgId(msgId);
            read.setUserId(userId);
            read.setReadTime(now);
            list.add(read);
        }
        if (!list.isEmpty())
        {
            sysMsgReadMapper.batchInsertSysMsgRead(list);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void markAllAsRead(Long userId)
    {
        SysMsg query = new SysMsg();
        query.setUserId(userId);
        List<SysMsg> allMsgs = sysMsgMapper.selectSysMsgListByUserId(query);

        List<Long> msgIds = new ArrayList<>();
        for (SysMsg msg : allMsgs)
        {
            SysMsgRead existing = sysMsgReadMapper.selectSysMsgRead(userId, msg.getMsgId());
            if (existing == null)
            {
                msgIds.add(msg.getMsgId());
            }
        }
        if (!msgIds.isEmpty())
        {
            markAsRead(userId, msgIds);
        }
    }
}