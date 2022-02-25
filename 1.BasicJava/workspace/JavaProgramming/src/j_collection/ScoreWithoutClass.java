package j_collection;

import java.util.ArrayList;

public class ScoreWithoutClass {
	
	

	public static void main(String[] args) {
		
		ArrayList<String> studentNames = new ArrayList<String>();
		ArrayList<String> subjectNames = new ArrayList<String>();
		
		studentNames.add("이단비");
		studentNames.add("김노을");
		studentNames.add("정현욱");
		studentNames.add("박소현");
		studentNames.add("김수진");
		studentNames.add("이희현");
		studentNames.add("강건");
		studentNames.add("이민영");
		studentNames.add("하기재");
		studentNames.add("이윤우");
		studentNames.add("김미희");
		studentNames.add("김혜윤");
		studentNames.add("신승철");
		studentNames.add("이광효");
		studentNames.add("김진혁");
		studentNames.add("마창수");
		studentNames.add("양기욱");
		studentNames.add("석기현");
		studentNames.add("류인성");
		studentNames.add("이미정");
		studentNames.add("이단비");
		studentNames.add("임나리");
		studentNames.add("송민섭");
		studentNames.add("김지윤");
		studentNames.add("조명석");
		
		subjectNames.add("국어");
		subjectNames.add("영어");
		subjectNames.add("수학");
		
//		ArrayList<Student> students = new ArrayList<Student>();
//		ArrayList<Subject> subjects = new ArrayList<Subject>();
		
		ArrayList<Integer> korScore = new ArrayList<Integer>();
		ArrayList<Integer> engScore = new ArrayList<Integer>();
		ArrayList<Integer> mathScore = new ArrayList<Integer>();
		
		ArrayList<Integer> sum = new ArrayList<Integer>();
		ArrayList<Double> avg = new ArrayList<Double>();
		ArrayList<Integer> rank = new ArrayList<Integer>();
		
		ArrayList<Integer> subSum = new ArrayList<Integer>();
		ArrayList<Double> subAvg = new ArrayList<Double>();
		
		
		
		
		for(int i = 0; i < studentNames.size(); i++){
			korScore.add((int)(Math.random() * 101));
			engScore.add((int)(Math.random() * 101));
			mathScore.add((int)(Math.random() * 101));
			sum.add(korScore.get(i) + engScore.get(i) + mathScore.get(i));
			avg.add(sum.get(i) / (double)subjectNames.size());
			rank.add(1);
		}
		
		int korSum = 0;
		int engSum = 0;
		int mathSum = 0;
		for(int i = 0; i < studentNames.size(); i++){
			korSum += korScore.get(i);
			engSum += engScore.get(i);
			mathSum += mathScore.get(i);
		}
		subSum.add(korSum);
		subSum.add(engSum);
		subSum.add(mathSum);
		
		for(int i = 0; i < subjectNames.size(); i++){
			subAvg.add(subSum.get(i) / (double)studentNames.size());			
		}
		
		for(int i = 0; i < studentNames.size(); i++){
			for(int j = 0; j < studentNames.size(); j++){
				if(sum.get(i) < sum.get(j)){
					rank.set(i, rank.get(i) + 1);
				}
			}
		}
		
		for(int i = 0; i < studentNames.size(); i++){
			int j = 0;
			int tempKor = korScore.get(i);
			int tempEng = engScore.get(i);
			int tempMath = mathScore.get(i);
			int tempRank = rank.get(i);
			int tempSum = sum.get(i);
			double tempAvg = avg.get(i);
			
			for(j = i - 1; j >= 0; j--){
				if(tempSum > sum.get(j)){
					sum.set(j + 1, sum.get(j));
					avg.set(j + 1, avg.get(j));
					rank.set(j + 1, rank.get(j));
					korScore.set(j + 1, korScore.get(j));
					engScore.set(j + 1, engScore.get(j));
					mathScore.set(j + 1, mathScore.get(j));
				}else
					break;
			}
			sum.set(j + 1, tempSum);
			avg.set(j + 1, tempAvg);
			rank.set(j + 1, tempRank);
			korScore.set(j + 1, tempKor);
			engScore.set(j + 1, tempEng);
			mathScore.set(j + 1, tempMath);
		}
		
		System.out.print("이름");
		for(int i = 0; i < subjectNames.size(); i++){
			System.out.print("\t" + subjectNames.get(i));
		}
		System.out.println("\t합계\t평균\t석차");
		
		for(int i = 0; i < studentNames.size(); i++){
			System.out.print(studentNames.get(i));
			System.out.print("\t" + korScore.get(i));
			System.out.print("\t" + engScore.get(i));
			System.out.print("\t" + mathScore.get(i));
			System.out.print("\t" + sum.get(i));
			System.out.print("\t" + String.format("%.2f", avg.get(i)));
			System.out.print("\t" + rank.get(i) + "\n");
		}
		
		System.out.print("과목합계");
		for(int i = 0; i < subjectNames.size(); i++){
			System.out.print("\t" + subSum.get(i));
		}
		System.out.print("\n과목평균");
		for(int i = 0; i < subjectNames.size(); i++){
			System.out.print("\t" + String.format("%.2f", subAvg.get(i)));
		}
	}

}
