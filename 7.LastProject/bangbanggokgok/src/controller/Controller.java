/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	Controller.java
 * Revision			:	0.4
 * Date				:	2021.08.15
 * Author			:	Lee KwangHyo
 * 
 */




package controller;

import dao.CartDao;
import service.BoardService;
import service.CartService;
import service.LodgeService;
import service.MemberService;
import service.OptionService;
import service.OrderService;
import service.ReservationService;
import service.RoomService;
import test.TestMain;
import util.ScanUtil;
import util.View;

public class Controller {
	public static void main(String[] args) {
		
	new Controller().start();
	}

	public static String currentDate = "20210819";

	private void start(){		
		int view = View.HOME;
		while(true){
			switch(view){
			case View.HOME 						: view = home();								break;
			case View.LOGIN_SCREEN				: view = MemberService.login_screen();			break;
			case View.ROOM_LIST					: view = LodgeService.roomList();				break;
			case View.ROOM_DETAIL				: view = RoomService.roomDetail();				break;
			case View.NOTICE_BOARD_DETAIL		: view = BoardService.noticeBoardDetail();		break;
			case View.NOTICE_BOARD_LIST			: view = BoardService.noticeBoardList();		break;
			case View.REVIEW_BOARD_LIST			: view = BoardService.reviewBoardList();		break;
			case View.REVIEW_BOARD_DETAIL		: view = BoardService.reviewBoardDetail();		break;
			case View.LODGE_LIST				: view = LodgeService.lodgeList();				break;
			case View.LODGE_MANAGE				: view = LodgeService.lodgeManage();			break;
			case View.SALES_MANAGE				: view = LodgeService.salesManage();			break;
			case View.BOARD_MANAGE				: view = LodgeService.boardManage();			break;			
			case View.ROOM_MANAGE				: view = RoomService.roomManage();				break;
			case View.MY_ROOM_DETAIL			: view = RoomService.myRoomDetail();		break;
			case View.SET_OPTION				: view = OptionService.setOption();				break;
			case View.SET_REGION				: view = OptionService.setRegion();				break;
			
			case View.LOGIN					: view = MemberService.logIn();					break;
			case View.JOIN					: view = MemberService.join();				break;
			
			case View.SHOW_NON				: view = MemberService.show_non();				break;
			case View.SHOW_NORMAL			: view = MemberService.show_normal();			break;
			case View.SHOW_OWNER			: view = MemberService.show_owner();			break;
			case View.RESERVATION_INFO_NON				: view = MemberService.reservationInfo_non();				break;
			
			case View.MY_INFO				: view = MemberService.myInfoNolmal(); 			break;
			case View.MY_INFO_UPDATE		: view = MemberService.updateMyInfo();			break;
			case View.MY_INFO_OWNER			: view = MemberService.myInfoOwner();		break;
			case View.MY_LODGE_LIST			: view = MemberService.myLodgeList();		break;
		
			case View.CART_LIST			: view = CartService.cartList();		break;
			
			case View.RESERVATION		: view = ReservationService.reservation();	break;
			case View.BOOKER_INFO		: view = ReservationService.bookerInfo();	break;
			case View.PAYMENT_GUEST	: view = OrderService.paymentGuest();		break;
			case View.PAYMENT_ONE		: view = OrderService.paymentOne();			break;
			case View.PAYMENT_CART		: view = OrderService.paymentCart();		break;
			
			//컨트롤러 수정>RESERVATION_INFO로 연결 추가
			case View.RESERVATION_INFO	: view = ReservationService.reservationInfo();	break;
			}
		}
	}

	private int home(){
		int result = 0;
		if(MemberService.currentMember == null){
			CartDao.alldelete();
			
			result = View.SHOW_NON;
		}else if((int)MemberService.currentMember.get("MEM_CODE") == 1){
			result = View.SHOW_NORMAL;
		}else if((int)MemberService.currentMember.get("MEM_CODE") == 2){
			result = View.SHOW_OWNER;
		}
		if(result == View.EXIT){
			System.exit(0);
		}else{
			return result;
		}
		return result;
	}

}
