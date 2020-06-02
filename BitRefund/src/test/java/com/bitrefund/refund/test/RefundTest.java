package com.bitrefund.refund.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitrefund.domain.Refund;
import com.bitrefund.refund.service.RefundService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/*-context.xml")
public class RefundTest {

	@Autowired
	private RefundService refundService;
	
	
	@Test
	public void addRefund() throws Exception {
		Refund refund = new Refund();
		refund.setAcceptanceNo(10038);
		refund.setCard(10000);
		refund.setBankTransfer(10000);
		refund.setCash(3333);
		refund.setTotalRefundAmount(23333);
		refundService.addRefund(refund);
	}
}
