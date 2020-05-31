package com.bitrefund.refund.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitrefund.acceptance.service.AcceptanceDAO;
import com.bitrefund.domain.Refund;
import com.bitrefund.refund.service.RefundDAO;
import com.bitrefund.refund.service.RefundService;

@Service
public class RefundServiceImpl implements RefundService {

	@Autowired
	private RefundDAO refundDAO;
	
	@Autowired
	private AcceptanceDAO acceptanceDAO; 
	
	@Override
	@Transactional
	public void addRefund(Refund refund) {
		int refundAmount = refund.getTotalRefundAmount();
		int acceptanceNo = refund.getAcceptanceNo();
		
		refundDAO.addRefund(refund);
		acceptanceDAO.updateRefundAmount(acceptanceNo, refundAmount);
	}
	
	@Override
	public List<Refund> getAllRefundByAcceptanceNo(int acceptanceNo) {
		return refundDAO.getAllRefundByAcceptanceNo(acceptanceNo);
	}
}
