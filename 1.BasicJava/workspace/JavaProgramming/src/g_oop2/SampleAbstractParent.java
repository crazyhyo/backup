package g_oop2;

public abstract class SampleAbstractParent {
	//추상메서드 : 선언부만 있고 구현부는 없는 메서드
	//추상클래스 : 적어도 하나의 추상메서드를 가지는 클래스
	//추상클래스는 객체생성이 불가능하다.
	//추상클래스는 부모의 역할만 한다. 자식클래스는 상속받은 메서드의 내용을 만들어주어야 한다.
	//추상클래스를 상속받은 자식 클래스는 반드시 추상메서드를 오버라이드해야 한다. 
	abstract void abstractMethod();
	
}

class SampleAbstractChild extends SampleAbstractParent{

	@Override
	void abstractMethod() {
		
	}
	
}



