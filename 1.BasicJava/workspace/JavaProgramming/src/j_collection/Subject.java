package j_collection;

import java.util.ArrayList;

public class Subject {
	String name;
	int subSum = 0;
	double subAvg = 0;
	
	Subject(String subName, ArrayList<Student> std, int index){
		this.name = subName;		
		for(int j = 0; j < std.size(); j++){
			subSum += std.get(j).score.get(index);
		}
		subAvg = (double)subSum / std.size();
	}
}
