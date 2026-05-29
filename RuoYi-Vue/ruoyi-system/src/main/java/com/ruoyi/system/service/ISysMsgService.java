package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysMsg;

public interface ISysMsgService
{
    SysMsg selectSysMsgById(Long msgId);

    List<SysMsg> selectSysMsgList(SysMsg msg);

    List<SysMsg> selectMyMsgList(Long userId, SysMsg msg);

    Long getUnreadCount(Long userId);

    int insertSysMsg(SysMsg msg);

    int updateSysMsg(SysMsg msg);

    int deleteSysMsgByIds(Long[] msgIds);

    void sendMsgToUser(Long userId, String msgType, String title, String content, Long orderId);

    void sendMsgToAll(String msgType, String title, String content);

    void sendMsgToRole(String roleKey, String msgType, String title, String content, Long orderId);

    void markAsRead(Long userId, List<Long> msgIds);

    void markAllAsRead(Long userId);
}