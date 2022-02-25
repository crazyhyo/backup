package util;

import java.util.Scanner;

public class ScanUtil {
	
//	Scanner s = new Scanner(System.in);			//인스턴스 변수, 객체생성을 해야만 사용할 수 있음 = 객체생성을 해야 메모리에 올라감
	private static Scanner s = new Scanner(System.in);
	
	//자주 사용되는 메서드는 객체생성을 하지 않기 위해 static을 붙인다.
	public static String nextLine(){
		return s.nextLine();					//인스턴스 변수일 때 컴파일에러, public s
	}
	
	public static int nextInt(){
		int num = 0;
		while(true){
			try {
				num = Integer.parseInt(s.nextLine());
			} catch (Exception e) {
				System.out.println("잘못 입력하셨습니다. 숫자를 입력해주세요.");
				continue
				;
			}
			break;
		}
		return num;
	}
}
