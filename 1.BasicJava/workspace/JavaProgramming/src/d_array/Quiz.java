package d_array;

import java.util.Arrays;
import java.util.Scanner;
//컨트롤 쉬프트 o

public class Quiz {

	public static void main(String[] args) {
		
		int money = (int)(Math.random() * 500) * 10;
/*		int[] coin = {500, 100, 50, 10};
		
		System.out.println("거스름돈 : " + money);
		*/
		/*
		 * 거스름돈에 동전의 단위마다 몇개의 동전이 필요한지 출력하세요.
		 * 
		 *  거스름돈 : 2860원
		 *  500원 : 5개
		 *  100원 : 3개
		 *  50원 : 1개
		 *  10원 : 1개
		 */
		
/*		int coinCount500 = 0;
		int coinCount100 = 0;
		int coinCount50 = 0;
		int coinCount10 = 0;*/
		
/*		while(true){
			if(money - (coinCount500 + 1) * 500 >= 0)	coinCount500++;
			else{
				money -= coinCount500 * 500;
				break;
			}
		}
		while(true){
			if(money - (coinCount100 + 1) * 100 >= 0)	coinCount100++;
			else{
				money -= coinCount100 * 100;
				break;
			}
		}
		while(true){
			if(money - (coinCount50 + 1) * 50 >= 0)	coinCount50++;
			else{
				money -= coinCount50 * 50;
				break;
			}
		}
		while(true){
			if(money - (coinCount10 + 1) * 10 >= 0)	coinCount10++;
			else{
				money -= coinCount10 * 10;
				break;
			}
		}*/
		
/*		coinCount500 = money / 500;
		money -= coinCount500 * 500;
		coinCount100 = money / 100;
		money -= coinCount100 * 100;
		coinCount50 = money / 50;
		money -= coinCount50 * 50;
		coinCount10 = money / 10;
		money -= coinCount10 * 10;
		
		
		
		System.out.println("500원 : " + coinCount500 + "개");
		System.out.println("100원 : " + coinCount100 + "개");
		System.out.println("50원 : " + coinCount50 + "개");
		System.out.println("10원 : " + coinCount10 + "개");
		*/
		
/*		int[] coinArr = new int[4];
		for(int i = 0; i < 4; i++){
			coinArr[i] = money / coin[i];
			money -= coinArr[i] * coin[i];
			System.out.println(coin[i]+"원 : " + coinArr[i] + "개");
		}*/
		/*
		 * coin = {6, 4, 1}
		 * => 최소공배수 12, 주기는 12마다 반복됨
		 * input
		 * 0 -> 0
		 * 1 -> 1 * 1
		 * 2 -> 1 * 2
		 * 3 -> 1 * 3
		 * 4 -> 4 * 1
		 * 5 -> 4 * 1 + 1 * 1
		 * 6 -> 6 * 1
		 * 7 -> 6 * 1 + 1 * 1
		 * 8 -> 4 * 2
		 * 9 -> 4 * 2 + 1 * 1
		 * 10 -> 6 * 1 + 4 * 1
		 * 11 -> 6 * 1 + 4 * 1 + 1 * 1
		 * 12 -> 6 * 2
		 */
		
		Scanner sc = new Scanner(System.in);
		System.out.println("시작");
		money = Integer.parseInt(sc.nextLine());
		int one = 0;
		int four = 0;
		int six = 0;
		six = (money / 12) * 2;
		
		switch(money % 12){
		case 0:			
			break;
		case 1:
			one++;
			break;
		case 2:	
			one += 2;
			break;
		case 3:	
			one += 3;
			break;
		case 4:	
			four++;
			break;
		case 5:	
			one++;
			four++;
			break;
		case 6:	
			six++;
			break;
		case 7:	
			six++;
			one++;
			break;
		case 8:	
			four += 2;
			break;
		case 9:
			four += 2;
			one++;
			break;
		case 10:
			six++;
			four++;
			break;
		case 11:
			six++;
			four++;
			one++;
			break;
		}
		
		System.out.println("six : " + six + "four : " + four + "one : " + one);
		/*
		 * 1~5사이의 숫자가 발생된 만큼 *을 사용해 그래프를 그려주세요.
		 * 
		 * 1 : *** 3
		 * 2 : **** 4
		 * 3 : ** 2
		 * 4 : ***** 5
		 * 5 : ****** 6
		 */
		/*int[] arr = new int[20];
		int len = arr.length;
		for(int i = 0; i < len; i++){
			arr[i] = (int)(Math.random() * 5) + 1;
		}
		System.out.println(Arrays.toString(arr));
		int[] totCount = new int[5];
		
		for(int i = 0; i < len; i++){
			totCount[arr[i] - 1]++;
		}
		for(int i = 0; i < totCount.length; i++){
			System.out.print((i + 1) + " : ");
			for(int j = 0 ; j < totCount[i]; j++){
				System.out.print("*");
			}
			System.out.println("\t\t" + totCount[i]);
		}
		*/
		/*int[] arr = new int[10];
		for(int i = 0; i < arr.length; i++){
			arr[i] = (int)(Math.random() * 5) + 1;
		}
		System.out.println(Arrays.toString(arr));
		
		
		 * 1~5사이의 랜덤한 값이 10개 저장된 배열에서 중복된 값이 제거된 배열을 만들어주세요.
		 * [3, 5, 3, 2, 1, 3, 2, 1, 4, 1]
		 * [3, 5, 2, 1, 4]
		 
		int count = 0;
		int[] testArr = new int[10];
		for(int i = 0; i < arr.length; i++){
			boolean flag = true;
			for(int j = 0; j < i; j++){
				if(arr[i] == testArr[j]){
					flag = false;
					break;
					}
				}
			if(flag){
				testArr[count] = arr[i];
				count++;
			}
		}
		System.out.println(Arrays.toString(testArr));
		
		int[] noDuplicatedArr = new int[count];
		for(int i = 0; i < count; i++){
			noDuplicatedArr[i] = testArr[i];
		}
		System.out.println(Arrays.toString(noDuplicatedArr));
		
		System.out.println(114 % 12);*/
	}

}
