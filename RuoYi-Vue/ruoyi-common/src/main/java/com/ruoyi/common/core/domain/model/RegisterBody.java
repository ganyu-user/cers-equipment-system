package com.ruoyi.common.core.domain.model;

public class RegisterBody extends LoginBody
{
    private String realName;
    private String studentNo;
    private String grade;
    private String major;
    private String phone;

    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getStudentNo() { return studentNo; }
    public void setStudentNo(String studentNo) { this.studentNo = studentNo; }
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    public String getMajor() { return major; }
    public void setMajor(String major) { this.major = major; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
