package com.spring.aspects;

public class BehaviorImpl implements Behavior{

	@Override
	public void 잠자기() {
		System.out.println("잠");
	}

	@Override
	public void 공부하기() {
		System.out.println("공부를 하신다는 겁니까 휴먼?");
	}

	@Override
	public void 밥먹기() {
		System.out.println("밥");
	}

	@Override
	public void 백야극광하기() {
		System.out.println("백야극광 아십니까? 정말 갓.겜.입니다.");
	}

	@Override
	public void 운동() {
		System.out.println("운동 싫어");
	}

	@Override
	public void 가챠하기() {
		System.out.println("크게 지르지 않으면 나오지 않는다구요\n통장 전부 꼴아박아요");
	}

	@Override
	public void 정신수양() {
		System.out.println("서머너스펠 : 총명");
	}

}
