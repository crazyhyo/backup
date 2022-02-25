package com.spring.exe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.spring.main.Calculator;


public class Springmain {

	@Autowired
	private static Calculator cal2;
	
	
	
	static void main(String[] args) {
		
		ApplicationContext ctx = new GenericXmlApplicationContext("classpath:com/spring/context/root-context.xml");
		Calculator cal = ctx.getBean("cal1", Calculator.class);
		
		int a = 4, b = 2;
		System.out.println(cal.sum(a, b));
		System.out.println(cal.minus(a, b));
		System.out.println(cal.multiply(a, b));
		System.out.println(cal.divide(a, b));

		System.out.println(cal2.sum(a, b));
		System.out.println(cal2.minus(a, b));
		System.out.println(cal2.multiply(a, b));
		System.out.println(cal2.divide(a, b));
	}
}
