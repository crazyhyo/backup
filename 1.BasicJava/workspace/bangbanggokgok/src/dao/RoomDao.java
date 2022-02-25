package dao;

import java.util.List;
import java.util.Map;

import service.LodgeService;
import service.OptionService;
import service.RoomService;
import util.JDBCUtil;
import util.ScanUtil;

public class RoomDao {

	private static RoomDao instance = null;
	private static JDBCUtil jdbcUtil = JDBCUtil.getInstance();
	public static LodgeDao lodgeDao = LodgeDao.getInstance();
	
	public static RoomDao getInstance(){
		if(instance == null){
			instance = new RoomDao();
		}
		return instance;
	}
	
	
	public Map<String, Object> searchRoom() {
		System.out.print("선택하실 숙소 번호를 선택해 주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = "  select A.RO_NO AS 객실번호, A.LOD_NO AS 숙소번호, A.RO_N_PRICE AS 일반가격, A.RO_A_PRICE AS 미성년자가격, B.RO_CODE_NM AS 객실종류, "
				+ "			   B.RO_MIN_CAP AS 최소인원, B.RO_MAX_CAP AS 최대인원, A.RO_CIN AS 체크인, A.RO_COUT AS 체크아웃, A.RO_DETAIL AS 객실상세		"
				+ " 	  from ROOM A, ROOM_CODE B "
				+ "		 WHERE A.RO_NO = B.RO_NO"
				+ "		   AND A.LOD_NO = " + LodgeService.currentLodge.get("LOD_NO")
				+ "		   AND A.RO_NO = " + input;
		
		return jdbcUtil.selectOne(sql);
	}
	
	public void selectRoom(Map<String, Object> currentRoom) {
		
		if(currentRoom.size() == 0) {
			System.out.println("해당 테이블의 레코드가 없습니다.");
		}else {
				System.out.println("숙소번호 :" + "\t\t" + currentRoom.get("숙소번호"));
				System.out.println("객실번호 :" + "\t\t" + currentRoom.get("객실번호"));
				System.out.println("객실종류 :" + "\t\t" + currentRoom.get("객실종류"));
				System.out.println("최소인원 :" + "\t\t" + currentRoom.get("최소인원"));
				System.out.println("최대인원 :" + "\t\t" + currentRoom.get("최대인원"));
				System.out.println("일반가격 :" + "\t\t" + currentRoom.get("일반가격"));
				System.out.println("미성년자가격 :" + "\t\t" + currentRoom.get("미성년자가격"));
				System.out.println("체크인 :" + "\t\t" + currentRoom.get("체크인"));
				System.out.println("체크아웃 :" + "\t\t" + currentRoom.get("체크아웃"));
				System.out.println("객실상세 :" + "\t\t" + currentRoom.get("객실상세"));
				System.out.println("-------------------------------------------------");
		}
		
	}
	
	//객실추가
	public int addRoom(){
		System.out.println("======= 객실 추가 ========");
		System.out.print("객실 번호를 입력해주세요. >");
		String roomNo = ScanUtil.nextLine();
		System.out.print("일반 가격을 입력해주세요. >");
		int nPrice = ScanUtil.nextInt();
		System.out.print("미성년자 가격을 입력해주세요. >");
		int aPrice = ScanUtil.nextInt();
		System.out.println("방등급을 선택해주세요");
		System.out.println("1.싱글\t2.더블\t3.트윈\t4.트리플");
		System.out.print(">");
		int roomCode = ScanUtil.nextInt();
		System.out.print("체크인 시간을 입력해주세요. >");
		int checkIn = ScanUtil.nextInt();
		System.out.print("체크아웃 시간을 입력해주세요. >");
		int checkOut = ScanUtil.nextInt();
		System.out.println("객실의 안내문을 입력해주세요. >");
		String roomDetail = ScanUtil.nextLine();
		
		
		String sql = "INSERT INTO ROOM VALUES("
				+ " 	'" + roomNo    +		    "' , "
				+ "     '" + LodgeService.getLodgeNo() +  	 	    "' , " 
				+ "     '" + "1"	 	  +  "' , " 
				+ "     '" + nPrice + 	    "' , " 
				+ "     '" + aPrice + 	    "' , " 
				+ "     '" + roomCode +  	 	    "' , " 
				+ "     '" + checkIn + 	    "' , " 
				+ "     '" + checkOut + 	    "' , " 
				+ "     '" + roomDetail +    	     "' )";
		
		//룸생성 실패 추가할것
		
		return jdbcUtil.update(sql);
		
	}
		
	public int modifyRoom(){
		System.out.println("======= 객실 추가 ========");
		System.out.print("객실 번호를 입력해주세요. >");
		String roomNo = ScanUtil.nextLine();
		System.out.print("일반 가격을 입력해주세요. >");
		int nPrice = ScanUtil.nextInt();
		System.out.print("미성년자 가격을 입력해주세요. >");
		int aPrice = ScanUtil.nextInt();
		System.out.println("방등급을 선택해주세요");
		System.out.println("1.싱글\t2.더블\t3.트윈\t4.트리플");
		System.out.print(">");
		int roomCode = ScanUtil.nextInt();
		System.out.print("체크인 시간을 입력해주세요. >");
		int checkIn = ScanUtil.nextInt();
		System.out.print("체크아웃 시간을 입력해주세요. >");
		int checkOut = ScanUtil.nextInt();
		System.out.println("객실의 안내문을 입력해주세요. >");
		String roomDetail = ScanUtil.nextLine();
		System.out.println("활성화 여부를 선택해주세요.");
		System.out.println("1.활성화\t0.비활성화");
		int active = ScanUtil.nextInt();
		
		String sql = "UPDATE ROOM "
				+ "		 SET RO_NO = " + roomNo + " , "
				+ "		 SET LOD_NO = " + LodgeService.getLodgeNo() + " , "
				+ "		 SET RO_CODE = " + roomCode + " , "
				+ "		 SET RO_N_PRICE = " + nPrice + " , "
				+ "		 SET RO_A_PRICE = " + aPrice + " , "
				+ "		 SET RO_CIN = " + checkIn + " , "
				+ "		 SET RO_COUT = " + checkOut + " , "
				+ "		 SET RO_DETAIL = " + roomDetail + " , "
				+ "		 SET RO_ACTIVE = " + active ;
		
		return jdbcUtil.update(sql);
	}
	
	//활성화테이블
	public int deleteRoom(){
		
		String sql = "UPDATE ROOM "
				+    "	 SET RO_ACTIVE = 0"
				+ 	 " WHERE RO_NO = " + RoomService.currentRoom.get("RO_NO");

		System.out.println("삭제되었습니다.");
		return jdbcUtil.update(sql);
	}
	
}
