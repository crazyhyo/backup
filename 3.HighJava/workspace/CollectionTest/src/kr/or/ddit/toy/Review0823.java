package kr.or.ddit.toy;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Review0823 {
	
	public static void main(String[] args) {
		
		List<Member> memList = new ArrayList<Member>();
		
		memList.add(new Member("소녀전선", "010-1111-2222", 1));
		memList.add(new Member("벽람항로", "010-1111-2222", 6));
		memList.add(new Member("백야극광", "010-1111-2222", 3));
		memList.add(new Member("소울워커", "010-1111-2222", 12));
		memList.add(new Member("칸코레", "010-1111-2222", 7));
		memList.add(new Member("원신", "010-1111-2222", 0));
		memList.add(new Member("파이널기어", "010-1111-2222", 9));
		memList.add(new Member("뱅드림", "010-1111-2222", 8));
		memList.add(new Member("아이마스", "010-1111-2222", 2));
		memList.add(new Member("붕괴3", "010-1111-2222", 11));
		memList.add(new Member("명일방주", "010-1111-2222", 10));
		memList.add(new Member("우마무스메", "010-1111-2222", 13));
		
		for(Member mem : memList) {
			System.out.println(mem);
		}
		System.out.println("-----------------");
		Collections.sort(memList);

		for(Member mem : memList) {
			System.out.println(mem);
		}

		System.out.println("-----------------");
		Collections.sort(memList, new Desc());
		
		for(Member mem : memList) {
			System.out.println(mem);
		}
	}

}

class Member implements Comparable<Member> {
	private String name;
	private String tel;
	private int num;

	public Member(String name, String tel, int num) {
		super();
		this.name = name;
		this.tel = tel;
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	@Override
	public int compareTo(Member mem) {
		return this.getName().compareTo(mem.getName());
	}

	@Override
	public String toString() {
		return "Member [name=" + name + ", tel=" + tel + ", num=" + num + "]";
	}
	
}

class Desc implements Comparator<Member>{

	@Override
	public int compare(Member mem1, Member mem2) {
		return -mem1.compareTo(mem2);
	}
	
}
