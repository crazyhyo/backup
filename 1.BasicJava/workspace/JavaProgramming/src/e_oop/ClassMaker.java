package e_oop;

public class ClassMaker {
	/*
	 * 전역변수 하나를 선언 및 초기화 해주세요
	 * 리턴타입과 파라미터가 없는 메서드 하나를 만들어주세요.
	 * 메서드 안에서 전역변수를 출력해주세요.
	 * 전역변수와 동일한 타입의 리턴타입이 있고 파라미터는 없는 메서드 하나를 만들어 주세요.
	 * 메서드 안에서 전역변수를 리턴해주세요.
	 * 리턴타입은 없고 팔미터가 있는 메서드 하나를 만들어주세요.
	 * 메서드 안에서 파라미터를 출력해주세요.
	 * int타입의 리턴타입과 int타입의 파라미터 두개가 있는 메서드 하나를 만들어 주세요.
	 * 메서드 안에서 두 파라미터를 곱한 결과를 리턴해주세요.
	 */
	
	boolean global = true;
	
	void methodTest(){
		System.out.println(global);
	}
	boolean methodTest2(){
		return global;
	}
	void methodTest3(boolean local){
		System.out.println(local);
	}
	int methodTest4(int a, int b){
		return a * b;
	}
	
}
