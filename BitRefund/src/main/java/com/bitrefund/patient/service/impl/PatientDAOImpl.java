package com.bitrefund.patient.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.bitrefund.patient.service.PatientDAO;

@Repository
public class PatientDAOImpl implements PatientDAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Integer> selectId() throws Exception{
		
		return sqlSession.selectList("PatientMapper.selectPatient");
	}
	
	
}
