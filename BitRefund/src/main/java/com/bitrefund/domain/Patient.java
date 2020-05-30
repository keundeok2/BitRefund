package com.bitrefund.domain;

public class Patient {

	private int patientNo;
	private String patientName;
	private int age;
	private String sex;
	private String phone;
	public int getPatientNo() {
		return patientNo;
	}
	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
	}
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Override
	public String toString() {
		return "Patient [patientNo=" + patientNo + ", patientName=" + patientName + ", age=" + age + ", sex=" + sex
				+ ", phone=" + phone + "]";
	}
	

}
