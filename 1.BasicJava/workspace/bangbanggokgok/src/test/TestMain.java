/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	TestMain.java
 * Revision			:	0.2
 * Date				:	2021.08.15
 * Author			:	Lee KwangHyo
 * 
 */

package test;

import java.util.List;
import java.util.Map;

import controller.Controller;
import dao.OptionDao;
import service.BoardService;
import service.CartService;
import service.LodgeService;
import service.MemberService;
import service.OptionService;
import service.OrderService;
import service.ReservationService;
import service.RoomService;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;


public class TestMain {
	private JDBCUtil instance = JDBCUtil.getInstance();
	
	public TestMain(){}
	
	public int start(){
		
		System.out.println("0.테이블조회\t1.회원설정\t2.숙소설정\t3.방설정\t4.게시글설정\n"
				+ "5.게시글설정\t6.주문설정\t7.예약설정\t8.장바구니설정\n"
				+ "99.BACK_TO_HOME\t100.빠른이동");
		System.out.print("테스트를 선택해주세요>");
		int input = ScanUtil.nextInt();
		return action(input);
	}
	
	private void setMember() {
		System.out.println("1.일반회원 로그인\t2.숙박시설주 로그인\t3.비우기>");
		int input = ScanUtil.nextInt();
		switch(input) {
		case 1: setNormalMember(); break;
		case 2: setAccomOwnerMember(); break;
		case 3: clearMember(); break;
		}
	}

	private void setLodge() {
		System.out.println("1.호텔\t2.모텔\t3.비우기>");
		int input = ScanUtil.nextInt();
		switch(input) {
		case 1: setHotel(); break;
		case 2: setMotel(); break;
		case 3: clearLodge(); break;
		}
		System.out.println(LodgeService.getLodgeName());
	}
	
	private void setRoom() {
		LodgeService.showRoomList();
		System.out.print("설정할 방 번호 입력>");
		int input = ScanUtil.nextInt();
		
	}
	
	private void setBoard() {
		if(LodgeService.currentLodge == null) {
			System.out.println("숙소를 먼저 선택해 주세요");
		}else {
			System.out.println("1.공지게시판\t2.\t3.비우기>");
		}
	}
	
	private void setHotel(){
		String sql = "select * from lodge where lod_no = 1";
		LodgeService.currentLodge = instance.selectOne(sql);
	}
	private void setMotel(){
		String sql = "select * from lodge where lod_no = 2";
		LodgeService.currentLodge = instance.selectOne(sql);
	}
	private void clearLodge(){
		LodgeService.currentLodge = null;
	}
	
	private void setNormalMember(){
		String sql = "select * from member where mem_no = 1";
		MemberService.currentMember = instance.selectOne(sql);
	}
	private void setAccomOwnerMember(){
		String sql = "select * from member where mem_no = 2";
		MemberService.currentMember = instance.selectOne(sql);
	}
	private void clearMember(){
		MemberService.currentMember = null;
	}
	private void setDate(){
		System.out.print("8자리 날자 입력(yyyymmdd):");
		String input = ScanUtil.nextLine();
		Controller.currentDate = input;
	}
	
	private int action(int input) {
		int result = View.HOME;
		switch(input) {
		case 0: table(); break;
		case 1: setMember(); break;
		case 2: setLodge(); break;
		case 3: setRoom(); break;
		case 4: setBoard(); break;
		case 5: setDate(); break;
		case 6: setDate(); break;
		case 7: setDate(); break;
		case 8: break;
		case 99: break;
		case 100: result = quickMove(); break;
		}
		System.out.println("file:" + (new Throwable()).getStackTrace()[0].getClassName() + "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
		System.out.println(result);
		return result;
	}
	
	private int quickMove() {
		Map<String, Object> tmpUser = MemberService.currentMember;
		Map<String, Object> tmpLodge = LodgeService.currentLodge;
		Map<String, Object> tmpRoom = RoomService.currentRoom;
		Map<String, Object> tmpBoard = BoardService.currentBoard;
		Map<String, Object> tmpOrder = OrderService.currentOrder;
		Map<String, Object> tmpReservation = ReservationService.currentReservation;
		Map<String, Object> tmpCart = CartService.currentCart;
		Map<String, Object> tmpOption = OptionService.option;
		String tmpLodgeQuery = OptionDao.lodgeQuery;
		String tmpRoomQuery = OptionDao.roomQuery;
		
		MemberService.currentMember = null;
		LodgeService.currentLodge = null;
		RoomService.currentRoom = null;
		BoardService.currentBoard = null;
		OrderService.currentOrder = null;
		ReservationService.currentReservation = null;
		CartService.currentCart = null;
		OptionService.option = null;
		OptionDao.lodgeQuery = null;
		OptionDao.roomQuery = null;
		
		System.out.print("1.HOME\t2.LOGIN_SCREEN\t3.LOGIN\t4.JOIN\n");
		System.out.print("5.CART_LIST\t6.JOIN_NORMAL\t7.JOIN_OWNER\t8.SET_REGION\n");
		System.out.print("9.SET_OPTION\t10.LODGE_LIST\t11.ROOM_LIST\t12.ROOM_DETAIL\n");
		System.out.print("13.RESERVATION\t14.PAYCHECK\t15.NOTICE_BOARD_LIST\t16.NOTICE_BOARD_DETAIL\n");
		System.out.print("17.CART_DETAIL\t18.RESERVATION_INFO\t19.MY_INFO_CHANGE\t20.MY_INFO\n");
		System.out.print("21.MY_LODGE_LIST\t22.LODGE_DETAIL\t23.LODGE_MANAGE\t24.BOOKER_INFO\n");
		System.out.print("25.SALES_MANAGE\t26.ROOM_MANAGE\t27.GUEST_CONFIRM\t28.REVIEW_BOARD_LIST\n");
		System.out.print("29.REVIEW_BOARD_DETAIL");
		System.out.println("이동하실 화면을 선택해주세요>");
		int input = ScanUtil.nextInt();
		switch(input) {
		case 1: MemberService.currentMember = tmpUser;
				return View.HOME;
		case 2: return View.LOGIN_SCREEN;
		case 3: return View.LOGIN;
		case 4: return View.JOIN;
		case 5: MemberService.currentMember = tmpUser;
				return View.CART_LIST;
		case 6: return View.JOIN_NORMAL;
		case 7: return View.JOIN_OWNER;
		case 8: MemberService.currentMember = tmpUser;
				return View.SET_REGION;
		case 9: MemberService.currentMember = tmpUser;
				return View.SET_OPTION;
		case 10: MemberService.currentMember = tmpUser;
				 return View.LODGE_LIST;
		case 11: MemberService.currentMember = tmpUser;
				 LodgeService.currentLodge = tmpLodge;
				 return View.ROOM_LIST;
		case 12: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 RoomService.currentRoom = tmpRoom;
		 		 return View.ROOM_DETAIL;
		case 13: MemberService.currentMember = tmpUser;
				 return View.RESERVATION;	//정확하지 않음
		case 14: return View.PAYCHECK;
		case 15: MemberService.currentMember = tmpUser;
				 LodgeService.currentLodge = tmpLodge;
				 return View.NOTICE_BOARD_LIST;
		case 16: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 BoardService.currentBoard = tmpBoard;
		 		 return View.NOTICE_BOARD_DETAIL;
		case 17: MemberService.currentMember = tmpUser;
				 CartService.currentCart = tmpCart;
				 return View.CART_DETAIL;
		case 18: MemberService.currentMember = tmpUser;
				 return View.RESERVATION_INFO;	//정확하지 않음
		case 19: MemberService.currentMember = tmpUser;
				 return View.MY_INFO_CHANGE;
		case 20: MemberService.currentMember = tmpUser;
				 return View.MY_INFO;
		case 21: MemberService.currentMember = tmpUser;
				 return View.MY_LODGE_LIST;
		case 22: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 return View.LODGE_DETAIL;
		case 23: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 return View.LODGE_MANAGE;
		case 24: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
 		 		 return View.BOOKER_INFO;
		case 25: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 return View.SALES_MANAGE;
		case 26: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 RoomService.currentRoom = tmpRoom;
		 		 return View.ROOM_MANAGE;
		case 27: return View.GUEST_CONFIRM;
		case 28: System.out.println("file:"
				+ (new Throwable()).getStackTrace()[0].getClassName()
				+ "/line:"
				+ (new Throwable()).getStackTrace()[0].getLineNumber());
				 MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 return View.REVIEW_BOARD_LIST;
		case 29: MemberService.currentMember = tmpUser;
		 		 LodgeService.currentLodge = tmpLodge;
		 		 BoardService.currentBoard = tmpBoard; 
		 		 return View.REVIEW_BOARD_DETAIL;
		}
		return 0;
	}

	private void table() {
		
		boolean flag = true;
		while(flag){
			flag = showList();
		}
	}
	
	private boolean showList(){
		String[] sql = new String[13];
		sql[0] = "select * from member";
		sql[1] = "select * from LODGE";
		sql[2] = "select * from MEMBER_CODE";
		sql[3] = "select * from LODGE_CODE";
		sql[4] = "select * from ROOM_CODE";
		sql[5] = "select * from OWNERSHIP";
		sql[6] = "select * from LODGE_BOARD";
		sql[7] = "select * from RESERVATION";
		sql[8] = "select * from RESERVATION_HISTORY";
		sql[9] = "select * from ROOM_HISTORY";
		sql[10] = "select * from TBL_ORDER";
		sql[11] = "select * from CITY";
		sql[12] = "select * from PROV";
		
		String[] tblName = new String[13];
		tblName[0] = "[MEMBER]";
		tblName[1] = "[LODGE]";
		tblName[2] = "[MEMBER_CODE]";
		tblName[3] = "[LODGE_CODE]";
		tblName[4] = "[ROOM_CODE]";
		tblName[5] = "[OWNERSHIP]";
		tblName[6] = "[LODGE_BOARD]";
		tblName[7] = "[RESERVATION]";
		tblName[8] = "[RESERVATION_HISTORY]";
		tblName[9] = "[ROOM_HISTORY]";
		tblName[10] = "[TBL_ORDER]";
		tblName[11] = "[CITY]";
		tblName[12] = "[PROV]";
		
		System.out.println("0.MEMBER\t1.LODGE\t2.MEMBER_CODE\t3.LODGE_CODE\t4.ROOM_CODE\n"
				+ "5.OWNERSHIP\t6.LODGE_BOARD\t7.RESERVATION\t8.RESERVATION_HISTORY\t9.ROOM_HISTORY\n"
				+ "10.TBL_ORDER\t11.CITY\t12.PROV\t99.BACK_TO_HOME");
		System.out.print("조회하실 테이블을 선택해주세요>");
		int input = ScanUtil.nextInt();
		System.out.println();
		if(input == 99){
			System.out.println("테이블 조회 종료");
			return false;
		}else{
			List<Map<String, Object>> list = instance.selectList(sql[input]);
			showList(list);
			System.out.println("\n");
			return true;
		}
		
	}
	
	private void showList(List<Map<String, Object>> list){
		if(list.size() == 0) {
			System.out.println("해당 테이블의 레코드가 없습니다.");
		}else {
			for(Map.Entry<String, Object> entry : list.get(0).entrySet()){
				System.out.print(entry.getKey() + "\t");
			}
			System.out.println();
			
			for(Map<String, Object> walk : list){
				for(Map.Entry<String, Object> entry : walk.entrySet()){
					System.out.print(entry.getValue() + "\t");
				}
				System.out.println();
			}
		}
	}
	
}
