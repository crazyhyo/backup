

/*
 *  
 *  
 *  searchroom : o
 *  selectroom : x
 *  addRoom :  o
 *  modifyRoom : o
 *  deleteRoom : o
 *  
 * 
 */


package dao;

import java.text.SimpleDateFormat;
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
	private static JDBCUtil jdbc = JDBCUtil.getInstance();
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
	
	
	public static RoomDao getInstance(){
		if(instance == null){
			instance = new RoomDao();
		}
		return instance;
	}
	
	public Map<String, Object> searchRoom() {
		System.out.print("선택하실 숙소 번호를 선택해 주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = "  select * from ROOM "
				+ "		  WHERE LOD_NO = " + LodgeService.getLodgeNo()
				+ "		   AND RO_NO = " + input
				+ "        AND RO_ACTIVE = 1 " ;
		
		return jdbcUtil.selectOne(sql);
	}
	
	public void selectRoom(Map<String, Object> currentRoom) {
		
		Map<String, Object> printRoom = ConvPrint(currentRoom);
		
		if(currentRoom.size() == 0) {
			System.out.println("해당 객실이 없습니다.");
		}else {
				System.out.println("객실번호 :" + "\t\t" + printRoom.get("객실번호"));
				System.out.println("객실종류 :" + "\t\t" + printRoom.get("객실종류"));
				System.out.println("최소인원 :" + "\t\t" + printRoom.get("최소인원"));
				System.out.println("최대인원 :" + "\t\t" + printRoom.get("최대인원"));
				System.out.println("일반가격 :" + "\t\t" + printRoom.get("일반가격"));
				System.out.println("미성년자가격 :" + "\t" + printRoom.get("미성년자가격"));
				System.out.println("체크인 :" + "\t\t" + printRoom.get("체크인"));
				System.out.println("체크아웃 :" + "\t\t" + printRoom.get("체크아웃"));
				System.out.println("객실상세 :" + "\t\t" + printRoom.get("객실상세"));
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		}
		
	}
	
	private Map<String, Object> ConvPrint(Map<String, Object> currentRoom) {
		String sql = "  select A.RO_NO AS 객실번호, A.LOD_NO AS 숙소번호, A.RO_N_PRICE AS 일반가격, A.RO_A_PRICE AS 미성년자가격, B.RO_CODE_NM AS 객실종류, "
				+ "			   B.RO_MIN_CAP AS 최소인원, B.RO_MAX_CAP AS 최대인원, A.RO_CIN AS 체크인, A.RO_COUT AS 체크아웃, A.RO_DETAIL AS 객실상세,	"
				+ "			   A.RO_ACTIVE AS 활성화여부	"
				+ " 	  from ROOM A, ROOM_CODE B "
				+ "		 WHERE A.RO_CODE = B.RO_CODE"
				+ "		   AND A.LOD_NO = " + LodgeService.currentLodge.get("LOD_NO")
				+ "		   AND A.RO_NO = " + RoomService.getRoomNo()
				+ "        AND A.RO_ACTIVE = 1"; 
		
		return jdbcUtil.selectOne(sql);
	}

	//객실추가
	public int addRoom(){
		System.out.println("======= 객실 추가 ========");
		System.out.print("객실 번호를 입력해주세요. >");
		String roomNo = ScanUtil.nextLine();
		String sql = "SELECT RO_NO, RO_ACTIVE FROM ROOM WHERE LOD_NO = " + LodgeService.getLodgeNo()
					 + " AND RO_NO = " + roomNo;
		Map<String,Object> actRoom = jdbcUtil.selectOne(sql);
		if (actRoom == null) {
			int roomCode = 0;
			
			System.out.print("일반 가격을 입력해주세요. >");
			int nPrice = ScanUtil.nextInt();
			System.out.print("미성년자 가격을 입력해주세요. >");
			int aPrice = ScanUtil.nextInt();
			do{
			System.out.println("방등급을 선택해주세요");
			System.out.println("1.싱글\t2.더블\t3.트윈\t4.트리플");
			System.out.print(">");
			roomCode = ScanUtil.nextInt();
			} while (roomCode < 1 || roomCode > 4);
			
			System.out.print("체크인 시간(숫자만)을 입력해주세요. >");
			int checkIn = ScanUtil.nextInt();
			System.out.print("체크아웃 시간(숫자만)을 입력해주세요. >");
			int checkOut = ScanUtil.nextInt();
			System.out.println("객실의 안내문을 입력해주세요. >");
			String roomDetail = ScanUtil.nextLine();
			
			sql = "INSERT INTO ROOM VALUES("
					+ " 	'" + roomNo    +		    "' , "
					+ "     '" + LodgeService.getLodgeNo() +  	 	    "' , " 
					+ "     '" + "1"	 	  +  "' , " 
					+ "     '" + nPrice + 	    "' , " 
					+ "     '" + aPrice + 	    "' , " 
					+ "     '" + roomCode +  	 	    "' , " 
					+ "     '" + checkIn + 	    ":00' , " 
					+ "     '" + checkOut + 	    ":00' , " 
					+ "     '" + roomDetail +    	     "' )";

			jdbcUtil.update(sql);
			
			System.out.println("객실이 추가되었습니다.");
			
		} else if ((int)actRoom.get("RO_ACTIVE") == 0) {
			System.out.println("해당하는 객실번호는 이전에 추가한 이력이 있습니다.");
			System.out.println("재사용 하시겠습니까? (y/n) >");
			String input = ScanUtil.nextLine();
			if (input.equals("y") || input.equals("Y")) {
				sql = "UPDATE ROOM "
					   + "SET RO_ACTIVE = 1"
					 + "WHERE LOD_NO = " + LodgeService.getLodgeNo()
					  + " AND RO_NO = " + roomNo;
				jdbcUtil.update(sql);
			} else {
				System.out.println("취소하셨습니다.");
			}	
		} else {
			System.out.println("이미 해당하는 객실이 존재합니다.");
		}
		
		return 0;
		
	}
		
	public int modifyRoom(){
		int roomCode = 0;
		
		System.out.println("======= 객실 추가 ========");
		System.out.print("객실 번호를 입력해주세요. >");
		String roomNo = ScanUtil.nextLine();
		System.out.print("일반 가격을 입력해주세요. >");
		int nPrice = ScanUtil.nextInt();
		System.out.print("미성년자 가격을 입력해주세요. >");
		int aPrice = ScanUtil.nextInt();
		do{
			System.out.println("방등급을 선택해주세요");
			System.out.println("1.싱글\t2.더블\t3.트윈\t4.트리플");
			System.out.print(">");
			roomCode = ScanUtil.nextInt();
			} while (roomCode < 1 || roomCode > 4);
			
		System.out.print("체크인 시간을 입력해주세요. >");
		int checkIn = ScanUtil.nextInt();
		System.out.print("체크아웃 시간을 입력해주세요. >");
		int checkOut = ScanUtil.nextInt();
		System.out.println("객실의 안내문을 입력해주세요. >");
		String roomDetail = ScanUtil.nextLine();
		
		String sql = "UPDATE ROOM "
				+ "		SET RO_NO = '" + roomNo + "' , "
				+ "		  LOD_NO = '" + LodgeService.getLodgeNo() + "' , "
				+ "		  RO_CODE = '" + roomCode + "' , "
				+ "		  RO_N_PRICE = '" + nPrice + "' , "
				+ "		  RO_A_PRICE = '" + aPrice + "' , "
				+ "		  RO_CIN = '" + checkIn + ":00' , "
				+ "		  RO_COUT = '" + checkOut + ":00' , "
				+ "		  RO_DETAIL = '" + roomDetail + "'  "
				+ "		WHERE RO_NO = " + RoomService.getRoomNo()
				+ "       AND LOD_NO = " + LodgeService.getLodgeNo();
		
		return jdbcUtil.update(sql);
	}
	
	public int deleteRoom(){
		
		String sql = "UPDATE ROOM "
				+    "	 SET RO_ACTIVE = 0"
				+ 	 " WHERE RO_NO = " + RoomService.getRoomNo()
				+    "   AND LOD_NO = " + LodgeService.getLodgeNo();

		System.out.println("삭제되었습니다.");
		return jdbcUtil.update(sql);
	}
	
	public List<Map<String, Object>> getRoomResv(){
		String sql = "select resv_sdate as sdate, resv_edate as edate"
				+ "     from reservation"
				+ "    where lod_no = " + LodgeService.getLodgeNo()
				+ "	         and ro_no = " + RoomService.getRoomNo();
		
		List<Map<String, Object>> selectList = jdbc.selectList(sql);
		
		return selectList;
	}
	
	public boolean checkAvail(List<Map<String, Object>> resvDateList){
		String sdate = OptionService.getSdate();
		String edate = OptionService.getEdate();
		
		boolean flag = true;
		
		String Sdate = null;
		String Edate = null;

		
		for(Map<String, Object> walk : resvDateList){
			Sdate = sdf.format(walk.get("SDATE"));
			Edate = sdf.format(walk.get("EDATE"));
			if(dateDiff(sdate, Edate) >= 0 && dateDiff(Sdate, edate) >= 0){
				return false;
			}
		}
		return flag;
	}
	
	
	public static int dateDiff(String start, String end){
		String sql = "select to_date('" + end + "') - to_date('" + start +"') + 1 as diff from dual";
		return (int)jdbc.selectOne(sql).get("DIFF");
	}

	public static Map<String, Object> getCapacity() {
		String sql = "select b.ro_min_cap as mincap, b.ro_max_cap as maxcap"
				+ "     from room a, room_code b"
				+ "    where a.ro_code = b.ro_code"
				+ "          and a.ro_no = " + RoomService.getRoomNo()
				+ "          and a.lod_no = " + LodgeService.getLodgeNo();
		
		return jdbc.selectOne(sql);
	}
}

