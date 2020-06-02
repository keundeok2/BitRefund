package com.bitrefund.home.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitrefund.domain.Patient;
import com.bitrefund.patient.service.PatientService;

@Controller
public class HomeController {

	private static Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private PatientService patientService;
	
	@RequestMapping("/")
	public String index(Model model) {
		
		return "main";
	}
}
