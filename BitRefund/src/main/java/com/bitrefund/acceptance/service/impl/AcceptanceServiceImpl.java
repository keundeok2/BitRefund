package com.bitrefund.acceptance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitrefund.acceptance.service.AcceptanceDAO;
import com.bitrefund.acceptance.service.AcceptanceService;
import com.bitrefund.domain.Acceptance;

@Service
public class AcceptanceServiceImpl implements AcceptanceService{

	@Autowired
	private AcceptanceDAO acceptanceDAO;
	
	@Override
	public int addAcceptance(Acceptance acceptance) {
		return acceptanceDAO.addAcceptance(acceptance);
	}
	
	@Override
	public List<Acceptance> getAllAcceptanceByPatientNo(int patientNo) {
		return acceptanceDAO.getAllAcceptanceByPatientNo(patientNo);
	}
	
	@Override
	public int updateRefundAmount(int acceptanceNo, int refundAmount) {
		return acceptanceDAO.updateRefundAmount(acceptanceNo, refundAmount);
	}
}
