package com.bitrefund.push.service;

import java.io.FileInputStream;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.WebpushConfig;
import com.google.firebase.messaging.WebpushNotification;

@Service
public class FCMService {

	private static Logger logger = LoggerFactory.getLogger(FCMService.class);
	private String token;
	public void setToken(String token) {
		this.token = token;
	}
	
	@PostConstruct
	public void init(){
		try {
			
		FileInputStream serviceAccount =
				  new FileInputStream("/Users/keundeok/Downloads/webuwl-firebase-adminsdk-cdwqm-faa79c0917.json");

				FirebaseOptions options = new FirebaseOptions.Builder()
				  .setCredentials(GoogleCredentials.fromStream(serviceAccount))
				  .setDatabaseUrl("https://webuwl.firebaseio.com")
				  .build();

				FirebaseApp.initializeApp(options);
				
				logger.info("firebase init!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void register(String token) {
		logger.info(token);
		this.setToken(token);
	}
	
	public void send() throws Exception {
		System.out.println("run FCMService send()");
		Message message = Message.builder().setToken(this.token)
				.setWebpushConfig(
						WebpushConfig.builder().putHeader("ttl", "300")
								.setNotification(new WebpushNotification("타이틀",
										"메시지"))
								.build())
				.build();

		String response = FirebaseMessaging.getInstance().send(message);
		logger.info(response);
	}
}
