package e_oop.score;

public class Score {

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
		String[] studentNames = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
								"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
								"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};
		
		Student[] students = new Student[studentNames.length];		//참조형 타입의 기본값인 null이 들어간다., 25개의 null생성 
		for(int i = 0; i < studentNames.length; i++){
			Student student = new Student();			//int, double타입은 모두 0으로, String 타입인 name 만 null로 초기화 된 Student 클래스 인스턴스 생성
			
			student.name = studentNames[i];
			student.rank = 1;
			student.score[0] = (int)(Math.random() * 101);
			student.score[1] = (int)(Math.random() * 101);
			student.score[2] = (int)(Math.random() * 101);
			student.sum = student.score[0] + student.score[1] + student.score[2];
			student.avg = Math.round(student.sum / 3.0 * 100) / 100.0;
			
			students[i] = student;
		}
		
		int korSum = 0;
		int engSum = 0;
		int mathSum = 0;
		double korAvg = 0;
		double engAvg = 0;
		double mathAvg = 0;
		
		for(int i = 0; i < studentNames.length; i++)		korSum += students[i].score[0];
		korAvg = Math.round(korSum / 3.0 * 100) / 100.0;
		for(int i = 0; i < studentNames.length; i++)		engSum += students[i].score[1];
		engAvg = Math.round(engSum / 3.0 * 100) / 100.0;
		for(int i = 0; i < studentNames.length; i++)		mathSum += students[i].score[2];
		mathAvg = Math.round(mathSum / 3.0 * 100) / 100.0;
		
		for(int i = 0; i < studentNames.length; i++){
			for(int j = 0; j < studentNames.length; j++){
				if(students[i].sum < students[j].sum)		students[i].rank++;
			}
		}
		
//		{
//			int j = 0;
//			for(int i = 1; i < studentNames.length; i++){
//				Student insert = new Student();
//				insert = students[i];
//				for(j = i - 1; j >= 0; j--){
//					if(insert.sum > students[j].sum){
//						students[j + 1] = students[j]; 
//					}else			break;
//				}
//				students[j + 1] = insert;
//			}
//		}

		{
			int j = 0;
			for(int i = 1; i < studentNames.length; i++){
				Student insert = new Student();
				insert = students[i];
				for(j = i - 1; j >= 0; j--){
					if(insert.rank < students[j].rank){
						students[j + 1] = students[j]; 
					}else			break;
				}
				students[j + 1] = insert;
			}
		}

		System.out.println("이름\t국어\t영어\t수학\t합계\t평균\t석차");
		for(int i = 0; i < studentNames.length; i++){
			System.out.println(students[i].name + "\t" + students[i].score[0] + "\t"
								+ students[i].score[1] + "\t" + students[i].score[2] + "\t"
								+ students[i].sum + "\t" + students[i].avg + "\t"
								+ students[i].rank);
		}
		System.out.println("과목합계\t" + korSum + "\t" + engSum + "\t" + mathSum);
		System.out.println("과목합계\t" + korAvg + "\t" + engAvg + "\t" + mathAvg);

	}

}
