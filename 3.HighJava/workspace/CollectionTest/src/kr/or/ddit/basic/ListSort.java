package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ListSort {
	public static void main(String[] args) {
		List<Student> stdList = new ArrayList<Student>();
		
		String[] studentNames = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
				"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
				"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};
		
		String[] studentNumbers = {"007","001","011","006","002","019","025","024","017","009","016","015","021"
				,"010","020","003","008","012","013","004","023","022","014","018","005"};
		
		int kor = 0;
		int eng = 0;
		int math = 0;
		
		for(int i = 0; i < studentNames.length; i++) {
			kor = (int)(Math.random() * 101);
			eng = (int)(Math.random() * 101);
			math = (int)(Math.random() * 101);

			stdList.add(new Student(studentNumbers[i], studentNames[i], kor, eng, math));
			
		}
		
		for(int i = 0 ; i < studentNames.length; i++) {
			for(int j = 0; j < studentNames.length; j++) {
				if(stdList.get(i).getSum() < stdList.get(j).getSum()) {
					stdList.get(i).setRank(stdList.get(i).getRank() + 1);
				}
			}
		}
		
		System.out.println("정렬 전 : \n");
		
		for(Student std : stdList) {
			System.out.println(std);
		}
		
		System.out.println("\n학번 오름차순 출력 : \n");
		Collections.sort(stdList);
		for(Student std : stdList) {
			System.out.println(std);			
		}
		
		System.out.println("\n총점정렬 후 : \n");
		Collections.sort(stdList, new descSum());
		for(Student std : stdList) {
			System.out.println(std);
		}
		
	}
}

class Student implements Comparable<Student>{
	
	String stuNo;
	String name;
	int kor;
	int eng;
	int math;
	int sum;
	int rank;
	
	public Student(String stuNo, String name, int kor, int eng, int math) {
		super();
		this.stuNo = stuNo;
		this.name = name;
		this.kor = kor;
		this.eng = eng;
		this.math = math;
		this.sum = kor + eng + math;
		this.rank = 1;
	}

	public String getStuNo() {					return stuNo;	}

	public void setStuNo(String stuNo) {		this.stuNo = stuNo;	}

	public String getName() {					return name;	}

	public void setName(String name) {			this.name = name;	}

	public int getKor() {						return kor;	}

	public void setKor(int kor) {				this.kor = kor;	}

	public int getEng() {						return eng;	}

	public void setEng(int eng) {				this.eng = eng;	}

	public int getMath() {						return math;	}

	public void setMath(int math) {				this.math = math;	}

	public int getSum() {						return sum;	}

	public void setSum(int sum) {				this.sum = sum;	}

	public int getRank() {						return rank;	}

	public void setRank(int rank) {				this.rank = rank;	}

	@Override
	public int compareTo(Student std) {
		return getStuNo().compareTo(std.getStuNo()); 
	}

	@Override
	public String toString() {
		return "Student [stuNo=" + stuNo + ", name=" + name + ", kor=" + kor + ", eng=" + eng + ", math=" + math
				+ ", sum=" + sum + ", rank=" + rank + "]";
	}
	
}

class descSum implements Comparator<Student>{
	@Override
	public int compare(Student std1, Student std2) {
		/*return ((Integer)std1.getSum()).compareTo(std2.getSum()) != 0 ?
			  -((Integer)std1.getSum()).compareTo(std2.getSum()) :
			  -std1.getStuNo().compareTo(std2.getStuNo());*/
		return Integer.compare(std1.getSum(), std2.getSum()) != 0 ?
			  -Integer.compare(std1.getSum(), std2.getSum()) :
			  -std1.getStuNo().compareTo(std2.getStuNo());
	}
	
}