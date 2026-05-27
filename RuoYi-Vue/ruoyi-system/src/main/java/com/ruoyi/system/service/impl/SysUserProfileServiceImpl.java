package com.ruoyi.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SysUserProfile;
import com.ruoyi.system.mapper.SysUserProfileMapper;
import com.ruoyi.system.service.ISysUserProfileService;

@Service
public class SysUserProfileServiceImpl implements ISysUserProfileService
{
    @Autowired
    private SysUserProfileMapper profileMapper;

    @Override
    public SysUserProfile selectSysUserProfileByUserId(Long userId)
    {
        return profileMapper.selectSysUserProfileByUserId(userId);
    }

    @Override
    public int insertSysUserProfile(SysUserProfile profile)
    {
        profile.setCreateTime(DateUtils.getNowDate());
        return profileMapper.insertSysUserProfile(profile);
    }

    @Override
    public int updateSysUserProfile(SysUserProfile profile)
    {
        profile.setUpdateTime(DateUtils.getNowDate());
        return profileMapper.updateSysUserProfile(profile);
    }
}
