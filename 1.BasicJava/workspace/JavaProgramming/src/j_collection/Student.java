package j_collection;

import java.util.ArrayList;

public class Student {
	ArrayList<Integer> score;
	int sum;
	double avg;
	String name;
	int rank;
	
	Student(String name, int numOfSubject){
		ArrayList<Integer> cpy = new ArrayList<Integer>();
		this.name = name;
		
		for(int i = 0; i < numOfSubject; i++){
			cpy.add((int)(Math.random() * 101));
		}
		for(int i = 0; i < numOfSubject; i++){
			this.sum += cpy.get(i);
		}
		this.score = cpy;
		this.avg = (double)this.sum / numOfSubject;
		this.rank = 1;
	}
}