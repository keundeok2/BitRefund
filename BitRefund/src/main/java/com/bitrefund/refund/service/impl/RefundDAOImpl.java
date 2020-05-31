package com.bitrefund.refund.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitrefund.domain.Refund;
import com.bitrefund.refund.service.RefundDAO;

@Repository
public class RefundDAOImpl implements RefundDAO{

	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int addRefund(Refund refund) {
		return sqlSession.insert("RefundMapper.addRefund", refund);
	}
	
	@Override
	public List<Refund> getAllRefundByAcceptanceNo(int acceptanceNo) {
		return sqlSession.selectList("RefundMapper.getAllRefundByAcceptanceNo", acceptanceNo);
	}
}
