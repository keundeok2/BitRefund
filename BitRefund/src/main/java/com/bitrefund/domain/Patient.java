package com.bitrefund.domain;

public class Patient {

	private int patientNo;
	private String name;
	private String socialId;
	private String sex;
	public int getPatientNo() {
		return patientNo;
	}
	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSocialId() {
		return socialId;
	}
	public void setSocialId(String socialId) {
		this.socialId = socialId;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	@Override
	public String toString() {
		return "Patient [patientNo=" + patientNo + ", name=" + name + ", socialId=" + socialId + ", sex=" + sex + "]";
	}

	

}
