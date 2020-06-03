package com.bitrefund.refund.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	/*
	@RequestMapping(value = "/getAllRefundByAcceptanceNo/{acceptanceNo}/{patientNo}", method = RequestMethod.GET)
	public String getAllRefundByAcceptanceNo(@PathVariable int acceptanceNo,@PathVariable int patientNo ,Model model) {

		List<Refund> list = refundService.getAllRefundByAcceptanceNo(acceptanceNo);
		logger.info(list.toString());
		model.addAttribute("refundList", list);
		model.addAttribute("refundAcceptanceNo", acceptanceNo);
		
		return "forward:/acceptance/getAllAcceptanceByPatientNo/"+patientNo;
	}
	*/
	
	@ResponseBody
	@RequestMapping(value = "getAllRefundByAcceptanceNo/{acceptanceNo}", method = RequestMethod.GET)
	public Map getAllRefundByAcceptanceNo(@PathVariable int acceptanceNo) {
		List<Refund> list = refundService.getAllRefundByAcceptanceNo(acceptanceNo);
		logger.info(list.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refundList", list);
		return map;
	}
	
	/*
	@RequestMapping(value = "/addRefund", method = RequestMethod.POST)
	public String addRefund(@ModelAttribute Refund refund, Model model) {
		logger.info("addRefund() run...");
		refundService.addRefund(refund);
		return "redirect:/refund/getAllRefundByAcceptanceNo/"+refund.getAcceptanceNo()+"/"+refund.getPatientNo();
	}
	*/
	
	@ResponseBody
	@RequestMapping(value = "/addRefund", method = RequestMethod.POST)
	public Map addRefund(@RequestBody Refund refund) {
		logger.info(refund.toString());
		refundService.addRefund(refund);
		logger.info(refund.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("refund", refund);
		return map;
	}

}
