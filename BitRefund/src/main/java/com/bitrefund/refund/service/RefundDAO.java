package com.bitrefund.refund.service;

import java.util.List;

import com.bitrefund.domain.Refund;

public interface RefundDAO {

	public int addRefund(Refund refund);
	
	public List<Refund> getAllRefundByAcceptanceNo(int acceptanceNo);

}
