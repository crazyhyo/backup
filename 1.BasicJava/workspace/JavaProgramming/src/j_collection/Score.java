package j_collection;

import java.util.ArrayList;

public class Score {

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
		subjectNames.add("사회");
		subjectNames.add("과학");
		subjectNames.add("Java");
		subjectNames.add("Oracle");
		
		ArrayList<Student> students = new ArrayList<Student>();
		ArrayList<Subject> subjects = new ArrayList<Subject>();
		for(int i = 0; i < studentNames.size(); i++){
			students.add(new Student(studentNames.get(i),subjectNames.size()));
		}
		for(int i = 0; i < subjectNames.size(); i++){
			subjects.add(new Subject(subjectNames.get(i), students, i));
		}
		
		for(int i = 0; i < students.size(); i++){
			for(int j = 0; j < students.size(); j++){
				if(students.get(i).sum < students.get(j).sum)		students.get(i).rank++;
			}
		}
		
		for(int i = 1; i < students.size(); i++){
			int j = 0;
			Student temp = students.get(i);
			for(j = i - 1; j >= 0; j--){
				if(temp.sum > students.get(j).sum){
					students.set(j + 1, students.get(j));
				}else
					break;
			}
			students.set(j + 1, temp);
		}
		
		System.out.print("이름");
		for(int i = 0; i < subjectNames.size(); i++){
			System.out.print("\t" + subjects.get(i).name);
		}
		System.out.println("\t합계\t평균\t석차");
		
		for(int i = 0; i < students.size(); i++){
			System.out.print(students.get(i).name);
			for(int j = 0; j < subjects.size(); j++){
				System.out.print("\t" + students.get(i).score.get(j));
			}
			System.out.print("\t" + students.get(i).sum);
			System.out.print("\t" + String.format("%.2f", students.get(i).avg));
			System.out.print("\t" + students.get(i).rank + "\n");
		}
		
		System.out.print("과목합계");
		for(int i = 0; i < subjects.size(); i++){
			System.out.print("\t" + subjects.get(i).subSum);
		}
		System.out.print("\n과목평균");
		for(int i = 0; i < subjects.size(); i++){
			System.out.print("\t" + String.format("%.2f",subjects.get(i).subAvg));
		}
	}
}
		
		




