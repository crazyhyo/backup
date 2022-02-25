package service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.CartDao;
       
       /*
        * CART_DETAIL 같은 경우는 필요없어서 안 만들었음 
        * cart에서 detail이 필요 없음
        */
     
       
public class CartService {
       
	   //싱글톤
	   public static Map<String, Object> currentCart = null;
	   static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
	   public static CartDao cartdao = CartDao.getInstance();
	   
	   private CartService(){}
	   private static CartService instance;

	   public static Object cartList;
	  
	   public static CartService getInstance(){
		   if(instance == null){
			   instance = new CartService();
		   }
		   return instance;
}
	   private static CartDao cartDao = CartDao.getInstance();
	   
	   public static int getCartNo() {
		   if(currentCart == null) {
			   System.out.println("현재 선택한 장바구니가 없습니다.");
			   return -1;
		   }else {
			   return (int)currentCart.get("CART_NO");
		   }
	   }
	   
	   public static void showCartList(List<Map<String,Object>> cartList){
		   if(cartList.size() == 0){
			   System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			   System.out.println("장바구니가 비어있습니다.");
			   System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		   }else{
			   System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			   for(Map<String,Object> cart : cartList){
				   System.out.println("번호\t" + cart.get("CART_NO"));  
				   System.out.println("숙소명\t" + cart.get("LOD_NM"));   
				   System.out.println("숙소주소\t" + cart.get("CITY_CODE") + " " +  cart.get("PROV_CODE")
						   + " " + cart.get("LOD_ADD_DETAIL"));   
				   System.out.println("방종류\t" + cart.get("RO_NO"));   
				   System.out.println("방등급\t" + cart.get("RO_CODE_NM"));   
				   System.out.println("날짜\t" + sdf.format(cart.get("RESV_SDATE")) + " ~ " + sdf.format(cart.get("RESV_EDATE")));   
				   System.out.println("체크인\t" + cart.get("RO_CIN") + " | " + "체크아웃\t" + cart.get("RO_COUT"));   
				   System.out.println("인원수\t" + cart.get("RESV_CAP"));   
				   System.out.println("총 가격\t" + cart.get("RESV_SUM"));
				   System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			   
		   }
		   }
		   
	   }
	   
	   //장바구니 전체 리스트 보는 것
	   public static int cartList(){
		   List<Map<String,Object>> cartList = cartDao.selectCartList();
		   showCartList(cartList);
		   System.out.println("1.지역 설정으로 돌아가기\t2.결제하기\t3.삭제하기\t4.모두 삭제하기\t5.내 정보로 돌아가기");
		   System.out.println("번호를 입력하세요");
		   
		   int input = ScanUtil.nextInt();
		   
		   switch(input){
		   case 1: 
			   return View.SET_REGION; 
		   case 2:
			   return View.PAYMENT_CART;
		   case 3:
			   cartDelete();
			   return View.CART_LIST;
		   case 4:
			   cartAllDelete();
			   return View.CART_LIST;
		   case 5:
			   return View.MY_INFO; //내 정보로 돌아감
		   }
		   return View.HOME;
	   }
	   
	   //삭제하기
	   public static void cartDelete(){
		   System.out.println("삭제하실 장바구니 번호를 입력해주세요.");
		   int cartNo = ScanUtil.nextInt();
		   if(cartDao.delete(cartNo) != 0){
			   System.out.println(" 삭제 완료 하였습니다.");
		   }else{
			   System.out.println("해당 장바구니가 존재하지 않습니다.");
			   ScanUtil.stop(1000);
		   }
	   }
	   //모두 삭제하기	
	   public static void cartAllDelete(){
		   cartDao.alldelete();
		   System.out.println(" 삭제 완료 하였습니다. ");
	   }
	   
	   // 내정보에서 cart 정보 볼때 사용
	   public int showMycart(){
		   List<Map<String,Object>> cartList = cartDao.selectCartList();
		   showCartList(cartList);
		   
		  return View.CART_LIST;
	   }
	   
}











