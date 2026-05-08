package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备预约单管理对象 res_order
 * 
 * @author ganyu
 * @date 2026-05-07
 */
public class ResOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 预约单ID */
    @Excel(name = "预约单ID")
    private Long orderId;

    /** 预约用户ID */
    private Long userId;

    /** 设备ID */
    private Long equipId;

    /** 预约数量 */
    @Excel(name = "预约数量")
    private Long quantity;

    /** 预约人姓名 */
    @Excel(name = "预约人姓名")
    private String realName;

    /** 学号 */
    @Excel(name = "学号")
    private String studentNo;

    /** 年级 */
    @Excel(name = "年级")
    private String grade;

    /** 专业 */
    @Excel(name = "专业")
    private String major;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phone;

    /** 预约开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预约开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date reserveTime;

    /** 预计归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预计归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expectReturnTime;

    /** 实际归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date actualReturnTime;

    /** 预约状态（0待审批 1审批通过/使用中 2审批拒绝 3已归还 4已逾期 5已取消） */
    @Excel(name = "预约状态", readConverterExp = "0=待审批,1=审批通过/使用中,2=审批拒绝,3=已归还,4=已逾期,5=已取消")
    private String orderStatus;

    /** 拒绝理由 */
    @Excel(name = "拒绝理由")
    private String rejectReason;

    /** 领取地点 */
    @Excel(name = "领取地点")
    private String pickupLocation;

    /** 领取时间（审批通过时填入） */
    @Excel(name = "领取时间", readConverterExp = "审=批通过时填入")
    private Date pickupTime;

    /** 延期状态（0未申请 1延期审批中 2延期通过 3延期拒绝） */
    @Excel(name = "延期状态", readConverterExp = "0=未申请,1=延期审批中,2=延期通过,3=延期拒绝")
    private String extendStatus;

    /** 延期后的预计归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "延期后的预计归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date extendExpectReturnTime;

    /** 延期原因/审批意见 */
    @Excel(name = "延期原因/审批意见")
    private String extendReason;

    public void setOrderId(Long orderId) 
    {
        this.orderId = orderId;
    }

    public Long getOrderId() 
    {
        return orderId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setEquipId(Long equipId) 
    {
        this.equipId = equipId;
    }

    public Long getEquipId() 
    {
        return equipId;
    }

    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }

    public void setRealName(String realName) 
    {
        this.realName = realName;
    }

    public String getRealName() 
    {
        return realName;
    }

    public void setStudentNo(String studentNo) 
    {
        this.studentNo = studentNo;
    }

    public String getStudentNo() 
    {
        return studentNo;
    }

    public void setGrade(String grade) 
    {
        this.grade = grade;
    }

    public String getGrade() 
    {
        return grade;
    }

    public void setMajor(String major) 
    {
        this.major = major;
    }

    public String getMajor() 
    {
        return major;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public void setReserveTime(Date reserveTime) 
    {
        this.reserveTime = reserveTime;
    }

    public Date getReserveTime() 
    {
        return reserveTime;
    }

    public void setExpectReturnTime(Date expectReturnTime) 
    {
        this.expectReturnTime = expectReturnTime;
    }

    public Date getExpectReturnTime() 
    {
        return expectReturnTime;
    }

    public void setActualReturnTime(Date actualReturnTime) 
    {
        this.actualReturnTime = actualReturnTime;
    }

    public Date getActualReturnTime() 
    {
        return actualReturnTime;
    }

    public void setOrderStatus(String orderStatus) 
    {
        this.orderStatus = orderStatus;
    }

    public String getOrderStatus() 
    {
        return orderStatus;
    }

    public void setRejectReason(String rejectReason) 
    {
        this.rejectReason = rejectReason;
    }

    public String getRejectReason() 
    {
        return rejectReason;
    }

    public void setPickupLocation(String pickupLocation) 
    {
        this.pickupLocation = pickupLocation;
    }

    public String getPickupLocation() 
    {
        return pickupLocation;
    }

    public void setPickupTime(Date pickupTime) 
    {
        this.pickupTime = pickupTime;
    }

    public Date getPickupTime() 
    {
        return pickupTime;
    }

    public void setExtendStatus(String extendStatus) 
    {
        this.extendStatus = extendStatus;
    }

    public String getExtendStatus() 
    {
        return extendStatus;
    }

    public void setExtendExpectReturnTime(Date extendExpectReturnTime) 
    {
        this.extendExpectReturnTime = extendExpectReturnTime;
    }

    public Date getExtendExpectReturnTime() 
    {
        return extendExpectReturnTime;
    }

    public void setExtendReason(String extendReason) 
    {
        this.extendReason = extendReason;
    }

    public String getExtendReason() 
    {
        return extendReason;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("orderId", getOrderId())
            .append("userId", getUserId())
            .append("equipId", getEquipId())
            .append("quantity", getQuantity())
            .append("realName", getRealName())
            .append("studentNo", getStudentNo())
            .append("grade", getGrade())
            .append("major", getMajor())
            .append("phone", getPhone())
            .append("reserveTime", getReserveTime())
            .append("expectReturnTime", getExpectReturnTime())
            .append("actualReturnTime", getActualReturnTime())
            .append("orderStatus", getOrderStatus())
            .append("rejectReason", getRejectReason())
            .append("pickupLocation", getPickupLocation())
            .append("pickupTime", getPickupTime())
            .append("extendStatus", getExtendStatus())
            .append("extendExpectReturnTime", getExtendExpectReturnTime())
            .append("extendReason", getExtendReason())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
