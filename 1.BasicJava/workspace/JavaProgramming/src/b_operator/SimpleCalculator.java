package b_operator;

import java.util.Scanner;

public class SimpleCalculator {

	public static void main(String[] args) {
		/*
		 * 두개의 숫자와 연산자를 입력받아 연산결과를 알려주는 프로그램을 만들어주세요.
		 */
		Scanner sc = new Scanner(System.in);
		double firstNum, secondNum, result;
		String operator;
		System.out.print("첫 번째 숫자를 입력하세요: ");
		firstNum = Double.parseDouble(sc.nextLine());
		System.out.print("연산자를 입력하세요: ");
		operator = sc.nextLine();
		System.out.print("두 번째 숫자를 입력하세요: ");
		secondNum = Double.parseDouble(sc.nextLine());
		
		result = operator.equals("+") ? firstNum + secondNum :
				 (operator.equals("-") ? firstNum - secondNum :
				 (operator.equals("*") ? firstNum * secondNum :
				 (operator.equals("/") ? firstNum / secondNum :
				 (operator.equals("%") ? firstNum % secondNum: -65536.0))));
		
		System.out.print("입력하신 식은 " + firstNum + " " + operator + " " + secondNum + "입니다.");
		
		System.out.println(result != -65536.0 ? "계산결과는 " + Math.round(result * 100) / 100.0 + "입니다." : "유효하지 않은 연산자입니다.");
		
		
	}

}
