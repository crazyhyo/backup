package service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;
import util.ScanUtil;
import util.View;
import dao.CartDao;
import dao.MemberDao;
import dao.OrderDao;

public class OrderService {
    
	//싱글톤
	public static Map<String, Object> currentOrder = null;

	   private OrderService(){}
	   private static OrderService instance;
	   public static OrderService getInstance(){
		   if(instance == null){
			   instance = new OrderService();
		   }
		   return instance;
	   }
	   private static CartDao cartDao = CartDao.getInstance();

	   public static int paymentGuest() {
		System.out.println("1.로그인\t2.비회원결제\t0.돌아가기");
		
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1:	return View.LOGIN; 
		case 2: 
			Map<String, Object> tmpMember = MemberDao.guestPayment();
			if(tmpMember == null) {
				System.out.println("오류가 발생했습니다.");
				ScanUtil.stop(1000);
				return View.PAYMENT_GUEST;
			}else {
				MemberService.currentMember = tmpMember; 
				return View.PAYMENT_ONE;
			}
		case 0: return View.ROOM_DETAIL;
		}
		
		return 0;
	}

	public static int paymentOne() {
		
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();
		
		cartList.add(CartService.currentCart);
		
		CartService.showCartList(cartList);
		
		System.out.println("구매하시겠습니까? (Y/N)");
		
		 String input = ScanUtil.nextLine();
		
		if(input.equals("Y")||input.equals("y")){
	   		   OrderDao.InsertOrderOne();
	   		   
	   		   CartService.currentCart = null;
	   		   
	   		   if((int)MemberService.currentMember.get("MEM_CODE") == 3){
	   			   System.out.println("비회원 결재가 완료되었습니다.");
	   			   MemberService.currentMember = null;
	   			   OptionService.option.clear();
	   			   return View.HOME;
	   		   }else{
	   			   System.out.println("결재가 완료되었습니다.");
	   			   OptionService.option.clear();
	   			   return View.RESERVATION_INFO;
	   		   }
	   		   
	   	   }else if(input.equals("N")||input.equals("n")){
	   		     System.out.println("방 상세화면으로 돌아갑니다.");
	   		     return View.ROOM_DETAIL;
	   	   }else{
	   		   System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
	   		   return View.PAYMENT_ONE;
	   	   }
	}

	public static int paymentCart() {
		List<Map<String,Object>> cartList = cartDao.selectCartList();
		CartService.showCartList(cartList);
		
		OrderDao.showSum();
		
		System.out.println("구매하시겠습니까? (Y/N)");
		
		String input = ScanUtil.nextLine();
		
		if(input.equals("Y")||input.equals("y")){
	   		OrderDao.InsertOrderCart(cartList);
	   		System.out.println("결재가 완료되었습니다.");
	   		OptionService.option.clear();
	   		CartDao.alldelete();
	   		return View.RESERVATION_INFO;
	   		   
	   	   }else{
	   		   System.out.println("장바구니 화면으로 돌아갑니다.");
	   		   return View.CART_LIST;
	   	   }
		
	}
	   
}
