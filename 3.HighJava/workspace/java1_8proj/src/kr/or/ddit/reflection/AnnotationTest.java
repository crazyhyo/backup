package kr.or.ddit.reflection;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import kr.or.ddit.basic.PrintAnnotation;
import kr.or.ddit.basic.Service;

public class AnnotationTest {
	public static void main(String[] args) throws IllegalAccessException, InstantiationException, IllegalArgumentException, InvocationTargetException{
		
		System.out.println("static 변수값 : " 
						+ PrintAnnotation.id);
		
		System.out.println("------------------------------------------");
		
		// reflection 기능을 이용한 메서드 실행하기
		// 선언된 메서드 목록 가져오기
		Method[] declaredMethods =
				Service.class.getDeclaredMethods();
		
		for(Method m : declaredMethods) {
			System.out.println(m.getName()); // 메서드명 출력
			
			// 선언된 PrintAnnotation객체 정보 가져오기
			PrintAnnotation printAnn = m.getDeclaredAnnotation(PrintAnnotation.class);
//			Annotation[] declaredAnnotations = m.getDeclaredAnnotations();
			// count 수만큼 value값 출력하기
			for(int i=0; i<printAnn.count(); i++) {
				System.out.println(printAnn.value());
			}
			
			System.out.println(); // 줄바꿈처리
			
			// reflection 기능을 이용한 메서드 실행하기
			//m.invoke(new Service());
			
			// reflection을 이용한 객체 생성하기
			Class<?> clazz = Service.class;
			
			Service service = (Service) clazz.newInstance();
			
			m.invoke(service);
		}
		
	}
}
