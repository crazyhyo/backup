package c_statement;

import java.util.Scanner;

public class RepetitiveStatement {
	
	public static boolean	isEven(long num){
		return num % 2 == 0;
	}
	
	public static long process(long num1){
		long result = num1 * 3 + 1;
		while(	isEven(result) ){
			result /= 2;
		}
		return result;
	}

	public static void main(String[] args) {
		/*
		 * 반복문
		 * - for문
		 * - while문
		 * - do while문
		 * 
		 * for문
		 * - for(초기화; 조건식; 증감식){}
		 * - 포함하고 있는 문장들을 정해진 횟수만큼 반복하는 문장
		 * 
		 */

/*		for(int i = 0; i < 10; i++){
			//초기화 : 조건식과 증감식에 사용할 변수 초기화
			//조건식 : 연산결과가 true이면 블럭안의 내용을 수행
			//증감식 : 변수를 증가/감소시켜 반복문을 제어
			System.out.println(i + "번째 반복문");
		}*/
		
/*		int sum = 0;
		sum += 1;
		sum += 2;
		sum += 3;
		sum += 4;
		sum += 5;
		sum += 6;
		sum += 7;
		sum += 8;
		sum += 9;
		sum += 10;
		System.out.println(sum);
		
		sum = 0;
		for(int i = 1; i <= 100; i++){
			sum += i;
		}
		System.out.println(sum);
		
		sum = 0;
		for(int i = 100; i >= 1; i--){
			sum += i;
		}*///감소하는 부등식 사용시 조건식 주의
/*		System.out.println(sum);
		
		int[] arr = new int[10];
		for(int i = 0; i < 10; i++)	arr[i] = i;
		
		for(int e : arr){
			System.out.print(e + " ");
		}*/
		System.out.println("\n");
		
/*		sum = 0;
		for(int i = 0; i < 101 ; i = i + 2){
			sum += i;
		}
		System.out.println(sum);
		sum = 0;
		for(int i = 1; i < 101 ; i++){
			if(i % 2 == 0)	sum += i;
		}
		System.out.println(sum);
		*/
		//1부터 100까지 홀수의 합을 출력해주세요
/*		sum = 0;
		for(int i = 1; i < 100 ; i = i + 2){
			sum += i;
		}
		System.out.println(sum);
		sum = 0;
		for(int i = 1; i < 100 ; i++){
			if(i % 2 == 1)	sum += i;
		}
		System.out.println(sum);
		*/
		/*
		 * 2 * 1 = 2
		 * 2 * 2 = 4
		 * 2 * 3 = 6
		 * 2 * 4 = 8
		 * ...
		 */
/*		System.out.println();
		for (int i = 1; i <= 9; i++) {
			System.out.println(2 + " * " + i + " = " + 2 * i );
		}
		System.out.println();*/
		/*
		 * 2 * 1 = 2	3 * 1 = 3	4 * 1 = 4
		 * 2 * 2 = 4	3 * 2 = 6	4 * 2 = 8
		 * ...
		 */

		/*for (int j = 2; j <= 9; j++) {
			for (int i = 1; i <= 9; i++) {
				System.out.print(j + " * " + i + " = " + j * i + "\t");
			}
			System.out.println();
		}
		System.out.println();
		*/
/*		for (int i = 1; i <= 9; i++) {
			
			for (int j = 2; j <= 9; j++) {
				if(i == 1)		System.out.print("["+j+"단]" + "\t\t");
			}
			System.out.println();
			for (int j = 2; j <= 9; j++) {
				System.out.print(j + " * " + i + " = " + j * i + "\t");
			}
		}*/
		/*
		 * while문
		 * - while(조건식){}
		 * - 포함하고 있는 문장들을 조건식이 만족하는 동안 반복하는 문장
		 * - 반복횟수가 정확하지 않은 경우에 주로 사용한다.
		 */
		
/*		int a = 1;
		//a에 2씩 곱해서 1000이상이 되려면 몇번을 곱해야 하는가?
		int count = 0;
		while( a < 1000 ){
			a *= 2;
			count++;
			System.out.println(count + " : " + a);
		}*/
		
		/*
		 * do-while문
		 * - do{}while(조건식);
		 * - 최소한 한번의 수행을 보장한다.
		 * - 뭔가를 실행했을 때, 다시한번 실행할지 결정해야 할 때 사용
		 */
		
		//숫자 맞추기 게임
		/*int answer = (int) (Math.random()*100) + 1;
		Scanner sc = new Scanner(System.in);
		int input = 0;
		
		do{
			System.out.println("1부터 100 사이의 수를 입력해주세요.");
			input = Integer.parseInt(sc.nextLine());
			if(input > answer)		System.out.println(input + "보다 작습니다.");
			else if(input < answer)	System.out.println(input + "보다 큽니다.");
			else					System.out.println("정답입니다");
		}while(	input != answer );
		*/
		//
		
		
/*		Scanner sc = new Scanner(System.in);
		long input, count;
		count = 0;
		System.out.println("수를 입력해주세요.");
		input = Integer.parseInt(sc.nextLine());
		while( process(input) != 1){
			count += 1;
			System.out.println(count + "번째 숫자: " + input);
			input = process(input);
		}
		System.out.println(count+1 + "번째 숫자: 1");*/
		
		//이름붙은 반복문
		outer : for(int i = 2; i <= 9; i++){
			for(int j = 1; j <= 9; j++){
				if( j == 5){
//					break;	//가장 가까운 반복문 하나를 빠져나간다.
//					break outer; // outer라는 이름의 반복문을 빠져나간다.
//					continue; //가장 가까운 반복문의 현재 반복회차를 빠져나간다.
//					continue outer; // outer라는 이름의 현재 반복회차를 빠져나간다.
//					for문에서 continue는 빠져나가는 반복문의 증감식을 실행시킨다.
				}
				System.out.println(i + " * " + j + " = " + i * j);
			}
			System.out.println();
		}
		
/*		for(int i = 5 ; i > 0 ; i--){
			for(int j = 0; j < i; j++){
				System.out.print("*");
			}
			System.out.println();
		}
		
		for(int i = 0 ; i < 5 ; i++){
			for(int j = 0; j <= i; j++){
				System.out.print("*");
			}
			System.out.println();*/
	}

}
