package com.bitrefund.acceptance.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitrefund.acceptance.service.AcceptanceDAO;
import com.bitrefund.domain.Acceptance;

@Repository
public class AcceptanceDAOImpl implements AcceptanceDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int addAcceptance(Acceptance acceptance) {
		return sqlSession.insert("AcceptanceMapper.addAcceptance", acceptance);
	}
	
	@Override
	public List<Acceptance> getAllAcceptanceByPatientNo(int patientNo) {
		return sqlSession.selectList("AcceptanceMapper.getAllAcceptanceByPatientNo", patientNo);
	}
	
	@Override
	public int updateRefundAmount(int acceptanceNo, int refundAmount) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("acceptanceNo", acceptanceNo);
		map.put("refundAmount", refundAmount);
		return sqlSession.update("AcceptanceMapper.updateRefundAmount", map);
	}
	
}
