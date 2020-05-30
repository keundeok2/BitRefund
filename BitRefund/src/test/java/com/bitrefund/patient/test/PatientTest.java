package com.bitrefund.patient.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitrefund.patient.service.PatientService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/*-context.xml")
public class PatientTest {

	@Autowired
	private PatientService userService;
	
	
	@Test
	public void test() throws Exception{
		System.out.println(userService.selectId());
	}
	
	

}
