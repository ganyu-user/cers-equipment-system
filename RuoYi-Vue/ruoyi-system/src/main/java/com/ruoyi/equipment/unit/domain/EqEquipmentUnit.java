package com.ruoyi.equipment.unit.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

public class EqEquipmentUnit extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long unitId;

    @Excel(name = "所属设备ID")
    private Long equipmentId;

    @Excel(name = "设备编号")
    private String unitCode;

    @Excel(name = "状态", readConverterExp = "0=在库,1=借出,2=维修,3=报废")
    private String status;

    private Long borrowerId;

    private String borrowerName;

    private Long borrowOrderId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date borrowTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date expectedReturnTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date actualReturnTime;

    @Excel(name = "归还状态", readConverterExp = "0=未归还,1=正常归还,2=损坏归还")
    private String returnStatus;

    private String damageRemark;

    private Long categoryId;

    public void setUnitId(Long unitId)
    {
        this.unitId = unitId;
    }

    public Long getUnitId()
    {
        return unitId;
    }

    public void setEquipmentId(Long equipmentId)
    {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId()
    {
        return equipmentId;
    }

    public void setUnitCode(String unitCode)
    {
        this.unitCode = unitCode;
    }

    public String getUnitCode()
    {
        return unitCode;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }

    public void setBorrowerId(Long borrowerId)
    {
        this.borrowerId = borrowerId;
    }

    public Long getBorrowerId()
    {
        return borrowerId;
    }

    public void setBorrowerName(String borrowerName)
    {
        this.borrowerName = borrowerName;
    }

    public String getBorrowerName()
    {
        return borrowerName;
    }

    public void setBorrowOrderId(Long borrowOrderId)
    {
        this.borrowOrderId = borrowOrderId;
    }

    public Long getBorrowOrderId()
    {
        return borrowOrderId;
    }

    public void setBorrowTime(Date borrowTime)
    {
        this.borrowTime = borrowTime;
    }

    public Date getBorrowTime()
    {
        return borrowTime;
    }

    public void setExpectedReturnTime(Date expectedReturnTime)
    {
        this.expectedReturnTime = expectedReturnTime;
    }

    public Date getExpectedReturnTime()
    {
        return expectedReturnTime;
    }

    public void setActualReturnTime(Date actualReturnTime)
    {
        this.actualReturnTime = actualReturnTime;
    }

    public Date getActualReturnTime()
    {
        return actualReturnTime;
    }

    public void setReturnStatus(String returnStatus)
    {
        this.returnStatus = returnStatus;
    }

    public String getReturnStatus()
    {
        return returnStatus;
    }

    public void setDamageRemark(String damageRemark)
    {
        this.damageRemark = damageRemark;
    }

    public String getDamageRemark()
    {
        return damageRemark;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("unitId", getUnitId())
            .append("equipmentId", getEquipmentId())
            .append("unitCode", getUnitCode())
            .append("status", getStatus())
            .append("borrowerId", getBorrowerId())
            .append("borrowOrderId", getBorrowOrderId())
            .append("borrowTime", getBorrowTime())
            .append("expectedReturnTime", getExpectedReturnTime())
            .append("actualReturnTime", getActualReturnTime())
            .append("returnStatus", getReturnStatus())
            .append("damageRemark", getDamageRemark())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}