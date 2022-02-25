package Programmers;

import java.util.Arrays;
import java.util.Scanner;

public class heap {
	
	static int numOfData = 0;
	
	public static boolean IsParent(int[] arr, int idx){
		if(idx * 2 <= numOfData)	return true;
		else						return false;
	}
	
	public static void Insert(int[] arr, int value){
		numOfData++;
		int temp = numOfData;
		arr[temp] = value;
		while(true){
			while(true){
				if(value < arr[temp / 2])//작으면 올라가라
				{
					arr[temp] = arr[temp / 2];
					temp /= 2;
				}//끝까지 올라옴!
				else			break;
			}
			arr[temp] = value;
			break;
		}
	}//최소힙이므로 root가 가장 작길 원한다.
	
	public static int Delete(int[] arr){
		if(numOfData >= 1){
			if(numOfData == 1){
				int pop = arr[1];
				arr[1] = 0;
				numOfData--;
				return pop;
			}
			int pop = arr[1];
			int value = arr[numOfData];
			arr[numOfData] = 0;
			numOfData--;
			//자식이 있는지 아닌지 체크
			
			int temp = 1;

			while(true){
//					System.out.println(numOfData);
				if( !IsParent(arr, temp) )	break;
				int comp;
				if(temp * 2 == numOfData)						comp = temp * 2;
				else if(arr[temp * 2] < arr[temp * 2 + 1])		comp = temp * 2;
				else											comp = temp * 2 + 1;
				
				if(value > arr[comp]){
					arr[temp] = arr[comp];
					temp = comp;
				}else	break;
			}
			arr[temp] = value;
			return pop;
		}
		System.out.println("데이터없음, 오류!");
		return -65536;
	}
	
	public static void main(String[] args) {
		
		int[] rndArr = new int[20];
		int[] arr = new int[rndArr.length + 1];
		for(int i = 0; i < rndArr.length; i++){
			rndArr[i] = (int)(Math.random() * 100) + 1;
			Insert(arr, rndArr[i]);
		}
		System.out.println(Arrays.toString(rndArr) + "\n");
		for(int i = 0; i < rndArr.length; i++){
			rndArr[i] = Delete(arr);
		}
		System.out.println(Arrays.toString(rndArr));
	}

}
