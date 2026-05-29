package com.ruoyi.system.domain;

import java.util.Date;

public class SysMsgRead
{
    private Long readId;
    private Long msgId;
    private Long userId;
    private Date readTime;

    public Long getReadId() { return readId; }
    public void setReadId(Long readId) { this.readId = readId; }
    public Long getMsgId() { return msgId; }
    public void setMsgId(Long msgId) { this.msgId = msgId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Date getReadTime() { return readTime; }
    public void setReadTime(Date readTime) { this.readTime = readTime; }
}