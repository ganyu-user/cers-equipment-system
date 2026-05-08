package com.ruoyi.equipment.category.controller;

import java.util.List;
import java.util.Iterator;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.equipment.category.domain.EqCategory;
import com.ruoyi.equipment.category.service.IEqCategoryService;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 设备分类Controller
 * 
 * @author ganyu
 * @date 2026-05-06
 */
@RestController
@RequestMapping("/system/category")
public class EqCategoryController extends BaseController
{
    private final IEqCategoryService eqCategoryService;

    public EqCategoryController(IEqCategoryService eqCategoryService) {
        this.eqCategoryService = eqCategoryService;
    }

    /**
     * 查询设备分类列表
     *
     */
    @PreAuthorize("@ss.hasPermi('system:category:list')")
    @GetMapping("/list")
    public AjaxResult list(EqCategory eqCategory)
    {
        List<EqCategory> list = eqCategoryService.selectEqCategoryList(eqCategory);
        return success(list);
    }

    /**
     * 导出设备分类列表
     */
    @PreAuthorize("@ss.hasPermi('system:category:export')")
    @Log(title = "设备分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EqCategory eqCategory)
    {
        List<EqCategory> list = eqCategoryService.selectEqCategoryList(eqCategory);
        ExcelUtil<EqCategory> util = new ExcelUtil<EqCategory>(EqCategory.class);
        util.exportExcel(response, list, "设备分类数据");
    }

    /**
     * 获取设备分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:category:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId)
    {
        return success(eqCategoryService.selectEqCategoryByCategoryId(categoryId));
    }

    /**
     * 新增设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:add')")
    @Log(title = "设备分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EqCategory eqCategory)
    {
        return toAjax(eqCategoryService.insertEqCategory(eqCategory));
    }

    /**
     * 修改设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:edit')")
    @Log(title = "设备分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EqCategory eqCategory)
    {
        return toAjax(eqCategoryService.updateEqCategory(eqCategory));
    }

    /**
     * 删除设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:remove')")
    @Log(title = "设备分类", businessType = BusinessType.DELETE)
	@DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds)
    {
        return toAjax(eqCategoryService.deleteEqCategoryByCategoryIds(categoryIds));
    }

    /**
     * 获取设备分类树列表
     */
    @GetMapping("/treeselect")
    public AjaxResult treeselect()
    {
        List<EqCategory> list = eqCategoryService.selectEqCategoryList(new EqCategory());
        return success(getCategoryTree(list));
    }

    private List<EqCategory> getCategoryTree(List<EqCategory> list)
    {
        List<EqCategory> returnList = new java.util.ArrayList<EqCategory>();
        List<Long> tempList = new java.util.ArrayList<Long>();
        for (EqCategory category : list)
        {
            tempList.add(category.getCategoryId());
        }
        for (Iterator<EqCategory> iterator = list.iterator(); iterator.hasNext();)
        {
            EqCategory category = iterator.next();
            if (!tempList.contains(category.getParentId()))
            {
                recursionFn(list, category);
                returnList.add(category);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = list;
        }
        return returnList;
    }

    private void recursionFn(List<EqCategory> list, EqCategory category)
    {
        List<EqCategory> childList = getChildList(list, category);
        category.setChildren(childList);
        for (EqCategory childCategory : childList)
        {
            if (hasChild(list, childCategory))
            {
                Iterator<EqCategory> it = childList.iterator();
                while (it.hasNext())
                {
                    EqCategory n = it.next();
                    recursionFn(list, n);
                }
            }
        }
    }

    private List<EqCategory> getChildList(List<EqCategory> list, EqCategory category)
    {
        List<EqCategory> childList = new java.util.ArrayList<EqCategory>();
        Iterator<EqCategory> it = list.iterator();
        while (it.hasNext())
        {
            EqCategory n = it.next();
            if (n.getParentId() != null && n.getParentId().longValue() == category.getCategoryId().longValue())
            {
                childList.add(n);
            }
        }
        return childList;
    }

    private boolean hasChild(List<EqCategory> list, EqCategory category)
    {
        return getChildList(list, category).size() > 0;
    }
}
