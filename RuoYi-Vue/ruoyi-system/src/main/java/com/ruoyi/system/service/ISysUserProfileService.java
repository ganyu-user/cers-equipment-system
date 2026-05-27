package com.ruoyi.system.service;

import com.ruoyi.system.domain.SysUserProfile;

public interface ISysUserProfileService
{
    public SysUserProfile selectSysUserProfileByUserId(Long userId);
    public int insertSysUserProfile(SysUserProfile profile);
    public int updateSysUserProfile(SysUserProfile profile);
}
