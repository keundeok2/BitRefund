package com.bitrefund.acceptance.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitrefund.acceptance.service.AcceptanceService;
import com.bitrefund.domain.Acceptance;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/*-context.xml")
public class AcceptanceTest {

	@Autowired
	private AcceptanceService acceptanceService;

	private static Logger logger = LoggerFactory.getLogger(AcceptanceTest.class);

	@Test
	public void addTest() {
		Acceptance acceptance = new Acceptance();
		acceptance.setAcceptanceAmount(20000);
		acceptance.setTotalPrice(70000);
		acceptance.setPatientNo(10000);

		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));
		System.out.println(acceptanceService.addAcceptance(acceptance));

	}

//	@Test
	public void getAllAcceptanceByPatientNo() throws Exception {
		int patientNo = 10001;
		
		System.out.println(acceptanceService.getAllAcceptanceByPatientNo(patientNo));
	}
	
//	@Test
	public void updateRefundAmount() throws Exception{
		
		int acceptanceNo = 10001;
		int refundAmount = 23333;
		
		System.out.println(acceptanceService.updateRefundAmount(acceptanceNo, refundAmount));
	}

}
