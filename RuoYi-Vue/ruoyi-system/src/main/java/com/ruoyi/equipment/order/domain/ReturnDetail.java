package com.ruoyi.equipment.order.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ReturnDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long detailId;
    private Long orderId;
    private Long equipmentId;
    private Long unitId;
    private String unitCode;
    private String returnStatus;
    private String damageRemark;
    private Integer returnQuantity;
    private Integer damageQuantity;

    public Long getDetailId()
    {
        return detailId;
    }

    public void setDetailId(Long detailId)
    {
        this.detailId = detailId;
    }

    public Long getOrderId()
    {
        return orderId;
    }

    public void setOrderId(Long orderId)
    {
        this.orderId = orderId;
    }

    public Long getEquipmentId()
    {
        return equipmentId;
    }

    public void setEquipmentId(Long equipmentId)
    {
        this.equipmentId = equipmentId;
    }

    public Long getUnitId()
    {
        return unitId;
    }

    public void setUnitId(Long unitId)
    {
        this.unitId = unitId;
    }

    public String getUnitCode()
    {
        return unitCode;
    }

    public void setUnitCode(String unitCode)
    {
        this.unitCode = unitCode;
    }

    public String getReturnStatus()
    {
        return returnStatus;
    }

    public void setReturnStatus(String returnStatus)
    {
        this.returnStatus = returnStatus;
    }

    public String getDamageRemark()
    {
        return damageRemark;
    }

    public void setDamageRemark(String damageRemark)
    {
        this.damageRemark = damageRemark;
    }

    public Integer getReturnQuantity()
    {
        return returnQuantity;
    }

    public void setReturnQuantity(Integer returnQuantity)
    {
        this.returnQuantity = returnQuantity;
    }

    public Integer getDamageQuantity()
    {
        return damageQuantity;
    }

    public void setDamageQuantity(Integer damageQuantity)
    {
        this.damageQuantity = damageQuantity;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("detailId", getDetailId())
            .append("orderId", getOrderId())
            .append("equipmentId", getEquipmentId())
            .append("unitId", getUnitId())
            .append("unitCode", getUnitCode())
            .append("returnStatus", getReturnStatus())
            .append("damageRemark", getDamageRemark())
            .append("returnQuantity", getReturnQuantity())
            .append("damageQuantity", getDamageQuantity())
            .append("createTime", getCreateTime())
            .toString();
    }
}
