package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class HorceRaceRefactoring {
	
	public static List<MyHorse> recordList = new ArrayList<MyHorse>();
	
    public static void main(String[] args) {
    	
    	System.out.println(Thread.currentThread().getName());
    	
    	List<MyHorse> horseList = new ArrayList<MyHorse>();
    	for(int i = 1; i <= 10; i++) {
    		String tmpName = "";
    		tmpName = i + "번마";
    		horseList.add(new MyHorse(tmpName));
    	}
    	
    	for(MyHorse horse : horseList) {
    		horse.start();
    	}
    	try {
			Thread.sleep(20);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
    	System.out.println("===============================================================");
    	while(recordList.size() != horseList.size()) {
    		for(MyHorse horse : horseList) {
    			System.out.println(horse.getView());
    		}
    		System.out.println("===============================================================");
    		try {
    			Thread.sleep(100);
    		} catch (InterruptedException e) {
    			e.printStackTrace();
    		}
    	}
    	
    	for(MyHorse horse : horseList) {
    		horse.setRank();
    	}
    	
    	Collections.sort(horseList);
    	
    	for(MyHorse horse : horseList) {
    		System.out.println(horse);
    	}
    } 
}
class MyHorse extends Thread implements Comparable<MyHorse>{

    private String name;
    private int rank;
    private int position;
    private List<String> view;
    private long record;
    public MyHorse(String name){
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
    @Override
    public void run(){
    	System.out.println(getView());
    	long startTime = System.currentTimeMillis();
        for(int i = 1; i < 50; i++){
            try{
            	setView();
            	position++;
                Thread.sleep((int)(Math.random() * 200) + 80);
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }
        long endTime = System.currentTimeMillis();
        record = endTime - startTime;
        HorceRaceRefactoring.recordList.add(this);
    }
    
    public void setRank() {
    	this.rank = HorceRaceRefactoring.recordList.indexOf(this) + 1;
    }
    
    @Override
    public int compareTo(MyHorse horse){
        return Long.compare(this.record, horse.record);
    }
    @Override
    public String toString() {
    	return "이름 : " + name + "/ 등수 : " + rank + "/ 기록 : " + (record / 1000) + "." + (record % 1000) + "s";
    }
}
