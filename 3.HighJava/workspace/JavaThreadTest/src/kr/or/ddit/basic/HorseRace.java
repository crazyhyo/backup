package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class HorseRace {
	static int end = 0;
	public static List<Horse> recordList = new ArrayList<Horse>();
	
    public static void main(String[] args) {
    	List<Horse> horseList = new ArrayList<Horse>();
    	
    	for(int i = 1; i <= 10; i++) {
    		String tmpName = "";
    		tmpName = i + "번마";
    		horseList.add(new Horse(tmpName));
    	}
    	
    	for(Horse horse : horseList) {
    		horse.start();
    		System.out.println(horse.getHorseName() + " : >------------------------------------------------");
    	}
    	try {
			Thread.sleep(20);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
    	System.out.println("===============================================================");
    	while(recordList.size() != 10) {
    		for(Horse horse : horseList) {
    			System.out.println(horse.getView());
    		}
    		System.out.println("===============================================================");
    		try {
    			Thread.sleep(100);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    	}
    	Collections.sort(horseList);
    	
    	for(Horse horse : horseList) {
    		System.out.println(horse);
    	}
    } 
}

class Horse extends Thread implements Comparable<Horse>{

    private String name;
    private int rank;
    private int position;
    private List<String> view;
    public Horse(String name){
    	view = new ArrayList<String>();
        this.rank = 1;
        this.position = 1;
        this.name = name;
        view.add(">");
        for(int i = 1; i < 50; i++) {
        	view.add("-");
        }
    }
    private void setView() {
    	view.set(position - 1, "-");
    	view.set(position, ">");
    }
    public String getView(){
    	String str = name + " : ";
    	for(int i = 0; i < 50; i++) {
    		str += view.get(i);
    	}
    	return str;
    }
    public String getHorseName() {
    	return this.name;
    }
    @Override
    public void run(){
//    	System.out.println(getView());
        for(int i = 1; i < 50; i++){
            try{
            	setView();
            	position++;
                Thread.sleep((int)(Math.random() * 80) + 80);
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }
        HorseRace.recordList.add(this);
        this.rank = HorseRace.recordList.indexOf(this) + 1;
    }

    @Override
    public int compareTo(Horse horse){
//        return Integer.compare(HorseRace.recordList.indexOf(this), HorseRace.recordList.indexOf(horse));
        return Integer.compare(rank, horse.rank);
    }
    @Override
    public String toString() {
    	return "이름 : " + name + "/ 등수 : " + rank;
    }
}
