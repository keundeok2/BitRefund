package com.bitrefund.patient.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitrefund.domain.Patient;
import com.bitrefund.domain.Search;
import com.bitrefund.patient.service.PatientDAO;
import com.bitrefund.patient.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDAO patientDAO;

	@Override
	public Patient getPatient(int patientNo) {
		return patientDAO.getPatient(patientNo);
	}

	@Override
	public List<Patient> getAllPatient() {
		return patientDAO.getAllPatient();
	}
	
	@Override
	public List<Patient> getPatientForSearch(Search search) {
		return patientDAO.getPatientForSearch(search);
	}

}
