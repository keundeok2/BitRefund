package com.bitrefund.patient.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitrefund.patient.service.PatientDAO;
import com.bitrefund.patient.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService{

	@Autowired
	private PatientDAO userDAO;

	@Override
	public List<Integer> selectId() throws Exception {
		return userDAO.selectId();
	}
	
	
	
}
