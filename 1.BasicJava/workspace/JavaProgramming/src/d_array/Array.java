package d_array;

import java.util.Arrays;
import java.util.Scanner;

public class Array {

	public static void main(String[] args) {
		/*
		 * 배열
		 * - 여러개의 값을 하나의 변수에 저장해서 사용하는 것이다.
		 * - 참조형 타입이다.
		 * - 인덱스로 값을 구분한다.
		 * - 길이를 변경 할 수 없다.
		 */
		/*
		int[] array;		//배열의 주소를 저장할 공간 생성
		
		array = new int[5];	//배열이 생성되고 그 주소가 저장된다.		<- int default 초기화 모두 0으로 저장
		//배열 초기화시 기본값이 저장된다.
		
		 * 변수 = 100번지(주소)
		 * 
		 * 100번지
		 * {0, 0, 0, 0, 0}
		 
		array = new int[]{1,2,3,4,5};
		
		int[] array2 = {1,2,3,4,5};	//변수의 선언과 초기화를 동시에 할 경우에만 사용가능
		
		System.out.println(array[0]);
		System.out.println(array[1]);
		System.out.println(array[2]);
		System.out.println(array[3]);
		System.out.println(array[4]);
		
		for(int i = 0; i < array.length; i++){
			array[i] = (i + 1) * 10;
		}
		*/
		//10개의 정수를 저장할 수 있는 배열을 선언 및 초기화 해주세요.
		
		int[] intArray = new int[10];
		//변수 생성시 변수 앞글자는 소문자
		//배열의 모든 인덱스에 1~100사이의 랜덤한 값을 저장해주세요.
		
		int sum = 0;
		double avg = 0.0;
		for(int i = 0; i < intArray.length; i++){
			intArray[i] = (int)(Math.random() * 100) + 1;
		}
		System.out.println(Arrays.toString(intArray));
		//System.out.println(Arrays.toString(intArray));
		//배열에 저장된 모든 값의합계와 평균을 출력해주세요.
		for(int i = 0; i < intArray.length; i++){
			sum += intArray[i];
		}
		avg = (double)sum / (double)intArray.length;
		System.out.println("합계: " + sum + " 평균: " + avg);
		//배열에 저장된 값들 중 최소값과 최대값을 출력해주세요.
		
		int index, i1, j1;
		for(i1 = 1; i1 < intArray.length; i1++){
			index = intArray[i1];
			for(j1 = i1 - 1; j1 >= 0; j1--){
				if(intArray[j1] > index)	intArray[j1+1] = intArray[j1];
				else break;						//제 자리를 찾았다면
			}
			intArray[j1+1] = index;
		}
		System.out.println(Arrays.toString(intArray));
		System.out.println("min: " + intArray[0] + " max: " + intArray[intArray.length-1]);
		int min, max;
		min = intArray[0];
		max = intArray[0];
		for(int i = 0; i < intArray.length; i++){
			if(intArray[i] < min)	min = intArray[i];
			if(intArray[i] > max)	max = intArray[i];
		}
		System.out.println("min: " + min + " max: " + max);
		
		int[] shuffle = new int[10];
		for(int i = 0; i < shuffle.length; i++){
			shuffle[i] = i + 1;
		}
		System.out.println(Arrays.toString(shuffle));
		//배열의 값을 섞어주세요.
		for(int i = 1; i < shuffle.length * 5; i++){
			int rand = (int)(Math.random() * 10);
			int temp = shuffle[0];
			shuffle[0] = shuffle[rand];
			shuffle[rand] = temp;
		}
		System.out.println(Arrays.toString(shuffle));
		
		//1~10 사이의 랜덤값을 500번 생성하고, 각 숫자가 생성된 횟수를 출력해주세요.
/*		int[] counNums = new int[10];
		int count = 500;
		for(int i = 0; i < count; i++){
			int rand = (int)(Math.random() * 10) + 1;
			switch(rand)
			{
			case 1: counNums[0]++; break;
			case 2: counNums[1]++; break;
			case 3: counNums[2]++; break;
			case 4: counNums[3]++; break;
			case 5: counNums[4]++; break;
			case 6: counNums[5]++; break;
			case 7: counNums[6]++; break;
			case 8: counNums[7]++; break;
			case 9: counNums[8]++; break;
			case 10: counNums[9]++; break;
			default: System.out.println("Error!"); break;
			}
		}
		for(int i = 0; i < 10; i++){
			System.out.println("숫자 " + (i+1) + "출력회수 : " + counNums[i]);
		}
		
		int[] record = new int[500];
		for(int i = 0; i < record.length; i++){
			record[i] = (int)(Math.random() * 10) + 1;
		}
		int[] counNums2 = new int[10];
		for(int i = 1; i <= 10; i++){
			for(int j = 0; j < record.length; j++){
				if(record[j] == i)		counNums2[i-1]++;
			}
		}
		for(int i = 0; i < 10; i++){
			System.out.println("숫자 " + (i+1) + "출력회수 : " + counNums2[i]);
		}*/
		int[] counNums3= new int[10];
		int count = 500;
		for(int i = 0; i < count; i++)
		{
			int rand = (int)(Math.random() * 10) + 1;
			counNums3[rand-1]++;
		}
		for(int i = 0; i < 10; i++){
			System.out.println("숫자 " + (i+1) + "출력회수 : " + counNums3[i]);
		}
		
		//위 문제의 최소값, 최대값, 반복횟수를 입력받아 각 숫자가 생성된 횟수를 출력해주세요.
		Scanner sc = new Scanner(System.in);
		System.out.print("무작위로 생성될 숫자의 최소값을 입력해주세요: ");
		int minNum = Integer.parseInt(sc.nextLine());
		System.out.print("무작위로 생성될 숫자의 최대값을 입력해주세요: ");
		int maxNum = Integer.parseInt(sc.nextLine());
		System.out.print("무작위로 생성될 숫자의 총 개수를 입력해주세요: ");
		int countNum = Integer.parseInt(sc.nextLine());
		
		int[] newArray = new int[countNum];
		int[] compute = new int[maxNum - minNum + 1];
		for(int i = 0; i < countNum; i++){
			int rand = (int)(Math.random() * (maxNum - minNum + 1)) + minNum;
			newArray[i] = rand;
			compute[rand-minNum]++;
		}
		System.out.println(Arrays.toString(newArray));
		
		for(int i = minNum; i <= maxNum; i++){
			System.out.println("숫자 " + i + "출력회수 : " + compute[i-minNum]);
		}
		
	}

}
