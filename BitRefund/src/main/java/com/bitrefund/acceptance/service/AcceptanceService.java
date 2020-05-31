package com.bitrefund.acceptance.service;

import java.util.List;

import com.bitrefund.domain.Acceptance;

public interface AcceptanceService {

	public int addAcceptance(Acceptance acceptance);
	
	public List<Acceptance> getAllAcceptanceByPatientNo(int patientNo);
	
	public int updateRefundAmount(int acceptanceNo, int refundAmount);
}
