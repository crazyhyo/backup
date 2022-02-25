package g_oop2;

public interface SampleInterface {
	//인터페이스 : 멤버로 상수와 추상메서드만 가질 수 있는 객체
	//인터페이스의 모든 멤버변수는 public static final 제어자를 사용해야 한다.
	public static final int NUM1 = 1;

	//모든 멤버변수의 제어자가 같기 때문에 생략이 가능하다.
	int NUM2 = 3;
	
	//인터페이스의 모든 메서드는 public abstract 제어자를 사용해야 한다.
	public abstract void method1();
	
	//모든 메서드의 제어자가 같기 때문에 생략이 가능하다.
	void method2();
}

class sampleImplement implements SampleInterface, SampleInterface2{

	@Override
	public void method1() {
		
	}
	//두 추상메서드를 implements한 클래스가 같은 이름의 추상메서드를 상속받는다면
	//하나만 오버라이딩 해서 사용해도 된다. 어차피 추상메서드라서 내가 쓸 것만 정의하면 됨 그게 누구한테서 왔는지 상관없음
	//클래스의 틀을 잡아주는 용도로 사용함
	//자식 클래스가 추상메서드 오버라이딩 하지 않으면 컴파일에러이므로
	//관계가 없는 클래스들에게 관계를 주기 위해서도 사용함

	@Override
	public void method2() {
		
	}

	@Override
	public void method3() {
		
	}
	
}

interface SampleInterface2{
	void method1();
	void method3();
}

