package com.bitrefund.refund.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitrefund.domain.Refund;
import com.bitrefund.refund.service.RefundService;

@Controller
@RequestMapping("/refund")
public class RefundController {

	private static Logger logger = LoggerFactory.getLogger(RefundController.class);
	
	@Autowired
	private RefundService refundService;

	@ResponseBody
	@RequestMapping(value = "getAllRefundByAcceptanceNo/{acceptanceNo}", method = RequestMethod.GET)
	public Map getAllRefundByAcceptanceNo(@PathVariable int acceptanceNo) {
		List<Refund> list = refundService.getAllRefundByAcceptanceNo(acceptanceNo);
		logger.info(list.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refundList", list);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/addRefund", method = RequestMethod.POST)
	public Map addRefund(@RequestBody Refund refund) {
		int success = refundService.addRefund(refund);
		logger.info(refund.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
			map.put("refund", refund);
			map.put("success", (success == 2));
		
		return map;
	}

}
