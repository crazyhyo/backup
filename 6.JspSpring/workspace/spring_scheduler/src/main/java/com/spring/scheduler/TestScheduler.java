package com.spring.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/*
 * annotation을 이용하여 scheduler를 등록하는 것은 나쁜 방법이다.
 * 사용하지 말자.
 */

//@Component("jobTask")
public class TestScheduler {

//	@Scheduled(fixedRate=1000*5)
//	*/5의 의미 : 현재시간(해당위치, 여기서는 초)를 기준으로 스케쥴이 시작되자 마자 바로 실행 
//	@Scheduled(cron="*/5 * * * * *")
	public void testMessage() {
		System.out.println("hello, world!");
	}
	
}
