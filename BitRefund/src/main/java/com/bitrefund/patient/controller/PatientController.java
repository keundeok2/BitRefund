package com.bitrefund.patient.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitrefund.domain.Patient;
import com.bitrefund.domain.Search;
import com.bitrefund.patient.service.PatientService;

@Controller
@RequestMapping("/patient")
public class PatientController {

	@Autowired
	private PatientService patientService;
	
	private static final Logger logger = LoggerFactory.getLogger(PatientController.class);

	@RequestMapping(value = "/getAllPatient", method = RequestMethod.GET)
	public String getAllPatient(Model model) {

		List<Patient> list = patientService.getAllPatient();
		logger.info(list.toString());
		model.addAttribute("list", list);
		
		return "patientList";
	}
	
	@RequestMapping(value = "/getPatientForSearch", method= RequestMethod.POST)
	public String getPatientForSearch(Model model, @ModelAttribute Search search) {
		logger.info(search.toString());
		
		List<Patient> list = patientService.getPatientForSearch(search);
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		return "patientList";
	}
}
