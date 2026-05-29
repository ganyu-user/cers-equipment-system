package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysMsg;
import com.ruoyi.system.domain.SysMsgRead;

public interface SysMsgMapper
{
    List<SysMsg> selectSysMsgList(SysMsg msg);

    SysMsg selectSysMsgById(Long msgId);

    int insertSysMsg(SysMsg msg);

    int updateSysMsg(SysMsg msg);

    int deleteSysMsgById(Long msgId);

    int deleteSysMsgByIds(Long[] msgIds);

    List<SysMsg> selectSysMsgListByUserId(SysMsg msg);
}