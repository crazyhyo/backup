package a_variable;	// 패키지 : 클래스의 위치, 반드시 필요

import java.util.Scanner;

//import : 다른 패키지에 있는 클래스의 위치를 알려주는 것, 위치는 반드시 패키지와 클래스 사이에 위치
//Ctrl + Shift + o


public class Variable { //클래스 : 데이터와 기능의 집합

	public static void main(String[] args) { //메서드 : 명령문의 집합
		//main메서드 : 프로그램의 시작과 끝
		
		//주석 : 프로그램 코드로 인식되지 않는 문장(주로 코드를 설명하는데 사용)
		
//		한줄주석 : ctrl + shift + c
//		한줄주석
//		한줄주석
//		한줄주석
//		한줄주석
		
		/*
		 * 데이터
		 * 
		 * 1. 기본형
		 * - 숫자
		 * - 문자
		 * - 논리
		 * 
		 * 2. 참조형(데이터가 위치한 주소를 저장)
		 * - 배열(형태가 같은 여러개의 데이터를 묶어서 사용)
		 * - 클래스(형태가 다른 여러개의 데이터와 기능을 묶어서 사용)
		 *  
		 */
		
		/*
		 * 기본형 타입
		 * - 정수 : byte(1), short(2), *int(4/약20억), long(8)
		 * - 실수 : float(4/7자리), *double(8/15자리)
		 * - 문자 : char(2)
		 * - 논리 : boolean(1)
		 * 		별표는 많이 사용 한다는 뜻
		 * 참조형 타입
		 * - 문자열 : String(4)
		 * 
		 * 명명규칙
		 * - 영문자 대소문자, 한글, 숫자, 특수문자('_', '$')를 사용할 수 있다.
		 * - 숫자로 시작할 수 없다.
		 * - 예약어는 사용할 수 없다.
		 * - [낙타식 표기법을 사용한다.(mySimpleVariable)]
		 * - [클래스명의 첫글자는 대문자로 한다.(MySimpleClass)]
		 * 		단어가 바뀔 때 대문자를 사용하는 표기법 = 낙타식 표기법 / 기본은 소문자 사용
		 * 		이렇게 하지 않아도 개발은 됨
		 */
		//변수 선언(값을 저장할 공간을 만드는 것) 데이터형(타입) 변수이름 [초기화];
		//중괄호 안에서 변수의 이름은 중복되지 않아야 함
		int x; //;(세미콜론) : 문장의 마침표
		long y;
		float z;
		char abc;
		boolean boolean$;
		String name123;
		
		//9가지 타입을 모두 사용해 9개의 변수를 선언해주세요.
		byte constrainedInteger;
		short integer;
		int generalInteger;
		long largeInteger;
		float realNumber;
		double generalRealNumber;
		char containsOneCharacter;
		boolean trueOrFalse;
		String containsMultipleCharacters;
		
		//초기화(변수에 처음으로 값을 저장하는 것)
		//=(대입연산자) : 오른쪽의 값을 왼쪽의 변수에 저장한다.
		//변수를 선언한 이후에는 변수의 이름을 가직 변수를 사용한다.
		x = 10; //타입에 맞는 값을 저장해야 한다.
		y = 20L; //접미사 L을 붙여야 long타입이 된다.
		z = 3.14f; //접미사 f를 붙여야 float타입이 된다. 실수를 그냥 쓰면 double타입임
		abc = '가'; //따옴표 안에 반드시 한 글자를 넣어야 한다.
		boolean$ = true; //true, false중 하나의 값으로 설정해야 한다.
		name123 = "가나다라 abcd 1234"; //쌍따옴표로 묹열을 표현한다.
		
		//위에서 선언한 9개의 변수들을 초기화 해주세요.

		constrainedInteger = 1;
		integer = 2;
		generalInteger = 3;
		largeInteger = 4L;
		realNumber = 5.1f;
		generalRealNumber = 6.2;
		containsOneCharacter = 'a';
		trueOrFalse = false;
		containsMultipleCharacters = "asdf";
		
		int a = 10;
		a = 20;
		
		//형변환(데이터의 타입을 다른 타입으로 변경하는 것)
		int _int = 10;
		long _long = 20L;
		
		_int = (int)_long;
		_long = _int; //표현범위가 작은 타입에서 큰 타입으로의 형변환은 생략할 수 있다.
		
		_int = _int + (int)_long; //서로 다른 타입은 연산할 수 없다.
		
		//변수 3개를 선언해 변수의 타입과 다른 타입의 값으로 초기화 해주세요.
		
		byte ex1 = (byte)3L;		//long -> byte
		short ex2 = (short)3.0f;	//float -> short
		int ex3 = (int)3.49;		//double -> int
		int ex4 = (int)3.51;		//double -> int
		char ex5 = (char)_int;
		// 기본형타입과 참조형 타입은 형변환이 안된다
		// 기본형 타입중에서 boolean타입은 형변환이 안된다.
		int ex6 = (int)0.5;
		// 실수->정수로 바꿀 때 양수는 내림하고 음수는 올림하는듯?
		
		//출력(콘솔)
		System.out.print("출력 후 줄바꿈을 안함");
		System.out.print("출력 후 줄바꿈을 안함");	//출력후 줄바꾸지 않음
		System.out.printf("출력 포맷 지정");		//포맷을 지정 출력명령
		System.out.println(boolean$);			//출력후 마지막에 줄바꿈 문자 삽임
		System.out.println(trueOrFalse);
		//실행 단축키 : ctrl + f11
		//탈출문자(Escape문자) : 원래 역할에서 탈출하게 해준다.
		System.out.println("탭은 \t4칸에 맞춰 띄워줍니다.");
		System.out.println("줄바꿈을 \n해줍니다.");
		System.out.println("\"쌍따옴표를 넣어줍니다.\"");
		System.out.println("\\역슬래쉬를 넣어줍니다.");
		
		//입력		입력하는데는 java.util.Scanner 패키지를 import해야 함
		Scanner sc = new Scanner(System.in); //입력받기 위한 클래스, 컴파일에러 발생
		//한 클래스 안에서 다른 클래스를 사용하려면 기본적으로는 자신이 속한 패키지의 클래스만 사용가능
		//다른 패키지에 들어있는 클래스를 사용하려면 import 명령 필요
		/*System.out.println("아무거나 입력해주세요>");
		String str = sc.nextLine();	//sc에 문자열을 입력을 받는 명령어
		System.out.println("입력받은 내용 : " + str);*/
		
		/*System.out.println("숫자를 입력해주세요>");
		int nextInt = sc.nextInt();	//sc에 숫자를 입력을 받는 명령어, nextInt는 버그가 있어서 사용 않는게 좋음
		System.out.println("입력받은 숫자 : " + nextInt);
		System.out.println("문자열 다시 입력>");
		String nextLine = sc.nextLine();
		System.out.println("입력받은 문자열 : " + nextLine);
		System.out.println("입력끝!!");
		*/
		//그렇다면 숫자는 어떻게 입력받느냐? 문자열 입력받은 후 형변환
		/*System.out.println("숫자 입력>");
		int number = Integer.parseInt(sc.nextLine());	//sc에 숫자를 입력을 받는 명령어, nextInt는 버그가 있어서 사용 않는게 좋음
		//(String)->(int)는 참조형->기본형 형변환이 안되기 때문에 일반적인 방법으로 형변환 불가 그래서 메서드 사용
		System.out.println("입력받은 숫자 : " + number);*/
//		double d = Double.parseDouble(sc.nextLine());
		
		//자신의 이름을 저장할 변수를 선언하고 Scanner를 사용해 이름을 저장해주세요.
		//자신의 나이를 저장할 변수를선언하고 Scanner를 사용해 나이를 저장해주세요.
		//이름과 나이를 출력해주세요.
		Scanner scProblem = new Scanner(System.in);
		System.out.println("이름을 입력하세요>");
		String myName = scProblem.nextLine();
		System.out.println("나의 이름은 " + myName + "입니다.");
		System.out.println("나이를 입력하세요>");
		int myAge = Integer.parseInt(scProblem.nextLine());
		System.out.println("나는 " + myAge + "살 입니다.");
		
	}

}

