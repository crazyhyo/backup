package e_oop.score;

public class ScoreWithMethod {

	public static void main(String[] args) {
		String[] studentNames = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
				"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
				"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};
		String[] subjects = {"국어", "영어", "수학"};
		
		Student[] students = new Student[studentNames.length];
		
//		for (int i = 0; i < studentNames.length; i++) {
//			Student temp = new Student();
////			students[i] = temp.init(studentNames[i]);
//			temp.init(studentNames[i]);
//			students[i] = temp;
//		}

		for(int i = 0; i < studentNames.length; i++){
			students[i] = new Student();
			students[i].init(studentNames[i]);
		}
		
//		int[] subSum = new int[subjects.length];
//		double[] subAvg = new double[subjects.length];
//		
//		for(int i = 0; i < subjects.length; i++){
//			for(int j = 0; j < students.length; j++){
//				subSum[i] += students[j].score[i];
//			}
//			subAvg[i] = Math.round((double)subSum[i] / students.length * 100) / 100.0;
//		}
		
		Subject subj = new Subject();
		subj.init(subjects, students);
		for(int i = 0; i < students.length; i++){
			for(int j = 0; j < students.length; j++){
				if(students[i].sum < students[j].sum)	students[i].rank++;
			}
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
		subj.printName();
//		System.out.print("이름\t");
//		for(int i = 0; i < subjects.length; i++)			System.out.print(subjects[i]+"\t");
//		System.out.println("합계\t평균\t석차");
		for(int i = 0; i < students.length; i++)			students[i].print();
//		for(int i = 0; i < students.length; i++)			students[i].print(students[i]);
		
//		System.out.print("과목합계\t");
//		for(int i = 0; i < subjects.length; i++)			System.out.print(subSum[i]+"\t");
//		System.out.println();
//		System.out.print("과목평균\t");
//		for(int i = 0; i < subjects.length; i++)			System.out.print(subAvg[i]+"\t");
		subj.printSubj();
	}

}
