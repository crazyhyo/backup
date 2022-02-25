package kr.or.ddit.basic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import kr.or.ddit.util.MyJDBCUtil;

import java.util.Scanner;
import java.util.Set;

public class HotelManage {
	private Scanner scan;
	private Map<String, Room> roomMap;
	private MyJDBCUtil jdbc = MyJDBCUtil.getInstance();
	
	HotelManage(){
		this.scan = new Scanner(System.in);
		roomMap = new HashMap<String, Room>();
		MyJDBCUtil.getConnection();
	}
	
	public static void main(String[] args) {
		new HotelManage().start();
	}
	private void start() {
		
		
		printStart();
		
		int input = 0;
		
		while(true) {
			convert();
			printMain();
			input = scan.nextInt();
			switch(input) {
			case 1: checkIn(); break;
			case 2: checkOut(); break;
			case 3: showRoom(); break;
			case 4: end();
			}
		}
	}
	
	private void convert() {
		String sql = "";
		
		sql = "select * from room";
		
		List<Map<String, Object>> list = 
				MyJDBCUtil.selectList(sql);
		
		for(int i = 0; i <list.size(); i++) {
			String roomNo = (String) list.get(i).get("ROOM_NO");
			String name = (String) list.get(i).get("NAME");
			roomMap.put(roomNo, new Room(roomNo, name));
		}
	}

	private int insert(String roomNo, String name) {
		String sql = "";
		sql = "insert into room(room_no, name)"
				+ "values('" + roomNo + "', '" + name + "')";
		
		roomMap.put(roomNo, new Room(roomNo,name));
		
		return MyJDBCUtil.update(sql);
	}
	
	private int delete(String roomNo) {
		String sql = "";
		sql = "delete room where room_no = '" + roomNo + "'";
		
		roomMap.remove(roomNo);
		
		return MyJDBCUtil.update(sql);
	}
	private void showRoom() {
		Set<Entry<String, Room>> entrySet = roomMap.entrySet();
		for(Entry<String, Room> entry : entrySet) {
			System.out.println("방번호 : " + entry.getKey() + ", 투숙객 : " + entry.getValue().getName());
		}
		System.out.println();
	}

	private void checkOut() {
		System.out.println("어느방을 체크아웃 하시겠습니까?");
		System.out.print("방번호 입력 => ");
		scan.nextLine();
		String roomNo = scan.nextLine();
		
		if(roomMap.get(roomNo) == null) {
			System.out.println(roomNo + "방에는 체크인한 사람이 없습니다.");
		}else {
			delete(roomNo);
			System.out.println("체크아웃 되었습니다.");
		}
	}

	private void checkIn() {
		System.out.println("어느방에 체크인 하시겠습니까?");
		System.out.print("방번호 입력 => ");
		scan.nextLine();
		String roomNo = scan.nextLine();

		System.out.println("누구를 체크인 하시겠습니까?");
		System.out.print("이름 입력 => ");
		String name = scan.nextLine();
		
		if(roomMap.get(roomNo) == null) {
			insert(roomNo, name);
			System.out.println("체크인 되었습니다.");
		}else {
			System.out.println(roomNo + "방에는 이미 사람이 있습니다.");
		}
	}

	private void end() {
		printEnd();
		System.exit(0);
	}

	private void printEnd() {
		System.out.println("**************************");
		System.out.println("호텔 문을 닫았습니다.");
		System.out.println("**************************");
		
	}

	private void printStart() {
		System.out.println("**************************");
		System.out.println("호텔 문을 열었습니다.");
		System.out.println("**************************");
		
	}

	private void printMain() {
		System.out.println("*******************************************");
		System.out.println("어떤 업무를 하시겠습니까?");
		System.out.println("1.체크인  2.체크아웃 3.객실상태 4.업무종료");
		System.out.println("*******************************************");
		System.out.print("메뉴선택 => ");
	}
	
}

class Room{
	private String roomNo;
	private String name;
	public String getRoNo() {
		return roomNo;
	}
	public void setRoNo(String roNo) {
		this.roomNo = roNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Room(String roNo, String name) {
		super();
		this.roomNo = roNo;
		this.name = name;
	}
	@Override
	public String toString() {
		return "Room [roNo=" + roomNo + ", name=" + name + "]";
	}
}