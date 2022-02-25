package e_oop.score;

public class Subject {
	String[] name = new String[3];
	int[] subSum = new int[3];
	double[] subAvg = new double[3];
	
	void init(String[] subName, Student[] std){
		for(int i = 0; i < this.name.length; i++){
			this.name[i] = subName[i];
			for(int j = 0; j < std.length; j++){
				this.subSum[i] += std[j].score[i];
			}
			this.subAvg[i] = Math.round((double)this.subSum[i] / std.length * 100) / 100.0;
		}
	}
	void printName() {
		System.out.print("이름\t");
		for (int i = 0; i < this.name.length; i++)
			System.out.print(this.name[i] + "\t");
		System.out.println("합계\t평균\t석차");
	}
	void printSubj(){
		System.out.print("과목합계\t");
		for(int i = 0; i < this.name.length; i++)			System.out.print(this.subSum[i]+"\t");
		System.out.println();
		System.out.print("과목평균\t");
		for(int i = 0; i < this.name.length; i++)			System.out.print(this.subAvg[i]+"\t");
	}
}
