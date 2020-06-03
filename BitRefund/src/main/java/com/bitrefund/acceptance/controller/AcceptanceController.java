package com.bitrefund.acceptance.controller;

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

import com.bitrefund.acceptance.service.AcceptanceService;
import com.bitrefund.domain.Acceptance;
import com.bitrefund.domain.Patient;
import com.bitrefund.patient.service.PatientService;

@Controller
@RequestMapping("/acceptance")
public class AcceptanceController {

	private static Logger logger = LoggerFactory.getLogger(AcceptanceController.class);
	
	@Autowired
	private AcceptanceService acceptanceService;
	
	@Autowired
	private PatientService patientService;
	
	@RequestMapping(value = "/getAllAcceptanceByPatientNo/{patientNo}", method = RequestMethod.GET)
	public String getAllAcceptanceByPatientNo(@PathVariable int patientNo, Model model) {
		List<Acceptance> list = acceptanceService.getAllAcceptanceByPatientNo(patientNo);
		Patient patient = patientService.getPatient(patientNo);
		
		logger.info(list.toString());
		logger.info(patient.toString());
		
		model.addAttribute("acceptanceList",list);
		model.addAttribute("patient", patient);
		return "main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/addAcceptance", method = RequestMethod.POST)
	public Map addAcceptance(@RequestBody Acceptance acceptance) {
		int success = acceptanceService.addAcceptance(acceptance);
		logger.info("addAcceptance() run");
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (success == 1) {
			map.put("success", true);
			map.put("acceptance", acceptance);
		} else map.put("success", false);
		return map;
	}
	
}
