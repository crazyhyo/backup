package i_api;

import java.util.Arrays;

public class StringClass {
	public static void main(String[] args) {
		/*
		 * String
		 * - 여러개의 문자를 사용하기 쉽게 만들어 놓은 클래스
		 * 
		 * String의 주요 메서드
		 * - equals() : 문자열의 내용이 같은지 반환한다.
		 * - length() : 문자열의 길이를 반환한다.
		 * - charAt() : 특정 인덱스에 위치한 문자를 반환한다. 리턴타입은 char이다.
		 * - substring() : 문자열의 특정 부분을 잘라서 반환한다.	2개의 파라미터를 받을 때 첫 번째 입력숫자는 시작 인덱스, 두 번째 입력숫자 - 1이 끝나는 인덱스
		 * - indexOf() : 문자열 내의 특정 문자의 인덱스를 반환한다.
		 * - contains() : 문자열이 특정 문자열을 포함하고 있는지 여부를 반환한다.
		 * - split() : 문자열을 특정 문자를 기준으로 나누어 배열형태로 반환한다.
		 * - trim() : 문자열 앞뒤의 공백을 제거해 반환한다.
		 * - valueOf() : 다른 타입의 데이터를 문자열로 변환해 반환한다.
		 */
		//프로그램 자체가 api, 프로그램을 사용하는 방법이 라이브러리
		
		boolean equals = "문자열".equals("문자열");
		System.out.println(equals);
		
		String str1 = "문자열";
		String str2 = null;
		System.out.println(str1.equals(str2));
//		System.out.println(str2.equals(str1));
		
		//null인 객체는 메서드를 사용할 수 없다.
		
		String str = "12345";
		int length = str.length();
		for(int i = 0; i < length; i++){
			char charAt = str.charAt(i);
			System.out.println(charAt);
		}
		String rev = "";
		for(int i = length - 1; i >= 0; i--){
			rev += str.charAt(i);
		}
		System.out.println(rev);
		
		str = "0123456789";
		String sub1 = str.substring(3);
		System.out.println(sub1);
		String sub2 = str.substring(5, 8);
		System.out.println(sub2);
		
		str = "수박\n\t 오렌지 귤 블루베리";
		int index = str.indexOf("오렌지");
		System.out.println(index);
		
		//substring과 indexOf를 조합해서 문자열 자르기
		String[] menu = {
				"수박 20000원",
				"오렌지 100000원",
				"귤 500원",
				"블루베리 3000원"
		};
		
		for(int i = 0; i < menu.length; i++){
			String name = menu[i].substring(0,menu[i].indexOf(" "));
			System.out.println(name);
		}
		for(int i = 0; i < menu.length; i++){
//			String name = menu[i].substring(menu[i].indexOf(" ") + 1, menu[i].length() - 1);
			int price = Integer.parseInt(menu[i].substring(menu[i].indexOf(" ") + 1, menu[i].indexOf("원")));
//			int price = Integer.parseInt(menu[i].substring(menu[i].indexOf(" ") + 1));		//에러
			System.out.println(price);
		}
		//integer.parseint : 문자열을 숫자로 변환
		int testint = 0;
		double testdouble = 0;
		System.out.println(String.valueOf(testint));
		System.out.println(String.valueOf(testdouble).length());
		
		str = "abcd";
		boolean contains = str.contains("abcde");
		System.out.println(contains);
//		Byte.parseByte(s);
//		Float.parseFloat(s);
//		Double.parseDouble(s);
//		Integer.parseInt(s);
//		Long.parseLong(s);
//		Boolean.parseBoolean(s);
//		Short.parseShort(s);
		
		for(int i = 0; i < menu.length; i++){
			if(menu[i].contains("오렌지")){
				System.out.println("오렌지는 " + i + "번 인덱스에 있습니다.");
			}
		}
		
		str = "a/b/c";
		String[] split = str.split("/");
		System.out.println(Arrays.toString(split));
		
		for(int i = 0; i < menu.length; i++){
			String[] s = menu[i].split(" ");
			System.out.println("이름: " + s[0] + " / 가격: " + s[1]);
		}
		str = "  문자열   ";
		String trim = str.trim();
		System.out.println("[" + str + "] -> [" + trim + "]");
		
		//trim : 사용자의 입력실수를 방지하기 위하여 사용한다.
		
		String id = " myid";
		String password = "mypassword ";
		System.out.println(id);
		System.out.println(password);
		System.out.println(id.trim());
		System.out.println(password.trim());
		
		int num = 10;
		str = num + "";
		str = String.valueOf(num);
		
		String[][] test = new String[menu.length][2];
		for(int i = 0; i < menu.length; i++){
			test[i] = menu[i].split(" ");
			System.out.println(Arrays.toString(test[i]));
		}
	}
}
