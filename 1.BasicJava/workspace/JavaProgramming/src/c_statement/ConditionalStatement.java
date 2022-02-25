package c_statement;

import java.util.Scanner;

public class ConditionalStatement {

	public static void main(String[] args) {
		/*
		 * 조건문 
		 * - if문 
		 * - switch문
		 * 
		 * if문 
		 * - if(조건식){} : 조건식의 결과가 true이면 블럭안의 문장을 수행한다. 
		 * - else if(조건식){} : 다수의 조건이 필요할 때 if 뒤에 추가한다. 
		 * - else{} : 조건식 이외의 경우를 위해 추가한다.
		 */

		int a = 4;

		if (a == 1) {
			System.out.println("a == 1");
		} else if (a == 2) {
			System.out.println("a == 2");
		} else if (a == 3) {
			System.out.println("a == 3");
		} else {
			System.out.println("else");
		}

		if (a < 10) {
			System.out.println("a가 10보다 작다.");
		} else if (a < 20) {
			System.out.println("a가 20보다 작다.");
		}

		// 점수가 60점 이상이면 합격 그렇지 않으면 불합격
		int score = 80;
		if (score >= 60) {
			System.out.println("합격");
		} else {
			System.out.println("불합격");
		}

		// 성적에 등급을 부여하는 프로그램
		score = 80;
		String grade = null;

		if (score >= 90) {
			grade = "A";
		} else if (score >= 80) {
			grade = "B";
		} else if (score >= 70) {
			grade = "C";
		} else if (score >= 60) {
			grade = "D";
		} else {
			grade = "F";
		}
		System.out.println(score + "점수에 해당하는 등급은 " + grade + " 입니다.");

		// 기본값 : 자동으로 초기화 될때 저장되는 값
		// 참조형타입 : null
		// boolean : false
		// 그외 : 0

		score = 90;
		grade = null;

		if (score >= 90) {
			grade = "A";
			if (score >= 97) {
				grade += "+";
			} else if (score <= 93) {
				grade += "-";
			} else {
				grade += "0";
			}
		} else if (score >= 70) {
			grade = "C";
			if (score >= 77) {
				grade += "+";
			} else if (score <= 73) {
				grade += "-";
			} else {
				grade += "0";
			}
		} else if (score >= 60) {
			grade = "D";
			if (score >= 67) {
				grade += "+";
			} else if (score <= 63) {
				grade += "-";
			} else {
				grade += "0";
			}
		} else {
			grade = "F";
		}
		System.out.println(score + "점수에 해당하는 등급은 " + grade + " 입니다.");

		//줄맞추기 단축키 : Ctrl + shift + f
		
		/*
		 * switch문
		 * - switch(int/String){ case 1: break; }
		 * - 조건식의 결과는 정수와 문자열만(jDK 1.7부터 문자열 허용) 허용한다.
		 * - 조건식과 일치하는 case문 이후의 문장을 수행한다.
		 */
		
		a = 10;
		
		switch (a) {
		case 10:
			System.out.println("a == 10");			break;
		case 20:
			System.out.println("a == 20");			break;
		default:
			System.out.println("default");			break;
		}
		//특별히 의도하지 않았다면 case사이사이에 break문을 넣어줘야 함.
		
		String b = "a";
		switch (b){
		case "a":
			System.out.println("b == \"a\"");			break;
		case "b":
			System.out.println("b == \"b\"");			break;
		default:
			System.out.println("default");				break;
		}
		
		//주어진 월에 해당하는 계절을 출력해봅시다.
		int month = 1;
		String season = null;
		
		switch ( month ){
		case 12:		case 1:		case 2:
			season = "겨울";			break;
		case 3:		case 4:		case 5:
			season = "봄";			break;
		case 6:		case 7:		case 8:
			season = "여름";			break;
		case 9:		case 10:		case 11:
			season = "가을";			break;
		default:
			System.out.println("1에서 12에 해당하는 월을 입력하세요.");	break;
		}
		System.out.println(season);
		
		score = 50;
		grade = null;
		switch (score/10){
		case 10: case 9:
			grade = "A";	break;
		case 8:
			grade = "B";	break;
		case 7:
			grade = "C";	break;
		case 6:
			grade = "D";	break;
		default:
			grade = "F";	break;
		}
		System.out.println(grade);
		
		
		//숫자를 입력받아 그 숫자가 0인지 아닌지 출력해주세요.
		
		//int num;
		Scanner sc = new Scanner(System.in);
		//System.out.print("숫자를 입력해주세요:");
		//num = Integer.parseInt(sc.nextLine());
		/*if( num == 0 ){
			System.out.println("입력한 숫자는 0입니다.");
		}else{
			System.out.println("입력한 숫자는 0이 아닙니다.");
		}
		*/
		
		//숫자를 입력받아 그 숫자가 홀수인지 짝수인지 출력해주세요.
		/*if ( num % 2 == 0 ){
			System.out.println("입력한 숫자는 짝수입니다.");
		}else if (num % 2 == 1 ){
			System.out.println("입력한 숫자는 홀수입니다.");
		}*/
		
		//정수 3개를 입력받아 합계, 평균, 등급을 출력해주세요.
		/*int num1, num2, num3;
		int sum;
		double avg;
		
		System.out.print("첫 번째 숫자를 입력해주세요:");
		num1 = Integer.parseInt(sc.nextLine());
		System.out.print("두 번째 숫자를 입력해주세요:");
		num2 = Integer.parseInt(sc.nextLine());
		System.out.print("세 번째 숫자를 입력해주세요:");
		num3 = Integer.parseInt(sc.nextLine());
		
		sum = num1 + num2 + num3;
		System.out.println("합계는 " + sum + "입니다.");
		avg = sum / 3.0;
		System.out.println("평균은 " + Math.round(avg * 100) / 100.0 + "입니다.");

		switch ((int)avg/10){
		case 10:	case 9:
			grade = "A";	break;
		case 8:
			grade = "B";	break;
		case 7:
			grade = "C";	break;
		case 6:
			grade = "D";	break;
		default:
			grade = "F";	break;
		}
		System.out.println("등급은 " + grade + "입니다.");
		*/
		//1~100 사이의 랜덤한 수를 3개 발생시키고 오름차순으로 출력해주세요.
		
		int random1 = (int)(Math.random() * 100) + 1;
		int random2 = (int)(Math.random() * 100) + 1;
		int random3 = (int)(Math.random() * 100) + 1;
		
		int order1 = -1, order2 = -1, order3 = -1;
		
		if ( random1 < random2 ){
			if( random1 < random3){
				order1 = random1;
				if(random2 < random3){
					order2 = random2;
					order3 = random3;
				}else{
				order2 = random3;
				order3 = random2;
				}
			}else{
				order1 = random3;
				order2 = random1;
				order3 = random2;
			}
		}else{
			if( random2 < random3 ){
				order1 = random2;
				if( random3 <random1 ){
					order2 = random3;
					order3 = random1;
				}else{
					order2 = random1;
					order3 = random3;
				}
			}else{
				order1 = random3;
				order2 = random2;
				order3 = random1;
			}
		}
		
		System.out.print("가장 작은 숫자: " + order1);
		System.out.print("/ 두번째 숫자: " + order2);
		System.out.println("/ 가장 큰 숫자: " + order3);
		
		if(random1<=random2 && random2<=random3){
			order1 = random1;	order2 = random2; order3 = random3;
		}
		if(random1<=random3 && random3<=random2){
			order1 = random1;	order2 = random3; order3 = random2;
		}
		if(random2<=random1 && random1<=random3){
			order1 = random2;	order2 = random1; order3 = random3;
		}
		if(random2<=random3 && random3<=random1){
			order1 = random2;	order2 = random3; order3 = random1;
		}
		if(random3<=random1 && random1<=random2){
			order1 = random3;	order2 = random1; order3 = random2;
		}
		if(random3<=random2 && random2<=random1){
			order1 = random3;	order2 = random2; order3 = random1;
		}
		System.out.print("가장 작은 숫자: " + order1);
		System.out.print("/ 두번째 숫자: " + order2);
		System.out.println("/ 가장 큰 숫자: " + order3);
		
		
		int[] arr = new int[3];
		arr[0] = random1;
		arr[1] = random2;
		arr[2] = random3;
		int i=0;
		int j=0;
		int len = arr.length;
		int temp;
		
		for (i = 0; i < len-1; i++){
				for(j = i+1; j < len; j++){
					if (arr[i]>arr[j]){
						temp = arr[i];
						arr[i] = arr[j];
						arr[j] = temp;
					}
				}
			}
		System.out.print("가장 작은 숫자: " + order1);
		System.out.print("/ 두번째 숫자: " + order2);
		System.out.println("/ 가장 큰 숫자: " + order3);
		
		if(random1 < random2){
			order1 = random1;
			order2 = random2;
		}else{
			order1 = random2;
			order2 = random1;
		}
		if(random3<order1){
			order3 = order2;
			order2 = order1;
			order1 = random3;
		}else if(random3<order2){
			order3 = order2;
			order2 = random3;
		}
		System.out.print("가장 작은 숫자: " + order1);
		System.out.print("/ 두번째 숫자: " + order2);
		System.out.println("/ 가장 큰 숫자: " + order3);
		
		//==========================================================
		int x = random1;
		int y = random2;
		int z = random3;
		
		if(x>y){
			int tmp = y;
			y = x;
			x = tmp;
		}
		if(x>z){
			int tmp = z;
			z = x;
			x = tmp;
		}
		if(y>z){
			int tmp = z;
			z = y;
			y = tmp;
		}
		System.out.print("가장 작은 숫자: " + x);
		System.out.print("/ 두번째 숫자: " + y);
		System.out.println("/ 가장 큰 숫자: " + z);
		
		int[] arr2 = new int[3];
		int insert;
		arr2[0] = random1;
		arr2[1] = random2;
		arr2[2] = random3;
		i=0;
		j=0;
		len = arr2.length;
				
		for (i = 1; i < len; i++){
				insert = arr[i];
				for(j = i - 1 ; j >= 0 ; j--){
					if(arr2[j] > insert){
						arr[j+1] = arr[j];
					}else{
						break;
					}
				} 
				arr[j+1] = insert;
			}
		System.out.print("가장 작은 숫자: " + order1);
		System.out.print("/ 두번째 숫자: " + order2);
		System.out.println("/ 가장 큰 숫자: " + order3);
		
		
	}
}
