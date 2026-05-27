package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.SysUserProfile;

public interface SysUserProfileMapper
{
    public SysUserProfile selectSysUserProfileByUserId(Long userId);
    public int insertSysUserProfile(SysUserProfile profile);
    public int updateSysUserProfile(SysUserProfile profile);
}
