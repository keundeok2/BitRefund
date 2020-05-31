package com.bitrefund.domain;

import java.sql.Date;

public class Refund {

	private int refundNo;
	private int acceptanceNo;
	private Date refundDate;
	private int cash;
	private int card;
	private int bankTransfer;
	private int totalRefundAmount;

	public int getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(int refundNo) {
		this.refundNo = refundNo;
	}

	public int getAcceptanceNo() {
		return acceptanceNo;
	}

	public void setAcceptanceNo(int acceptanceNo) {
		this.acceptanceNo = acceptanceNo;
	}

	public Date getRefundDate() {
		return refundDate;
	}

	public void setRefundDate(Date refundDate) {
		this.refundDate = refundDate;
	}

	public int getCash() {
		return cash;
	}

	public void setCash(int cash) {
		this.cash = cash;
	}

	public int getCard() {
		return card;
	}

	public void setCard(int card) {
		this.card = card;
	}

	public int getBankTransfer() {
		return bankTransfer;
	}

	public void setBankTransfer(int bankTransfer) {
		this.bankTransfer = bankTransfer;
	}

	public int getTotalRefundAmount() {
		return totalRefundAmount;
	}
	
	public void setTotalRefundAmount(int totalRefundAmount) {
		this.totalRefundAmount = totalRefundAmount;
	}

	@Override
	public String toString() {
		return "Refund [refundNo=" + refundNo + ", acceptanceNo=" + acceptanceNo + ", refundDate=" + refundDate
				+ ", cash=" + cash + ", card=" + card + ", bankTransfer=" + bankTransfer + ", totalRefundAmount="
				+ totalRefundAmount + "]";
	}

	
}
