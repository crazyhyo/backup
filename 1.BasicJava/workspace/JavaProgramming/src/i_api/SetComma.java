package i_api;

import java.util.Scanner;



public class SetComma {

	public static void main(String[] args) {
		/*
		 * 숫자를 입력받아 입력받은 숫자에 3자리마다 콤마(,)를 붙여 출력해주세요.
		 * 1,234,567
		 * 
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("숫자를 입력해주세요: ");
		String input = sc.nextLine();
		System.out.println(input);
		String temp = "";
		String temp2 = "";
		int j = 0;
		for(int i = input.length() - 1; i >= 0; i--){
			if(j > 0 && j % 3 == 0){
				temp += ",";
			}
			temp += input.charAt(i);
			j++;
		}
		for(int i = temp.length() - 1; i >= 0; i--){
			temp2 += temp.charAt(i);
		}
		System.out.println(temp2);
		System.out.println(addComma(input));
		
		/*
		 * int count = 0;
		 * for(int i = num.length() - 1; i >=0; i--){
		 * 		num2 = num.charAt(i) + num2;
		 * 		count++;
		 * 		if(count % 3 == 0 && count != num.length()){
		 * 			num2 = "," + num2;
		 * 		}
		 * }
		 */
	}
	static String addComma(String input){
		if(input.length() <= 3)
			return input;
		String tempstr = input.substring(0, input.length() - 3);
		String remainder = input.substring(input.length() - 3, input.length());
		String temp = "";
		switch(input.length() % 3){
		case 0:
			for(int i = 0; i < tempstr.length(); i++){
				temp += tempstr.charAt(i);
				if(i % 3 == 2)					temp += ",";
			}
			break;
		case 1:
			for(int i = 0; i < tempstr.length(); i++){
				temp += tempstr.charAt(i);
				if(i % 3 == 0)					temp += ",";
			}
			break;
		case 2:
			for(int i = 0; i < tempstr.length(); i++){
				temp += tempstr.charAt(i);
				if(i % 3 == 1)					temp += ",";
			}
			break;
		}
		temp += remainder;
		return temp;
	}
}
