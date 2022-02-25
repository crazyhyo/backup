/*
 * public static int roomDetail() : X
 * 
 * Lee KwangHyo
 */

package service;

import java.util.Map;

import dao.RoomDao;

public class RoomService {

	
	public static Map<String, Object> currentRoom = null;
	private static JDBCUtil instance = JDBCUtil.getInstance();
	public static RoomDao roomDao = RoomDao.getInstance();
	public static LodgeDao lodgeDao = LodgeDao.getInstance();
	
	
	
	
	public static int roomList() {
		System.out.println("ROOM_LIST");
		
		Map<String, Object> constraint = null;
		Map<String, Object> tmpRoom = null;
		
		lodgeDao.getRoomList();
		
		System.out.println("1.객실상세\t2.공지사항\t3.후기게시판\t4.날짜변경\n "
				+ "101.테스트\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1:
			tmpRoom = roomDao.searchRoom();
			if (tmpRoom == null){
				System.out.println("해당 객실이 존재하지 않습니다.");
				return View.ROOM_LIST;
			}else{
				currentRoom = tmpRoom;
				return View.ROOM_DETAIL;
			}
		case 2: return View.NOTICE_BOARD_LIST ;
		case 3: return View.REVIEW_BOARD_LIST ;
		case 4: return View.SET_OPTION ;
		case 101: return View.TEST;
		case 0: return View.EXIT;
		}
		
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
	            + (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return 0;
	}
	
	
	public static int roomDetail(){
		System.out.println("ROOM_DETAIL");
		
		roomDao.selectRoom(currentRoom);
		
		System.out.println("file:"
				+ (new Throwable()).getStackTrace()[0].getClassName()
				+ "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
		
		
		return View.ROOM_DETAIL;
	}
	
	
	
	
	
	
	
	//숙박업주 관리용

	public static int roomManage() {
		System.out.println("ROOM_MANAGE");
		
		Map<String, Object> constraint = null;
		Map<String, Object> tmpLodge = null;
		
		
		lodgeDao.getRoomList();
		
		System.out.println("1.객실관리\t2.매출조회\t3.게시판관리\t4.예약자정보\n"
				+ "101.테스트\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1: return View.ROOM_MANAGE;
		case 2: return View.SALES_MANAGE;
		case 3: return View.BOARD_MANAGE;
		case 4: return View.BOOKER_INFO;
		case 101: return View.TEST;
		case 0: return View.EXIT;
		}
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
	            + (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return 0;
	}
	
	public static int roomAdd(){
		System.out.println("ROOM_ADD");
		roomDao.addRoom();
		
		System.out.println("file:"
		+ (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
		+ (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return View.ROOM_DETAIL;
	}
	
	
	
	public static int roomModify(){
		System.out.println("ROOM_MODIFY");
		roomDao.modifyRoom();
		
		System.out.println("file:"
				+ (new Throwable()).getStackTrace()[0].getClassName()
				+ "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return View.ROOM_DETAIL;
	}
	
	public static int roomDelete(){
		System.out.println("ROOM_DELETE");
		roomDao.deleteRoom();

		System.out.println("file:"
				+ (new Throwable()).getStackTrace()[0].getClassName()
				+ "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return View.ROOM_LIST;
	}
	
	
}
