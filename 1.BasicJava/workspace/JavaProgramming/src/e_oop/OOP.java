package e_oop;

public class OOP {
	public static void main(String[] args) {
		/*
		 * 객체지향 프로그래밍(Object Oriented Programming)
		 * - 프로그래밍을 단순히 코드의 연속으로 보는 것이 아니라 객체간의 상호작용으로 보는 것
		 * - 코드의 재사용성이 높고 유지보수가 용이하다.
		 */
//		SampleClass sc = new SampleClass();
//		System.out.println(sc.field);			//자바의 모든 클래스는 object 클래스를 상속함
//		String returnValue = sc.method(10);
//		System.out.println(returnValue);
//		sc.flowTest1();
//		//방금 만든 클래스의 객체를 생성하고 변수에 저장해주세요
//		//객체가 저장된 변수를 통해 메서드를 호출해주세요.
//		//파라미터가 있는 메서드는 타입에 맞는 값을 넘겨주시고,
//		//리턴타입이 있는 메서드는 리턴받은 값을 출력해주세요.
//		ClassMaker cm = new ClassMaker();
//		cm.global = false;
//		cm.methodTest();
//		boolean alpha = cm.methodTest2();
//		System.out.println(alpha);
//		cm.methodTest3(alpha);
//		int beta = cm.methodTest4(3, 4);
//		System.out.println(beta);
		
		Calculator calc = new Calculator();
		double result = 0;
		result = calc.plus(123456, 654321);
		System.out.println(result);
		result = calc.product(result, 123456);
		System.out.println(result);
		result = calc.divide(result, 123456);
		System.out.println(result);
		result = calc.minus(result, 654321);
		System.out.println(result);
		result = calc.remainder(result, 123456);
		System.out.println(result);
		
	}
}
