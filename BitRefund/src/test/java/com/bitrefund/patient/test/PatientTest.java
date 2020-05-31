package com.bitrefund.patient.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitrefund.domain.Search;
import com.bitrefund.patient.service.PatientService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/*-context.xml")
public class PatientTest {

	private static Logger logger = LoggerFactory.getLogger(PatientTest.class);
	
	@Autowired
	private PatientService patientService;
	
//	@Test
	public void getAllPatient() throws Exception{
		logger.info(patientService.getAllPatient().toString());
	}
	
//	@Test
	public void getPatient() throws Exception{
		int patientNo = 10001;
		logger.info(patientService.getPatient(patientNo).toString());
	}
	
	@Test
	public void getPatientForSearch() throws Exception{
		Search search1 = new Search();
		search1.setSearchCondition("name");
		search1.setSearchKeyword("덕");
		
		Search search2 = new Search();
		search2.setSearchCondition("socialId");
		search2.setSearchKeyword("921029-1");
		
		Search search3 = new Search();
		search3.setSearchCondition("patientNo");
		search3.setSearchKeyword("100");
		
		
		logger.info(search3.toString());
		logger.info(patientService.getPatientForSearch(search3).toString());
	}
	
	
	
	

}
