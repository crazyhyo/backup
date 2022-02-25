package g_oop2.test;

import g_oop2.AccessModifier;

public class AccessTest extends AccessModifier{

	public static void main(String[] args) {
		AccessModifier am = new AccessModifier();
		//하위 패키지로 생성해도 다른 패키지로 인식된다.
		//하위 패키지에서 상위 패키지는 그냥 별개의 패키지다
		
		System.out.println(am.publicVar);
		am.publicMethod();
		
//		System.out.println(am.protectedVar);
//		am.protectedMethod();
		//상속을 받았으면 자신의 메서드와 변수를 사용해야 함
//		System.out.println(super.protectedVar);
//		super.protectedMethod();
		//static이 아니라서 사용할 수 없음
		
//		System.out.println(am.defaultVar);
//		am.defaultMethod();
		//
//		System.out.println(am.privateVar);
//		am.privateMethod();
		//같은 패키지 안에서도 접근 불가
		
		AccessTest at = new AccessTest();
		System.out.println(at.protectedVar);
		at.protectedMethod();

	}

	void asdfMethod(){
		System.out.println(protectedVar);
		protectedMethod();
	}
}
