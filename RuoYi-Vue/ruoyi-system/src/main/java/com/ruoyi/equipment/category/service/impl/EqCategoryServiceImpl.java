package com.ruoyi.equipment.category.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.equipment.category.mapper.EqCategoryMapper;
import com.ruoyi.equipment.category.domain.EqCategory;
import com.ruoyi.equipment.category.service.IEqCategoryService;

/**
 * 设备分类Service业务层处理
 * 
 * @author ganyu
 * @date 2026-05-06
 */
@Service
public class EqCategoryServiceImpl implements IEqCategoryService 
{
    @Autowired
    private EqCategoryMapper eqCategoryMapper;

    /**
     * 查询设备分类
     * 
     * @param categoryId 设备分类主键
     * @return 设备分类
     */
    @Override
    public EqCategory selectEqCategoryByCategoryId(Long categoryId)
    {
        return eqCategoryMapper.selectEqCategoryByCategoryId(categoryId);
    }

    /**
     * 查询设备分类列表
     * 
     * @param eqCategory 设备分类
     * @return 设备分类
     */
    @Override
    public List<EqCategory> selectEqCategoryList(EqCategory eqCategory)
    {
        return eqCategoryMapper.selectEqCategoryList(eqCategory);
    }

    /**
     * 新增设备分类
     * 
     * @param eqCategory 设备分类
     * @return 结果
     */
    @Override
    public int insertEqCategory(EqCategory eqCategory)
    {
        eqCategory.setCreateTime(DateUtils.getNowDate());
        return eqCategoryMapper.insertEqCategory(eqCategory);
    }

    /**
     * 修改设备分类
     * 
     * @param eqCategory 设备分类
     * @return 结果
     */
    @Override
    public int updateEqCategory(EqCategory eqCategory)
    {
        eqCategory.setUpdateTime(DateUtils.getNowDate());
        return eqCategoryMapper.updateEqCategory(eqCategory);
    }

    /**
     * 批量删除设备分类
     * 
     * @param categoryIds 需要删除的设备分类主键
     * @return 结果
     */
    @Override
    public int deleteEqCategoryByCategoryIds(Long[] categoryIds)
    {
        return eqCategoryMapper.deleteEqCategoryByCategoryIds(categoryIds);
    }

    /**
     * 删除设备分类信息
     * 
     * @param categoryId 设备分类主键
     * @return 结果
     */
    @Override
    public int deleteEqCategoryByCategoryId(Long categoryId)
    {
        return eqCategoryMapper.deleteEqCategoryByCategoryId(categoryId);
    }
}
