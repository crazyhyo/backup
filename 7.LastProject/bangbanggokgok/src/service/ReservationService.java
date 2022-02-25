package service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.CartDao;
import dao.ReservationDao;

public class ReservationService {
	
	private ReservationService(){}
	private static ReservationService instance;
	public static ReservationService getInstance(){
		if(instance == null){
			instance = new ReservationService();
		}
		return instance;
	}
	
	public static Map<String, Object> currentReservation;

	public static ReservationDao reservationDao = ReservationDao.getInstance();
	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	public static int reservation() {
		Map<String, Object> tmpCart = null;
		
		System.out.println("1.결제\t2.장바구니 담기\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1: 
			tmpCart = CartDao.insertCart();
			
			CartService.currentCart = tmpCart;
			
			if(MemberService.currentMember == null) {
				System.out.println("비회원결제로 이동합니다.");
				return View.PAYMENT_GUEST;
			}
			
			
			
			if(tmpCart == null) {
				System.out.println("결제에 오류가 발생했습니다.");
				return View.RESERVATION;
			}else {
				System.out.println("해당 상품을 선택하였습니다.");
				return View.PAYMENT_ONE;
			}
		case 2:
			if(MemberService.currentMember == null) {
				System.out.println("장바구니는 회원만 이용할 수 있습니다. 로그인해주세요");
				return View.RESERVATION;
			}
			
			tmpCart = CartDao.insertCart();
			if(tmpCart == null) {
				System.out.println("장바구니에 담지 못했습니다.");
				ScanUtil.stop(1000);
				return View.ROOM_DETAIL;
			}else {
				System.out.println("장바구니에 추가되었습니다.");
				System.out.println("1.장바구니 가기\t2.객실상세로 돌아가기");
				input = ScanUtil.nextInt();
				if(input == 1) {
					return View.CART_LIST;
				}
				return View.ROOM_DETAIL;
			}
		case 0: return View.ROOM_DETAIL;
		}
		return View.ROOM_DETAIL;
	}
	
	public static int bookerInfo(){
		reservationDao.bookerList();
		
		return View.LODGE_MANAGE;
	}
	
	//reservationInfo 추가
	public static int reservationInfo() {
		List<Map<String, Object>> myResvList = reservationDao.MyResvList();
		if(myResvList == null){
			System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			System.out.println("예약정보가 없습니다.");
			System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		}else{
			for(Map<String, Object> walk : myResvList){
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
				System.out.println("예약정보\n");
				System.out.println("예약번호 \t:\t" + walk.get("RESV_NO"));
				System.out.println("예약숙소명 :\t"  + walk.get("LOD_NM"));
				System.out.println("방번호 \t:\t" + walk.get("RO_NO") + "호실");
				System.out.println("입실일 \t:\t" + sdf.format(walk.get("RESV_SDATE")));
				System.out.println("퇴실일 \t:\t" + sdf.format(walk.get("RESV_EDATE")));
				System.out.println("결제일 \t:\t" + sdf.format(walk.get("ORD_DATE")));
				System.out.println("예약인원 \t:\t" + walk.get("RESV_CAP") + "명");
				System.out.println("총 가격 \t:\t" + walk.get("RESV_SUM"));
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			
		}
		
			
		}
		
		
		
		
		System.out.println("0. 돌아가기");
		int input = ScanUtil.nextInt();
		
		switch (input) {
		case 0:
			return View.MY_INFO;
		}
		
		return 0;
	}

}
