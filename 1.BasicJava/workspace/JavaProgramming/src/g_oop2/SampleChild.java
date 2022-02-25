package g_oop2;

public class SampleChild extends SampleParent{
	
	void childMethod(){
		System.out.println(var);			//상속받은 변수
		System.out.println(method(7,13));	//상속받은 메서드		
	}
	
	//오버라이딩			상속받은 메서드의 내용을 바꾸는 것
	//super, super()	this와 비슷, 부모클래스의 변수와 자식클래스의 변수의 이름이 같을 때
	//다형성				객체와 변수의 타입이 다르게 생성할 수 있다. 자식을 생성하고 부모라고 우길수 있다는 건가 맞음
	
	//오버라이딩 : 상속받은 메서드의 내용을 재정의 하는 것 (오버라이드 첫 글자 대문자다) / 리턴타입, 메서드 이름, 파라미터가 모두 같아야 함
	//어노테이션은 필수는 아니다. 코드 가독성과 정확한 의미 전달을 위해 쓴다 그러니까 쓰라는 말이다.
	@Override//어노테이션 : 클래스, 변수, 메서드 등에 표시해 놓는 것. 오버라이딩 된 메서드가 아니면 컴파일 에러를 발생시켜준다.
	int method(int a, int b){
		return a * b;
	}
	
	//super, super()
	int var;
	void test(double var){
		System.out.println(var);
		System.out.println(this.var);
		System.out.println(super.var);
		
		//super.는 부모 클래스의 주소로 접근하는 느낌이라고 생각하면 된다.
		
		System.out.println(method(10,20));
		System.out.println(super.method(10,20));	//부모클래스의 메서드
	}
	//super : 부모 클래스의 멤버와 자식 클래스의 멤버의 이름이 중복될 때 둘을 구분하기 위해 사용한다.
	
	SampleChild(){
		super();//부모클래스의 생성자 호출
		//자식클래스의 생성자 안에서는 반드시 부모클래스의 생성자를 호출해야 한다.
		//만약 부모클래스의 생성자가 디폴트 혹은 파라미터가 없고 이고 자식클래스의 생성자에서 부모클래스의 생성자를 호출하지 않았다면 컴파일러가 자동으로 부모클래스의 생성자를 넣어준다.
		//부모클래스의 생성자를 임의로 정의했다면 자식 클래스에서 부모클래스의 생성자를 반드시 호출하여야 한다. 아니면 컴파일에러
	}
	
	//다형성 : 부모클래스의 타입으로 자식클래스 타입을 저장하는 것
	//객체와 객체를 저장할 변수의 타입이 서로 다른 경우
	//부모자식 간의 형변환이 가능하다.
	public static void main(String[] args) {
		SampleChild sc = new SampleChild();
		SampleParent sp = new SampleChild();
		
//		sc.test(0.1);
		
		sc = (SampleChild)sp;
		sp = sc;
		
		SampleChild sc2 = (SampleChild) new SampleParent();
		
		//자식타입 -> 부모타입 형변환은 생략할 수 있다.
		//부모타입 -> 자식타입으로의 형변환은 에러 발생 <- 컴파일러가 잡아주지 않음, 실행시 오류
	}
		
	
}
