package b_operator;

import java.util.Scanner;

public class ComparingOperator {

	public static void main(String[] args) {
		/*
		 * 비교연산자
		 * - <, >, <=, >=, ==, !=
		 * - 문자열 비교 : equals()
		 * 
		 */
		
		int x = 10;
		int y = 20;
		boolean b = x < y; //비교연산자의 연산결과는 boolean이다.
		System.out.println(b);
		b = x <= y - 15;
		System.out.println(b);	//산술연산자가 비교연산자보다 우선순위가 높다
		
		String str1 = "abc";
		String str2 = new String("abc");	//이제 새로운 주소를 참조형(클래스)를 초기화하는 경우에는 new로 초기화를 해줌
		//그런데 String 타입은 생략해도 되도록 만들어 둠.
		//String str1 = "abc"; String str2 = "abc";
		//위의 경우 두 스트링이 같은 내용을 담고 있다면 str1과 str2는 같은 주소를 갖는다
		//내용을 하나 저장공간에 만들고 그 주소를 str1과 str2가 같이 쓴다
		b = str1 == str2; //문자열의 내용이 아닌 주소를 비교한 것이다.
		System.out.println(b);
		
		//String의 내용을 비교하기 위해서는 equals()메서드를 사용한다. equals는 String class안의 메서드이다.
		b = str1.equals(str2);
		System.out.println(b);
		
		Scanner s = new Scanner(System.in);
		System.out.println(s);
		
		//다음의 문장들을 코드로 작성해주세요.
		//x는 y보다 작거나 같다.
		b = x <= y;
		System.out.println(b);
		//x + 5 와 y는 같다.
		b = x + 5 == y;
		System.out.println(b);
		//y는 홀수이다.
		b = y % 2 == 1;
		System.out.println(b);
		//"기본형"과 "참조형"은 다르다.
		//b = "기본형" != "참조형";	오답
		b = !"기본형".equals("참조형");	//문자열 비교 주의
		System.out.println(b);
		
	}

}
