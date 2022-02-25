package e_oop.score2;

import e_oop.score2.Student;

public class Score {

	public static void main(String[] args) {
		String[] studentNames = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
				"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
				"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};
		
		Student[] students = new Student[studentNames.length];
		
		String[] subjects = {"국어", "영어", "수학"};
		
		for(int i = 0; i < students.length; i++){
			students[i] = new Student();
			students[i].name = studentNames[i];
			students[i].createRandomScore();
			students[i].getSum();
			students[i].getAvg();
		}
		
		for(int i = 0; i < students.length; i++){
			students[i].getRank(students);
		}
		
		{
			int j = 0;
			for(int i = 1; i < students.length; i++){
				int insert = students[i].sum;
				Student temp = students[i];
				for(j = i - 1; j >= 0; j--){
					if(students[j].sum < insert){
						students[j + 1] = students[j];
					}else			break;
				}
				students[j + 1] = temp;
			}
		}
		System.out.println("이름\t국어\t영어\t수학\t합계\t평균\t석차");
		for(int i = 0; i < studentNames.length; i++){
			System.out.println(students[i].getInfo());
		}
	
		int korSum = 0;
		int engSum = 0;
		int mathSum = 0;
		double korAvg;
		double engAvg;
		double mathAvg;
		
		for (int i = 0; i < students.length; i++) {
			korSum += students[i].kor;
			engSum += students[i].eng;
			mathSum += students[i].math;
		}
		korAvg = Math.round((double) korSum / students.length * 100) / 100.0;
		engAvg = Math.round((double) engSum / students.length * 100) / 100.0;
		mathAvg = Math.round((double) mathSum / students.length * 100) / 100.0;
		
		System.out.print("과목합계\t");
		System.out.print(korSum+"\t");
		System.out.print(engSum+"\t");
		System.out.print(mathSum+"\t");
		System.out.println();
		System.out.print("과목평균\t");
		System.out.print(korAvg+"\t");
		System.out.print(engAvg+"\t");
		System.out.print(mathAvg+"\t");

	}

}
