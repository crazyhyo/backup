package Programmers;

import java.util.Scanner;
import java.util.Arrays;

public class quickSort{
	
	static int count = 0;
	
	public static void Swap(int[] arr, int idx1, int idx2){
		int temp = arr[idx1];
		arr[idx1] = arr[idx2];
		arr[idx2] = temp;
		count++;
//		System.out.println(Arrays.toString(arr));
	}
	
	public static int Partition(int[] arr, int left, int right){
		int pivot = arr[left];
		int low = left + 1;
		int high = right;
		
		while(true){
			while(arr[low] <= pivot && low < right)				low++;
			while(arr[high] >= pivot && high > left)			high--;
			if(low < high)										Swap(arr, low, high);			
			else												break;
		}
		
		if(left != high)										Swap(arr, left, high);
		
		return high;
	}
	
/*	public static int Partition(int[] arr, int left, int right){
		int pivot = arr[right];
		int low = left;
		int high = right - 1;
		
		while(true){

			while(arr[low] <= pivot && low < right){
				low++;
			}
			while(arr[high] >= pivot && high > left){
				high--;
			}
			if(low < high){
				Swap(arr, low, high);
//				System.out.println(Arrays.toString(arr));			
			}else{
				break;
			}
		}
		if(right != low)		Swap(arr, right, low);
//		System.out.println(Arrays.toString(arr));
		return low;
	}*/
	
	public static void QuickSort(int[] arr, int left, int right){
		
		if( left < right){
			int pivot = Partition(arr, left, right);
			QuickSort(arr, left, pivot - 1);
			QuickSort(arr, pivot + 1, right);
		}
	}
	
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		System.out.print("배열의 크기를 입력하세요: ");
		int len = Integer.parseInt(sc.nextLine());
		int[] arr = new int[len];

		/*
		int cnt = 0;
		int decision = 0;
		int rand;
			while(cnt != len){
			decision = 0;
			rand = (int)(Math.random() * 100) + 1;
			for(int i = 0; i < cnt; i++){
				if(arr[i] == rand){
					decision++;
				}
			}
			if(decision == 0){
				arr[cnt] = rand;
				cnt++;
			}
			
		}*/

        for(int i = 0; i < len ; i++){
            arr[i] = (int)(Math.random() * 100) + 1;
        }
/*		 for(int i = 0; i < len ; i++){
	            arr[i] = i;
	        }*/
		
/*		int len = 8;
		int[] arr = new int[len];
		arr[0] = 1;
		arr[1] = 3;
		arr[2] = 8;
		arr[3] = 4;
		arr[4] = 2;
		arr[5] = 7;
		arr[6] = 6;
		arr[7] = 5;*/
		System.out.println(Arrays.toString(arr));
		
		System.out.println();
		
		QuickSort(arr, 0, len - 1);
		
		System.out.println(Arrays.toString(arr));
		
		System.out.println(count);
		

	}

}

