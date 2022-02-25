package com.spring.advice;

import org.aspectj.lang.ProceedingJoinPoint;

public class AdviceBehavior {

	public void 양치(){
		System.out.println("양치");
	}
	
	public void 기도(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("경건한 마음으로 가챠를 합니다.");
		
		joinPoint.proceed();
		
		System.out.println("잔고가 부족합니다.");
		
	}
}
