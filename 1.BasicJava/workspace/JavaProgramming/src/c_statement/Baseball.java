package c_statement;

import java.util.Scanner;

public class Baseball {

	public static void main(String[] args) {
		/*
		 * 세 자리의 랜덤한 숫자 발생(각각 1~9), 중복되지 않음
		 * 정답 : 123		입력 : 135
		 * ->숫자와 자리수가 같은 숫자의 개수 : strike
		 * ->숫자가 같지만 자리수가 다른 숫자의 개수 : ball
		 * ->일치하지 않는 숫자의 개수 : out
		 * 
		 * 
		 * 248 : 1s 2b 0o
		 * 428 : 3s
		 */
		
		System.out.println("숫자야구를 시작합니다.");
		System.out.println("================정답 생성중================\n\n\n");
		int answer1 = (int)(Math.random() * 9) + 1;
		int answer2 = (int)(Math.random() * 9) + 1;
		while(answer2 == answer1)									answer2 = (int)(Math.random() * 9) + 1;
		int answer3 = (int)(Math.random() * 9) + 1;
		while(answer3 == answer1 ||	answer3 == answer2)				answer3 = (int)(Math.random() * 9) + 1;
		System.out.println("================정답 생성완료===============");
		
		/*
		 * int a1,a2,a3;
		 * do{
		 * 		a1 = (int)(Math.random() * 9) + 1;
		 * 		a2 = (int)(Math.random() * 9) + 1;
		 * 		a3 = (int)(Math.random() * 9) + 1;
		 * }while(a1 == a2 || a1 == a3 || a2 == a3)
		 */
		
		System.out.println(answer1 + "/" + answer2 + "/" + answer3);
		
		Scanner sc = new Scanner(System.in);
		int strike, ball, out, count;
		count = 0;
		
		do{
			count += 1;	strike = 0;	ball = 0;	out = 0;		
			System.out.print("첫 번째 숫자를 입력하세요: ");
			int input1 = Integer.parseInt(sc.nextLine());
			System.out.print("두 번째 숫자를 입력하세요: ");
			int input2 = Integer.parseInt(sc.nextLine());
			System.out.print("세 번째 숫자를 입력하세요: ");
			int input3 = Integer.parseInt(sc.nextLine());
		
			if(input1 == answer1)									strike += 1;
			else if(input1 == answer2 || input1 == answer3)			ball += 1;
			if(input2 == answer2)									strike += 1;
			else if(input2 == answer1 || input2 == answer3)			ball += 1;
			if(input3 == answer3)									strike += 1;
			else if(input3 == answer1 || input3 == answer2)			ball += 1;
		
			out = 3 - (strike + ball);
		
			System.out.println("입력숫자 " + input1 + input2 + input3 + ": "+ strike + "S/" + ball + "B/" + out + "O 입니다.");
		}while(strike != 3);
		
/*		do{
			count += 1;	strike = 0;	ball = 0;	out = 0;		
			System.out.print("세 자리 숫자를 입력하세요: ");
			int input = Integer.parseInt(sc.nextLine());
			
			if(input/100 == answer1)													strike += 1;
			else if(input/100 == answer2 || input/100 == answer3)						ball += 1;
			if((input/10 % 10) == answer2)												strike += 1;
			else if((input/10 % 10) == answer1 || (input/10 % 10) == answer3)			ball += 1;
			if((input % 10) == answer3)													strike += 1;
			else if((input % 10) == answer1 || (input % 10) == answer2)					ball += 1;
		
			out = 3 - (strike + ball);
		
			System.out.println("입력숫자 " + input + ": "+ strike + "S/" + ball + "B/" + out + "O 입니다.");
		}while(strike != 3);
		*/
		
		/*
		 * int i3 = input % 10;
		 * input /= 10;
		 * int i2 = input % 10;
		 * input /= 10;
		 * int i1 = input % 10;
		 * 
		 * while 안에 선언된 변수는 이름 충돌을 일으키지 않는다 - 반복할 때마다 이름이 지워진다?
		 * 반복문 밖에서는 반복문 안에 있는 변수에 접근 불가
		 */
		
		System.out.println();
		System.out.println("총 " + count + "회 시도.");

	}
}