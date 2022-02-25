/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	LodgeService.java
 * Revision			:	0.1
 * Date				:	2021.08.15
 * Author			:	Lee KwangHyo
 * 
 */

/*
 * public static int getLodgeNo() : O
 * public static String getLodgeName() : O
 * public static int roomList() : O
 * public static void showRoomList() : O
 * public static int lodgeList() : O
 * 
 * Lee KwangHyo
 */

package service;

import java.util.List;
import java.util.Map;

import controller.Controller;
import dao.LodgeDao;
import dao.RoomDao;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;

public class LodgeService {
	
	public static Map<String, Object> currentLodge = null;
	private static JDBCUtil instance = JDBCUtil.getInstance();
	public static LodgeDao lodgeDao = LodgeDao.getInstance();
	
	public static int getLodgeNo() {
		
		if(currentLodge != null){
			return (int)currentLodge.get("숙소번호");
		}else{
			System.out.println("현재 선택된 숙소가 없습니다.");
		}
		return -1;
	}
	
	public static String getLodgeName(){
		if(currentLodge != null){
			return (String)currentLodge.get("숙소이름");
		}else{
			System.out.println("현재 선택된 숙소가 없습니다.");
		}
		return null;
	}

//	public static int roomList() {
//		System.out.println("ROOM_LIST");
//		MemberService.currentMember.get("MEM_NM");
//		
//		System.out.println("===" + LodgeService.getLodgeName() + "===");
//		showRoomList();
//		
//		System.out.println("1.객실선택\t2.날짜입력\t3.공지사항\t4.후기 게시판\n"
//				+ "101.테스트\t0.돌아가기");
//		int input = ScanUtil.nextInt();
//		switch(input){
//		case 1:	return View.ROOM_DETAIL;
//		case 2: return View.SET_OPTION;
//		case 3: return View.NOTICE_BOARD_LIST;
//		case 4: return View.REVIEW_BOARD_LIST;
//		case 101: return View.TEST;
//		case 0: return View.EXIT;
//		}
//		return 0;
//	}

	public static void showRoomList() {
		List<Map<String, Object>> getRoomList = lodgeDao.getRoomList();

		if(getRoomList.size() == 0) {
			System.out.println("해당 숙소에 등록된 방이 없습니다.");
		}else {

			for(Map<String, Object> walk : getRoomList){
				System.out.println(walk.get("NO"));
				System.out.println(walk.get("TYPE"));
				System.out.println(walk.get("PRICE"));
				System.out.println("=====================================");
			}
		}
		
	}
	
	public static int lodgeList() {
		System.out.println("LODGE_LIST");
		
		Map<String, Object> constraint = null;
		Map<String, Object> tmpLodge = null;
		
		lodgeDao.showList(constraint);
		System.out.println("1.숙소선택\t2.조건설정\n"
				+ "101.테스트\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1:
			tmpLodge = lodgeDao.searchLodge();
			if (tmpLodge == null){
				System.out.println("해당 숙소가 존재하지 않습니다.");
				return View.LODGE_LIST;
			}else{
				currentLodge = tmpLodge;
				return View.ROOM_LIST;
			}
		case 101: return View.TEST;
		case 0: return View.EXIT;
		}
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
	            + (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return 0;
	}

	
	
	//내 건물 목록
	public static int myLodgeList() {
		System.out.println("MY_LODGE_LIST");
		
		Map<String, Object> constraint = null;
		Map<String, Object> tmpLodge = null;
		
		lodgeDao.showList(constraint);
		System.out.println("1.관리건물 추가\t2.건물상세\n"
				+ "101.테스트\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1:
			lodgeDao.addLodge();
			return View.MY_LODGE_LIST;
		case 2: 
			tmpLodge = lodgeDao.searchLodge();
			if (tmpLodge == null){
				System.out.println("해당 숙소가 존재하지 않습니다.");
				return View.MY_LODGE_LIST;
			}else{
				currentLodge = tmpLodge;
				return View.LODGE_MANAGE;
			}
		case 101: return View.TEST;
		case 0: return View.EXIT;
		}
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
	            + (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return 0;
	}
	
	
	public static int lodgeAdd(){
		System.out.println("LODGE_ADD");
		
		lodgeDao.addLodge();
		
		System.out.println("file:"
				+ (new Throwable()).getStackTrace()[0].getClassName()
				+ "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
		return View.LODGE_LIST;
	}
	
	
	public static int lodgeManage() {
		System.out.println("LODGE_MANAGE");
		
		lodgeDao.lodgeDetail(currentLodge);
		lodgeDao.getRoomList();
		
		System.out.println("1.객실관리\t2.매출조회\t3.게시판관리\t4.예약자정보\n"
				+ "10.건물수정\t11.건물삭제\n"
				+ "101.테스트\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1: return View.ROOM_MANAGE;
		case 2: return View.SALES_MANAGE;
		case 3: return View.BOARD_MANAGE;
		case 4: return View.BOOKER_INFO;
		case 10: 
			lodgeDao.modifyLodge();
			return View.MY_LODGE_LIST;
		case 11: 
			lodgeDao.deleteLodge();
			return View.MY_LODGE_LIST;
		case 101: return View.TEST;
		case 0: return View.EXIT;
		}
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
	            + (new Throwable()).getStackTrace()[0].getLineNumber());
		
		return 0;
	}
	
	public static int salesManage(){
		System.out.println("SALES_MANAGE");
		
		
		
		return 0;
	}
	
}
