package e_oop;

import java.util.Scanner;


public class Asdf {
	
	public static void main(String[] args) {
		System.out.println("     나의 연애 유형은?");
		System.out.println("~~말해 YES or NO!~~");
		
		System.out.println("\nSTART!");
		
		Scanner sc = new Scanner(System.in);
		
		String[] tests = new String[9];
		tests[0] = "나는 금사빠다(* 금방 사랑에 빠진다)";
		tests[1] = "연애할 때 끌려다니는 타입이다";
		tests[2] = "데이트코스는 미리 짜는게 편하다";
		tests[3] = "감정기복이 크지 않다";
		tests[4] = "감정표현에 솔직한 편이다";
		tests[5] = "활동적인 데이트가 좋다";
		tests[6] = "연락이 없어도 믿고 기다리는 편이다";
		tests[7] = "이성친구는 존재할 수 없다";
		tests[8] = "아무것도 아닌 일에 쉽게 섭섭함이 쌓인다";
		
		String[] testResult = new String[4];
		testResult[0] = "A: 스페셜티 카페라떼 프리미엄 타입\n"
				+ "서로에 대한 신뢰감이 깊고, 존중해주는\n"
				+ "어른스러운 연애를 하는 타입!";
		testResult[1] = "B: 스페셜티 카페라떼 타입\n"
				+ "구속을 하는 것도, 받는 것도 싫은\n"
				+ "자유로운 연애를 하는 타입!";
		testResult[2] = "C: 아침에주스 오렌지 타입\n"
				+ "이것은 의리인가 사랑인가...\n"
				+ "친구같이 편안한 연애를 하는 타입!";
		testResult[3] = "D: 아침에주스 유기농 타입\n"
				+ "무조건 잘해주고, 무조건 맞춰주는\n"
				+ "다 퍼주는 연애를 하는 타입!";
		Answer asdf = new Answer();
		
		int result = 0;
		while(result < 9){
			System.out.print(tests[result] + "(y/n):");
			result = asdf.answer(result, sc.nextLine());
		}
		
		System.out.println("\n==============================\n"
				+ "                    결 과 보 기\n"
				+ "==============================\n");
		
		switch(result){
		case 9:		System.out.println(testResult[0]); break;
		case 10:	System.out.println(testResult[1]); break;
		case 11:	System.out.println(testResult[2]); break;
		case 12:	System.out.println(testResult[3]); break;
		
		/*
		 * void q1(){
		 * 		System.out.println(questions[0]);
		 * 		String a = s.nextLine();
		 * 		if(a.equals("Y")){
		 * 			q2();
		 * 		}else{
		 * 			q4();
		 * 		}
		 * }
		 * 
		 * 과제 : 성적처리 프로그램을 메서드 이용해서 작성하시오.
		 */
		}
	}

}
