package coingameIO;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.Set;

public class HotelManage2 {
	private Scanner scan;
	private Map<String, Room2> roomMap;
	
	HotelManage2(){
		this.scan = new Scanner(System.in);
		roomMap = new HashMap<String, Room2>();
	}
	
	public static void main(String[] args) {
		new HotelManage2().start();
	}
	private void start() {
		
		File file = new File("d:/D_Other/room2.bin");
		if(file.exists()) {
			System.out.println("파일이 존재합니다. 정보를 불러옵니다.");
		}else {
			System.out.println("새 파일을 생성합니다.");
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		try (	
				ObjectInputStream ois = 
						new ObjectInputStream(
								new BufferedInputStream(
										new FileInputStream("d:/D_Other/room2.bin")));				
				) {
			Object obj = null;
			while((obj = ois.readObject()) != null) {
				Room2 tmpRoom = (Room2) obj;
				roomMap.put(tmpRoom.getName(), tmpRoom);
			}
		}catch(IOException e) {
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println("정보 불러오기 완료");

		System.out.println();
		
		printStart();
		
		int input = 0;
		
		main : while(true) {
			printMain();
			input = scan.nextInt();
			switch(input) {
			case 1: checkIn(); break;
			case 2: checkOut(); break;
			case 3: showRoom(); break;
			case 4: end(); break main;
			}
		}
		
		try (
				ObjectOutputStream oos = 
						new ObjectOutputStream(
								new BufferedOutputStream(
										new FileOutputStream("d:/D_Other/room2.bin")));
				){
			Set<Entry<String, Room2>> entrySet = roomMap.entrySet();
			for(Entry<String, Room2> entry : entrySet) {
				oos.writeObject(roomMap.get(entry.getKey()));
			}
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	private void showRoom() {
		Set<Entry<String, Room2>> entrySet = roomMap.entrySet();
		for(Entry<String, Room2> entry : entrySet) {
			System.out.println("방번호 : " + entry.getValue().getRoomNo() + ", 투숙객 : " + entry.getValue().getName());
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
			roomMap.remove(roomNo);
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
			roomMap.put(roomNo, new Room2(roomNo, name));
			System.out.println("체크인 되었습니다.");
		}else {
			System.out.println(roomNo + "방에는 이미 사람이 있습니다.");
		}
	}

	private void end() {
		printEnd();
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

class Room2 implements Serializable{
	private String roomNo;
	private String name;
	public String getRoomNo() {
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
	public Room2(String roNo, String name) {
		super();
		this.roomNo = roNo;
		this.name = name;
	}
	@Override
	public String toString() {
		return "Room [roNo=" + roomNo + ", name=" + name + "]";
	}
}