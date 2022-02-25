package d_array;

import java.util.Arrays;

public class MultiDimensionalArray {

	public static void main(String[] args) {
		/*
		 * 다차원 배열
		 * - 배열안에 배열이 저장되어 있는 형태이다.
		 */
		
		//2차원배열
		
//		int[][] array2;
//		
//		//3차원배열
//		int[][][] array3;
//		
//		int[][] arr = new int[2][3];		//3개의 값을 저장할 수 있는 배열이 2개 존재
//		/*
//		 * 변수 = 100번지(주소)
//		 * 
//		 * 100번지	{200번지, 300번지}
//		 * 200번지	{0, 0, 0}
//		 * 300번지	{0, 0, 0}
//		 */
//		
//		int arr2[][] = new int[][]{{1,2,3},{4,5,6}};	//	이 경우에는 길이를 지정하면 안됨, 컴파일에러
//		int[] arr3[] = {	{1,2,3},
//							{4,5,6},
//							{7,8,9}	};					// 선언과 초기화를 동시에 하지 않으면 에러
//		
//		int[][] arr4 = new int[3][];	//가변배열, 배열을 3개 선언
//		arr4[0] = new int[3];
//		arr4[1] = new int[5];
//		arr4[2] = new int[10];
//		//								와, C에서는 이짓 하려고 malloc, calloc같은거 쓰고다니는데
//		
//		System.out.println(arr[0]);
//		
////		arr[0] = 10; //값을 저장할 수 없다.
//		arr[0] = new int[5];	//배열을 저장해야한다.
//		arr[0][0] = 10;
//		arr[0][1] = 20;
//		arr[1][0] = 100;
//		
//		System.out.println(arr.length); 	//1차원 배열의 길이
//		System.out.println(arr[0].length);	//2차원 배열의 길이
//		System.out.println(arr[1].length);	//2차원 배열의 길이
//		
//		for(int i = 0; i < arr.length; i++){
//			for(int j = 0; j < arr[i].length; j++){
//				System.out.print(arr[i][j] + ", ");
//			}
//			System.out.println();
//		}
		
		int[][] scores = new int[3][5];				//int[학생수][과목수]
		int[] sum  = new int[scores.length];		//합계
		double[] avg  = new double[scores.length];	//평균
		
		for(int i = 0; i < scores.length; i++){
			for(int j = 0; j < scores[i].length; j++){
				scores[i][j] = (int)(Math.random() * 101);
			}
			System.out.println(Arrays.toString(scores[i]));
		}
		for(int i = 0; i < scores.length; i++){
			for(int j = 0; j < scores[i].length; j++){
				sum[i] += scores[i][j];
			}
			avg[i] = (double) sum[i] / scores[i].length;
		}
		System.out.println(Arrays.toString(sum));
		System.out.println(Arrays.toString(avg));
	}

}
