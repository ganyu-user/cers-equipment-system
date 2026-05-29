package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysMsgRead;

public interface SysMsgReadMapper
{
    int insertSysMsgRead(SysMsgRead msgRead);

    int batchInsertSysMsgRead(List<SysMsgRead> list);

    SysMsgRead selectSysMsgRead(Long userId, Long msgId);

    List<SysMsgRead> selectSysMsgReadByUserId(Long userId);

    Long countUnreadByUserId(Long userId);
}