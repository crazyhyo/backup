package Programmers;

public class Search {
	
//	public static int Fibo(int idx){
//		if(idx == 1 || idx == 2)		return 1;
//		else		return Fibo(idx - 1) + Fibo(idx - 2);
//	}
	
	public static int Bsearch(int[] arr, int first, int last, int target){
		
		if(first != last){
			int mid = (first + last) / 2;
			
			if(arr[mid] == target)		return mid;
			else if(arr[mid] > target)	return Bsearch(arr, first, mid - 1, target);
			else						return Bsearch(arr, mid + 1, last, target);
		}else if(arr[first] == target){
			return first;
		}
		System.out.println("탐색실패!");
		return -1;
	}
	
	public static void main(String[] args) {
		
		 int[] arr = {1,8,9,15,46,80,90,134,256,331,400};
		 
		 System.out.println(Bsearch(arr, 0, arr.length, 331));
		
//		for(int i = 1; i < 15; i++){
//			System.out.print(Fibo(i) + "  ");
//		}
		

	}

}
