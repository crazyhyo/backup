package a_variable;

import java.util.Scanner;

public class Join {

	public static void main(String[] args) {
		
		/*
		 * 다음과 같은 프로그램을 작성해주세요
		 * 
		 * ============ 회원가입 ============
		 * 아이디>admin
		 * 비밀번호(4자리숫자)>1234
		 * 이름>홍길동
		 * 나이>30
		 * 키>185.5
		 * ===============================
		 * 회원가입 완료!!
		 * ============ 내정보==============
		 * 아이디 : admin
		 * 비밀번호 : 1234
		 * 이름 : 홍길동
		 * 나이 : 30세
		 * 키 : 185.5cm
		 * ================================
		 * */
		Scanner sc = new Scanner(System.in);
		
		System.out.println("============ 회원가입 ============");
		System.out.print("아이디>");
		String userId = sc.nextLine();
		System.out.print("비밀번호(4자리숫자)>");
/*		try{
			Integer.parseInt(sc.nextLine());
		}catch(NumberFormatException e){
			e.printStackTrace();
			System.out.println("숫자4자리가 아닙니다.");
		}*/
		/*System.out.println("다시한번 입력해주세요.");*/
		int userPw = Integer.parseInt(sc.nextLine());
		System.out.print("이름>");
		String userName = sc.nextLine();
		System.out.print("나이>");
		int userAge = Integer.parseInt(sc.nextLine());
		System.out.print("키>");
		double userHeight = Double.parseDouble(sc.nextLine());
		System.out.println("================================");
		System.out.println("회원가입 완료!!");
		System.out.println("============ 내 정보==============");
		System.out.println("아이디 : " + userId);
		System.out.println("비밀번호 : " + userPw);
		System.out.println("이름 : " + userName);
		System.out.println("나이 : " + userAge + "세");
		System.out.println("키 : " + userHeight + "cm");
		System.out.println("================================");
		
	}

}
