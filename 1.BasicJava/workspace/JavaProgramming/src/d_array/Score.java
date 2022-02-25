package d_array;

import java.util.Arrays;

public class Score {

//	public static void Swap(int[] sumArr, int idx1, int idx2)
//	{
//		int sumTemp = sumArr[idx1];
//		int rankTemp = rankArr[idx1];
//		double avgTemp = avgArr[idx1];
//		String stuTemp = studentMembers[idx1];
//		
//		sumArr[idx1] = sumArr[idx2];
//		rankArr[idx1] = rankArr[idx2];
//		avgArr[idx1] = avgArr[idx2];
//		studentMembers[idx1] = studentMembers[idx2];
//		
//		sumArr[idx1] = sumTemp;
//		rankArr[idx1] = rankTemp;
//		avgArr[idx1] = avgTemp;
//		studentMembers[idx1] = stuTemp;
//	}
//	
//	public static int partition(int[] sumArr, int left, int right)
//	{
////		if(left == right)				return left;
//		
//		int temp = sumArr[left];
//		int high = right;
//		int low = left + 1;
//		while(true){
//			while(temp >= sumArr[low] && low < right)			low++;
//			while(temp <= sumArr[high] && high > left)			high--;
//			if(low < high){
//				Swap(sumArr, low, high);
//			}else{
//				break;
//			}
//		}
//		if(left != high)		Swap(sumArr, left, high);
//		return high;	
//	}
//	
//	public static void quickSort(int[] sumArr, int first, int last){
//		if(first < last){
//			int pivot = partition(sumArr, first, last);
//			quickSort(sumArr, first, pivot - 1);
//			quickSort(sumArr, pivot + 1, last);
//		}
//	}
	
	public static void main(String[] args) {
		/*
		 * 403호 모두의 국어, 영어, 수학, 사회, 과학, Oracle, Java 점수를
		 * 0~100까지 랜덤으로 생성해 주시고, 아래와 같이 출력해주세요.
		 * 
		 * 이름		국어		영어		수학		사회		과학		Oracle	Java	합계		평균		석차
		 * 홍길동		90		90		90		90		90		90		90		630		90.00	1
		 * 
		 * 
		 * 과목합계	450		450		450		450		450		450		450
		 * 과목평균	90.00	90.00	90.00	90.00	90.00	90.00	90.00
		 */
		
		String[] studentMembers = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
				"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
				"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};
		
		String[] subjects = {"국어", "영어", "수학", "사회", "과학", "Oracle", "Java"};
		
		int[][] scoreArr = new int[studentMembers.length][subjects.length];
		int[] sumArr = new int[studentMembers.length];
		double[] avgArr = new double[studentMembers.length];
		int[] rankArr = new int[studentMembers.length];
		
		
		for(int i = 0; i < studentMembers.length; i++){
			for(int j = 0; j < subjects.length; j++){
				scoreArr[i][j] = (int)(Math.random() * 101);
//				scoreArr[i][j] = 100;
			}
		}
		
		for(int i = 0; i < studentMembers.length; i++){
			rankArr[i] = 1;
			for(int j = 0; j < subjects.length; j++){
				sumArr[i] += scoreArr[i][j];
			}
			avgArr[i] = (double) sumArr[i] / subjects.length;
		}

		for(int i = 0; i < sumArr.length; i++){
			int target = sumArr[i];
			for(int j = 0; j < sumArr.length; j++){
				if(target < sumArr[j]){
					rankArr[i]++;
				}
			}
		}
		
//		System.out.println(Arrays.toString(sumArr));
//		System.out.println(Arrays.toString(rankArr));
		
		{
			int j = 0;
			for(int i = 1; i < sumArr.length; i++){
				int sumInsert = sumArr[i];
				int rankInsert = rankArr[i];
				double avgInsert = avgArr[i];
				String stuInsert = studentMembers[i];
				for(j = i - 1; j >= 0; j--){
					if(sumInsert > sumArr[j]){
						sumArr[j + 1] = sumArr[j];
						rankArr[j + 1] = rankArr[j];
						avgArr[j + 1] = avgArr[j];
						studentMembers[j + 1] = studentMembers[j];
					}else					break;
				}
				sumArr[j + 1] = sumInsert;
				rankArr[j + 1] = rankInsert;
				avgArr[j + 1] = avgInsert;
				studentMembers[j + 1] = stuInsert;
			}
		}
		
//		quickSort(sumArr, 0, subjects.length -1);
//		System.out.println(Arrays.toString(sumArr));
		
		System.out.print("이름\t");
		for(int i = 0; i < subjects.length; i++){
			System.out.print(subjects[i] + "\t");
		}
		System.out.println("합계\t평균\t석차\t");
		for(int i = 0; i < studentMembers.length; i++){
			System.out.print(studentMembers[i] + "\t");
			for(int j = 0; j < subjects.length; j++){
				System.out.print(scoreArr[i][j] + "\t");
			}
			System.out.println(sumArr[i] + "\t" + Math.round(avgArr[i] * 100) / 100.0 + "\t" +rankArr[i]);
		}
		
		System.out.print("과목합계\t");
		for(int i = 0; i < subjects.length; i++){
			int subjSum = 0;
			for(int j = 0; j < studentMembers.length; j++){
				subjSum +=  scoreArr[j][i];
			}
			System.out.print(subjSum + "\t");
		}
		System.out.println();
		System.out.print("과목평균\t");
		for(int i = 0; i < subjects.length; i++){
			int subjSum = 0;
			double subjAvg = 0;
			for(int j = 0; j < studentMembers.length; j++){
				subjSum +=  scoreArr[j][i];
			}
			subjAvg = (double) subjSum / studentMembers.length;
			System.out.print(Math.round(subjAvg * 100) / 100.0 + "\t");
		}
		

	}

}
