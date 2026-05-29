package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class SysMsg extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long msgId;
    private String msgType;
    private String title;
    private String content;
    private Long orderId;
    private Long senderId;
    private String senderName;
    private String priority;
    private String targetType;
    private String targetId;
    private String targetRole;

    private Long userId;

    private String delFlag;

    private String isRead;

    private String targetUserName;

    public Long getMsgId() { return msgId; }
    public void setMsgId(Long msgId) { this.msgId = msgId; }
    public String getMsgType() { return msgType; }
    public void setMsgType(String msgType) { this.msgType = msgType; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public Long getSenderId() { return senderId; }
    public void setSenderId(Long senderId) { this.senderId = senderId; }
    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }
    public String getTargetType() { return targetType; }
    public void setTargetType(String targetType) { this.targetType = targetType; }
    public String getTargetId() { return targetId; }
    public void setTargetId(String targetId) { this.targetId = targetId; }
    public String getTargetRole() { return targetRole; }
    public void setTargetRole(String targetRole) { this.targetRole = targetRole; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public String getIsRead() { return isRead; }
    public void setIsRead(String isRead) { this.isRead = isRead; }
    public String getTargetUserName() { return targetUserName; }
    public void setTargetUserName(String targetUserName) { this.targetUserName = targetUserName; }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("msgId", getMsgId())
            .append("msgType", getMsgType())
            .append("title", getTitle())
            .append("content", getContent())
            .append("orderId", getOrderId())
            .append("senderId", getSenderId())
            .append("senderName", getSenderName())
            .append("priority", getPriority())
            .append("targetType", getTargetType())
            .append("targetId", getTargetId())
            .append("targetRole", getTargetRole())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("delFlag", getDelFlag())
            .toString();
    }
}