package com.bitrefund.domain;

import java.sql.Date;

public class Acceptance {

	private int acceptanceNo;
	private Date acceptanceDate;
	private int patientNo;
	private int totalPrice;
	private int copay;
	private int acceptanceAmount;
	private int refundAmount;

	public int getAcceptanceNo() {
		return acceptanceNo;
	}

	public void setAcceptanceNo(int acceptanceNo) {
		this.acceptanceNo = acceptanceNo;
	}

	public Date getAcceptanceDate() {
		return acceptanceDate;
	}

	public void setAcceptanceDate(Date acceptanceDate) {
		this.acceptanceDate = acceptanceDate;
	}

	public int getPatientNo() {
		return patientNo;
	}

	public void setPatientNo(int patientNo) {
		this.patientNo = patientNo;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getCopay() {
		return copay;
	}

	public void setCopay(int copay) {
		this.copay = copay;
	}

	public int getAcceptanceAmount() {
		return acceptanceAmount;
	}

	public void setAcceptanceAmount(int acceptanceAmount) {
		this.acceptanceAmount = acceptanceAmount;
	}

	public int getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(int refundAmount) {
		this.refundAmount = refundAmount;
	}

	@Override
	public String toString() {
		return "Acceptance [acceptanceNo=" + acceptanceNo + ", acceptanceDate=" + acceptanceDate + ", patientNo="
				+ patientNo + ", totalPrice=" + totalPrice + ", copay=" + copay + ", acceptanceAmount="
				+ acceptanceAmount + ", refundAmount=" + refundAmount + "]";
	}

}
