package com.ruoyi.equipment.order.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 预约订单对象 res_order
 * 
 * @author ganyu
 * @date 2026-05-07
 */
public class ResOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单ID */
    private Long orderId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户名称 */
    @Excel(name = "用户名称")
    private String userName;

    /** 预约时间 */
    @Excel(name = "预约时间")
    private String reserveTime;

    /** 预约状态（0待审核 1已通过 2已拒绝 3已取消） */
    @Excel(name = "预约状态", readConverterExp = "0=待审核,1=已通过,2=已拒绝,3=已取消")
    private String orderStatus;

    /** 设备ID */
    @Excel(name = "设备ID")
    private Long equipmentId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 设备图片 */
    private String equipmentImage;

    /** 预约数量 */
    @Excel(name = "预约数量")
    private Integer quantity;

    /** 预计归还时间 */
    @Excel(name = "预计归还时间")
    private String expectReturnTime;

    /** 分配的设备编号列表 */
    @Excel(name = "分配设备编号")
    private String assignedUnitCodes;

    /** 审批人ID */
    private Long approverId;

    /** 审批人姓名 */
    @Excel(name = "审批人")
    private String approverName;

    /** 审批时间 */
    @Excel(name = "审批时间")
    private String approveTime;

    /** 拒绝原因 */
    private String rejectReason;

    /** 归还状态（0=未归还 1=正常归还 2=损坏归还） */
    @Excel(name = "归还状态", readConverterExp = "0=未归还,1=正常归还,2=损坏归还")
    private String returnStatus;

    public Long getOrderId()
    {
        return orderId;
    }

    public void setOrderId(Long orderId)
    {
        this.orderId = orderId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getReserveTime()
    {
        return reserveTime;
    }

    public void setReserveTime(String reserveTime)
    {
        this.reserveTime = reserveTime;
    }

    public String getOrderStatus()
    {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus)
    {
        this.orderStatus = orderStatus;
    }

    public Long getEquipmentId()
    {
        return equipmentId;
    }

    public void setEquipmentId(Long equipmentId)
    {
        this.equipmentId = equipmentId;
    }

    public String getEquipmentName()
    {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName)
    {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentImage()
    {
        return equipmentImage;
    }

    public void setEquipmentImage(String equipmentImage)
    {
        this.equipmentImage = equipmentImage;
    }

    public Integer getQuantity()
    {
        return quantity;
    }

    public void setQuantity(Integer quantity)
    {
        this.quantity = quantity;
    }

    public String getExpectReturnTime()
    {
        return expectReturnTime;
    }

    public void setExpectReturnTime(String expectReturnTime)
    {
        this.expectReturnTime = expectReturnTime;
    }

    public String getAssignedUnitCodes()
    {
        return assignedUnitCodes;
    }

    public void setAssignedUnitCodes(String assignedUnitCodes)
    {
        this.assignedUnitCodes = assignedUnitCodes;
    }

    public Long getApproverId()
    {
        return approverId;
    }

    public void setApproverId(Long approverId)
    {
        this.approverId = approverId;
    }

    public String getApproverName()
    {
        return approverName;
    }

    public void setApproverName(String approverName)
    {
        this.approverName = approverName;
    }

    public String getApproveTime()
    {
        return approveTime;
    }

    public void setApproveTime(String approveTime)
    {
        this.approveTime = approveTime;
    }

    public String getRejectReason()
    {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason)
    {
        this.rejectReason = rejectReason;
    }

    public String getReturnStatus()
    {
        return returnStatus;
    }

    public void setReturnStatus(String returnStatus)
    {
        this.returnStatus = returnStatus;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("orderId", getOrderId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("reserveTime", getReserveTime())
            .append("orderStatus", getOrderStatus())
            .append("equipmentId", getEquipmentId())
            .append("equipmentName", getEquipmentName())
            .append("equipmentImage", getEquipmentImage())
            .append("quantity", getQuantity())
            .append("expectReturnTime", getExpectReturnTime())
            .append("assignedUnitCodes", getAssignedUnitCodes())
            .append("approverId", getApproverId())
            .append("approverName", getApproverName())
            .append("approveTime", getApproveTime())
            .append("rejectReason", getRejectReason())
            .append("returnStatus", getReturnStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
