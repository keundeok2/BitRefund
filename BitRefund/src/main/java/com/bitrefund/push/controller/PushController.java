package com.bitrefund.push.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitrefund.push.service.FCMService;

@Controller
@RequestMapping("/push")
public class PushController {

	@Autowired
	private FCMService fcmService;
	
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public void registerToken(@RequestBody String token) {
		fcmService.register(token);
	}
	
	@RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
	@ResponseBody
	public void sendMessage() throws Exception{
		fcmService.send();
	}
}
