package b_operator;

import java.util.Scanner;

public class Etc {

	public static void main(String[] args) {
		/*
		 * 비트 연산자
		 * - |, &, *, ~ , <<, >>
		 * - 비트 단위로 연산한다.
		 * 
		 * 기타 연산자
		 * - .(참조연산자) : 특정 범위 내에 속해 있는 멤버를 지정할 때 사용한다.
		 * - ?:(삼항연산자) : 조건식 ? 조건식이 참일 경우 수행할 문장 : 저건식이 거짓일 경우 수행할 문장
		 */
		
		//1byte : 8개의 비트로 이루어짐, 1bit : 컴퓨터가 인식할 수 있는 가장 작은 단위
		System.out.println(10 | 15); //|: 둘다 0인 경우 0 그외 1
		// 10 = 00001010
		// 15 = 00001111
		// 10 | 15 = 00001111 = 15
		
		//비트연산은 실제상황에서 거의 사용하지 않음
		//특수한 분야에서 사용
		
		int x = 10;
		int y = 20;
		int result = x < y? x : y;
		System.out.println(result);
		
		//주민등록번호 뒷자리의 첫번째 숫자가 1이면 남자 2면 여자
		int regNo = 1;
		String gender = regNo % 2 == 1 ? "남자" : "여자";
		System.out.println("당신의 성별은 " + gender + " 입니다.");
		
		gender = regNo == 1 ? "남자" : (regNo == 2 ? "여자" : "확인불가");
		
		//2개의 숫자를 입력받고, 둘 중 더 큰 숫자를 출력해주세요.
		Scanner sc = new Scanner(System.in);
		/*System.out.print("첫 번째 숫자를 입력하세요: ");
		int a = Integer.parseInt(sc.nextLine());
		System.out.print("두 번째 숫자를 입력하세요: ");
		int b = Integer.parseInt(sc.nextLine());
		int largeNum = a > b ? a : b;
		System.out.println("작지 않은 숫자는 " + largeNum + "입니다.");*/
		
		//숫자를 입력받고, 그 숫자가 1이나 3이면 남자를 2나 4면 여자를 출력해주세요.
		//그외의 숫자를 입력하면 확인불가를 출력해주세요.
		
		System.out.print("주민등록번호 뒷자리 첫번째 숫자를 입력하세요: ");
		int regNoInput = Integer.parseInt(sc.nextLine());
		gender = regNoInput == 1 || regNoInput == 3 ? "남자" : (regNoInput == 2 || regNoInput == 4 ? "여자" : "확인불가");
		System.out.println("당신의 성별은 " + gender + " 입니다.");

	}

}
