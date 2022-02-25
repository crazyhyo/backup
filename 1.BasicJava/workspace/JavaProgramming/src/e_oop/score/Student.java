package e_oop.score;			//	e_oop패키지의 하위 패키지!

public class Student {
	int[] score = new int[3];
	int sum;
	double avg;
	String name;
	int rank;
	
	void init(String name){
		this.name = name;
		for(int i = 0; i < this.score.length; i++)	this.score[i] = (int)(Math.random() * 101);
		for(int i = 0; i < this.score.length; i++)	this.sum += this.score[i];
		this.avg = Math.round((double)this.sum / score.length * 100) / 100.0;
		this.rank = 1;
	}
//	Student init(String name){
//		Student temp =new Student();
//		temp.name = name;
//		for(int i = 0; i < temp.score.length; i++){
//			temp.score[i] = (int)(Math.random() * 101);
//		}
//		for(int i = 0; i < temp.score.length; i++){
//			temp.sum += temp.score[i];
//		}
//		temp.avg = Math.round((double)temp.sum / score.length * 100) / 100.0;
//		temp.rank = 1;
//		return temp;
//	}
	
	
	void print(){
		System.out.print(this.name + "\t");
		for(int i = 0; i < this.score.length; i++)		System.out.print(this.score[i] + "\t");
		System.out.println(this.sum + "\t" + this.avg + "\t" + this.rank);
	}
//	void print(Student std){
//		System.out.print(std.name + "\t");
//		for(int i = 0; i < std.score.length; i++)		System.out.print(std.score[i] + "\t");
//		System.out.println(std.sum + "\t" + std.avg + "\t" + std.rank);
//	}

}

//메서드 작성 기준
//명심해야 할 것 : 메서드는 클래스에 속한다.
//예를 들면 초기화는 그 클래스 내부에서 처리 가능(랜덤으로 점수 넣기, 합계, 평균 구하기)
//내 석차 구하기
//정렬은 학생이 할 이유가 없음. 함수에서 처리하는 것이 더 자연스러움