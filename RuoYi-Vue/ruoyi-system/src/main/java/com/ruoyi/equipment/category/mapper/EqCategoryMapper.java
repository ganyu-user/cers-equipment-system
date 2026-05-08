package com.ruoyi.equipment.category.mapper;

import java.util.List;
import com.ruoyi.equipment.category.domain.EqCategory;

/**
 * 设备分类Mapper接口
 * 
 * @author ganyu
 * @date 2026-05-06
 */
public interface EqCategoryMapper 
{
    /**
     * 查询设备分类
     * 
     * @param categoryId 设备分类主键
     * @return 设备分类
     */
    public EqCategory selectEqCategoryByCategoryId(Long categoryId);

    /**
     * 查询设备分类列表
     * 
     * @param eqCategory 设备分类
     * @return 设备分类集合
     */
    public List<EqCategory> selectEqCategoryList(EqCategory eqCategory);

    /**
     * 新增设备分类
     * 
     * @param eqCategory 设备分类
     * @return 结果
     */
    public int insertEqCategory(EqCategory eqCategory);

    /**
     * 修改设备分类
     * 
     * @param eqCategory 设备分类
     * @return 结果
     */
    public int updateEqCategory(EqCategory eqCategory);

    /**
     * 删除设备分类
     * 
     * @param categoryId 设备分类主键
     * @return 结果
     */
    public int deleteEqCategoryByCategoryId(Long categoryId);

    /**
     * 批量删除设备分类
     * 
     * @param categoryIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEqCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 查询指定分类的所有子孙分类ID（包含自身）
     * 
     * @param categoryId 分类ID
     * @return 子孙分类ID集合
     */
    public List<Long> selectChildrenCategoryIds(Long categoryId);
}
