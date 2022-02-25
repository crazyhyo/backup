package e_oop;

public class Static {

	/*
	 * - static을 붙이면 프로그램 실행시 메모리에 올라간다.
	 * - 객체생성을 하지 않아도 사용할 수 있다.
	 * - static을 붙인 변수는 객체간에 변수의 값을 공유한다.
	 * - static이 붙은 멤버의 명칭 : 클래스 변수, 클래스 메서드
	 * - static이 붙지 않은 멤버의 명칭 : 인스턴스 변수, 인스턴스 메서드
	 * 
	 * - static이 붙은 멤버는 클래스 명을 통해서 접근한다.
	 * - 어떤 클래스에서도 접근가능하다.
	 * 메서드 밖에 있으면 전역변수 및 인스턴스 변수
	 * 그 중에서도 static이 붙어있으면 전역변수 및 클래스 변수
	 * 
	 * 메서드에 static을 붙이는 경우 : 그 메서드가 너무 자주 사용되어 객체생성을 안하고 싶을 때
	 * 예: System.out.println();, Math.random();
	 * 클래스 명으로 접근하고 있는 것을 볼 수 있다.
	 * 
	 * 싱글톤패턴을 만들 때 static을 사용하게 되는데
	 * 이 외에 웹 개발에서는 static을 잘 안쓴다
	 * 근데 게임 개발에서는 잘 쓰임
	 * 스타크래프트 업그레이드 할 때 모든 해당 타입 공(/방) 증가
	 * 
	 * static method에서는 static 변수만 사용할 수 있음
	 */
	
	//값을 공유하기 위해 static을 붙인다.
	int var;	//<-인스턴스 변수
	static int var2; //<-static 변수
	
	public static void main(String[] args) {
		Human h1 = new Human();
		Human h2 = new Human();
		
		h1.name = "철수";
		h2.name = "영희";
		
		h1.saveMoney(10000);
		h2.saveMoney(20000);
		
		h1.saveDateMoney(10000);
		h2.saveDateMoney(10000);
		
		Human.dateAccount = 0;
		
		System.out.print("문자열 입력>");
		String str = ScanUtil.nextLine();
		System.out.println(str);

		System.out.print("숫자 입력>");
		int num = ScanUtil.nextInt();
		System.out.println(num);
		
	}

}

class Human{
	
	String name;
	int account; //계좌 잔고
	
	void saveMoney(int money){
		account += money;
		System.out.println(name + "의 계좌 잔고 : " + account);
	}
	
	static int dateAccount;
	
	void saveDateMoney(int money){
		dateAccount += money;
		System.out.println("데이트 계좌 잔고 : " + dateAccount);
	}
}