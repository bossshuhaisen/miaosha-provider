package com.shs.main;

import java.io.IOException;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MainApplication {
	
	public static void main(String[] args) throws IOException {
		ClassPathXmlApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		ioc.start();
		System.in.read();
	}

}
