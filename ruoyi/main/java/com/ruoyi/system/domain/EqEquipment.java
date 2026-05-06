package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备对象 eq_equipment
 * 
 * @author ganyu
 * @date 2026-05-06
 */
public class EqEquipment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    private Long equipmentId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long categoryId;

    /** 设备图片URL */
    private String image;

    /** 设备总库存 */
    @Excel(name = "设备总库存")
    private Long totalStock;

    /** 剩余可用数量 */
    @Excel(name = "剩余可用数量")
    private Long remainStock;

    /** 维修状态（0正常 1维修中） */
    @Excel(name = "维修状态", readConverterExp = "0=正常,1=维修中")
    private String status;

    /** 存放地点 */
    @Excel(name = "存放地点")
    private String location;

    /** 设备描述/备注 */
    private String description;

    /** 删除标志（0正常 2删除） */
    private String delFlag;

    public void setEquipmentId(Long equipmentId) 
    {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId() 
    {
        return equipmentId;
    }

    public void setEquipmentName(String equipmentName) 
    {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentName() 
    {
        return equipmentName;
    }

    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }

    public void setImage(String image) 
    {
        this.image = image;
    }

    public String getImage() 
    {
        return image;
    }

    public void setTotalStock(Long totalStock) 
    {
        this.totalStock = totalStock;
    }

    public Long getTotalStock() 
    {
        return totalStock;
    }

    public void setRemainStock(Long remainStock) 
    {
        this.remainStock = remainStock;
    }

    public Long getRemainStock() 
    {
        return remainStock;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setLocation(String location) 
    {
        this.location = location;
    }

    public String getLocation() 
    {
        return location;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("equipmentId", getEquipmentId())
            .append("equipmentName", getEquipmentName())
            .append("categoryId", getCategoryId())
            .append("image", getImage())
            .append("totalStock", getTotalStock())
            .append("remainStock", getRemainStock())
            .append("status", getStatus())
            .append("location", getLocation())
            .append("description", getDescription())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
