package com.bitrefund.patient.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitrefund.domain.Patient;
import com.bitrefund.domain.Search;
import com.bitrefund.patient.service.PatientDAO;

@Repository
public class PatientDAOImpl implements PatientDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public Patient getPatient(int patientNo) {

		return sqlSession.selectOne("PatientMapper.getPatient", patientNo);
	}

	@Override
	public List<Patient> getAllPatient() {

		return sqlSession.selectList("PatientMapper.getAllPatient");
	}

	@Override
	public List<Patient> getPatientForSearch(Search search) {
		return sqlSession.selectList("PatientMapper.getPatientForSearch", search);
	}
}
