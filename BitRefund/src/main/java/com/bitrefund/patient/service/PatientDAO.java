package com.bitrefund.patient.service;

import java.util.List;

import com.bitrefund.domain.Patient;
import com.bitrefund.domain.Search;

public interface PatientDAO {

	public Patient getPatient(int patientNo);

	public List<Patient> getAllPatient();

	public List<Patient> getPatientForSearch(Search search);

}
