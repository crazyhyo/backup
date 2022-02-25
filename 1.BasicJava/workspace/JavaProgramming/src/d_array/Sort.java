package d_array;

import java.util.Arrays;

public class Sort {
	public static void main(String[] args) {
		/*
		 * - 석차구하기 : 점수를 비교해 작은 점수의 등수를 증가시키는 방식
		 * - 선택정렬 : 가장 작은 숫자를 찾아서 앞으로 보내는 방식
		 * - 버블정렬 : 바로 뒤의 숫자와 비교해서 큰 수를 뒤로 보내는 방식
		 * - 삽입정렬 : 두번째 숫자부터 앞의 숫자들과 비교해서 큰 수는 뒤로 밀고 중간에 삽입하는 방식
		 */
		int[] arr = new int[8];
		int len = arr.length;
		
		for(int i = 0; i < len; i++){
			arr[i] = (int)(Math.random() * 100) + 1;
		}
		
		System.out.println(Arrays.toString(arr));
		
/*		int[] rank = new int[len];
		for(int i = 0; i < len; i++)	rank[i] = 1;
		
		for(int i = 0; i < len; i++){
			for(int j = 0; j < len; j++){
				if(arr[i] < arr[j]){
					rank[i]++;
				}
			}
		}
		
		System.out.println(Arrays.toString(rank));
*/		
/*		for(int i = 0; i< len - 1; i++){
			for(int j = i + 1; j < len; j++){
				if(arr[i] > arr[j]){
					int temp = arr[i];
					arr[i] = arr[j];
					arr[j] = temp;
				}
			}
		}
		
		System.out.println(Arrays.toString(arr));*/
		
/*		for(int i = 0; i < len - 1; i++){
			int min = arr[i];
			int index = i;
			for(int j = i + 1; j < len; j++){
				if(arr[j] < min){
					min = arr[j];
					index = j;
				}
			}
			arr[index] = arr[i];
			arr[i] = min;
		}
		System.out.println(Arrays.toString(arr));*/			//셀렉션 소트
		
/*		for(int i = 0; i < len - 1; i++){
			for(int j = i + 1; j < len; j++){
				if(arr[j - 1] > arr[j]){
					int temp = arr[j - 1];
					arr[j - 1] = arr[j];
					arr[j] = temp;
				}
			}
		}*/
/*		for(int i = 0; i < len - 1; i++){
			for(int j = i; j >= 0; j--){
				if(arr[j + 1] < arr[j]){
					int temp = arr[j];
					arr[j] = arr[j + 1];
					arr[j + 1] = temp;
				}
			}
		}*/							//버블소트
/*		for(int i = len; i > 0; i--){
			boolean flag = true;
			for(int j = 0; j < i - 1; j++){
				if(arr[j] > arr[j + 1]){
					int temp = arr[j];
					arr[j] = arr[j + 1];
					arr[j + 1] = temp;
					flag = false;
				}
			}
			if(flag)	break;
		}
		System.out.println(Arrays.toString(arr));*/
//		System.out.println(Arrays.toString(arr));
		{
			int i = 0;
			int j = 0;
			int walk = 0;
			
			for(i = 1; i < len; i++){
				walk = arr[i];
				for(j = i - 1; j >= 0; j--){
					if(arr[j] > walk){
						arr[j + 1] = arr[j];
					}
					else		break;
				}
				arr[j + 1] = walk;
			}
			System.out.println(Arrays.toString(arr));
		}				//	인섹트 소트
		
		/*
		 * for(int i = 1; i < len; i++){
		 * 		int temp = arr[i];
		 * 		int j = 0;
		 * 		for(j = i - 1; j >= 0; j--){
		 * 			if(temp < arr[j]){
		 * 				arr[j + 1] = arr[j];
		 * 			}else{
		 * 				break;
		 * 			}
		 * 		}
		 * 		arr[j + 1] = temp;
		 * }
		 */
		
		
		//선택정렬
		/*
		 * 0,1	0,2	0,3	0,4	0,5	0,6	0,7	0,8	0,9
		 * 1,2	1,3	1,4	1,5	1,6	1,7	1,8	1,9
		 * 2,3	2,4	2,5	2,6	2,7	2,8	2,9
		 * 3,4	3,5	3,6	3,7	3,8	3,9
		 * 4,5	4,6	4,7	4,8	4,9
		 * 5,6	5,7	5,8	5,9
		 * 6,7	6,8	6,9
		 * 7,8	7,9
		 * 8,9		
		 */
		System.out.println();
	
	}
	
	

}
