package dao;

import java.util.List;
import java.util.Map;

import service.CartService;
import service.LodgeService;
import service.MemberService;
import service.RoomService;
import util.JDBCUtil;
import controller.Controller;

public class OrderDao {
	//싱글톤 패턴
	private OrderDao(){}
	private static OrderDao instance;
	public static OrderDao getInstace(){
		if(instance == null){
			instance = new OrderDao();
		}
		return instance;
	}
	
	private static JDBCUtil jdbc = JDBCUtil.getInstance();
	
	private static int ordNo = 0;
	
	public static void InsertResvOne() {
		String sql = null; 
		int resvNo = 0;
		int currCartNo = 0;
		
		sql = "SELECT nvl(MAX(ORD_NO),1) as no FROM TBL_ORDER";
		 
		ordNo = (int)jdbc.selectOne(sql).get("NO");
		
		sql = "select nvl(max(resv_no) + 1, 1) as no from reservation";
		
		resvNo = (int)jdbc.selectOne(sql).get("NO");
		
		currCartNo = (int)CartService.currentCart.get("CART_NO");
		
		sql = "INSERT INTO RESERVATION(RESV_NO, ORD_NO, LOD_NO, RO_NO"
				+ ", RESV_SDATE, RESV_EDATE, RESV_CODE, RESV_CAP, RESV_SUM)"
				+ " SELECT " + resvNo + ", " + ordNo + ", lod_no, ro_no, resv_sdate, resv_edate, " + 1
				+ ", resv_cap, resv_sum"
				+ "  FROM CART"
				+ " where cart_no = " + currCartNo;
		
		int result = 0;
		
		result = jdbc.update(sql);
		
		if(result == 0){
			System.out.println("예약추가에 실패했습니다.");
		}else{
			System.out.println("예약이 추가되었습니다.");
		}
		
	}

	public static void InsertOrderOne() {
		String sql = null;
		
		sql = "SELECT nvl(MAX(ORD_NO)+1,1) as no FROM TBL_ORDER";
		 
		ordNo = (int)jdbc.selectOne(sql).get("NO");
		 
		sql = "INSERT INTO TBL_ORDER(ORD_NO, MEM_NO, ORD_PRICE, ORD_DATE)"
		 		+ "    VALUES( " + ordNo + "," + MemberService.currentMember.get("MEM_NO")
		 		+ ", " + CartService.currentCart.get("RESV_SUM") 
		 		+ ", " + "TO_DATE('" + Controller.currentDate + "'))";
		
		int result = 0;
		result = jdbc.update(sql);
		if(result == 0){
			System.out.println("주문추가에 실패했습니다.");
		}else{
			System.out.println("주문이 추가되었습니다.");
			InsertResvOne();
		}
		
		sql = "delete cart where cart_no = (select max(cart_no) from cart)";
		
		jdbc.update(sql);
		
	}

	public static void InsertOrderCart(List<Map<String, Object>> cartList) {
		String sql = null;
		int sum = showSum();
		int ordNo = 0;
		
		sql = "SELECT MAX(ORD_NO)+1 as no FROM TBL_ORDER";
		 
		ordNo = (int)jdbc.selectOne(sql).get("NO");
		
		sql = "INSERT INTO TBL_ORDER(ORD_NO, MEM_NO, ORD_PRICE, ORD_DATE)"
		 		+ "    VALUES( " + ordNo + "," + MemberService.currentMember.get("MEM_NO")
		 		+ ", " + sum
		 		+ ", " + "TO_DATE('" + Controller.currentDate + "'))";
		
		int result = 0;
		result = jdbc.update(sql);
		if(result == 0){
			System.out.println("주문추가에 실패했습니다.");
		}else{
			System.out.println("주문이 추가되었습니다.");
			insertResvCart(cartList);
		}
		
	}

	private static void insertResvCart(List<Map<String, Object>> cartList) {
		String sql = null; 
		int resvNo = 0;
		int currCartNo = 0;
		
		sql = "SELECT MAX(ORD_NO) as no FROM TBL_ORDER";
		 
		ordNo = (int)jdbc.selectOne(sql).get("NO");
		
		for(Map<String, Object> walk : cartList){
			
			sql = "select nvl(max(resv_no) + 1, 0) as no from reservation";
			
			resvNo = (int)jdbc.selectOne(sql).get("NO");
			
			currCartNo = (int)walk.get("CART_NO");
			
			sql = "INSERT INTO RESERVATION(RESV_NO, ORD_NO, LOD_NO, RO_NO"
					+ ", RESV_SDATE, RESV_EDATE, RESV_CODE, RESV_CAP, RESV_SUM)"
					+ " SELECT " + resvNo + ", " + ordNo + ", lod_no, ro_no, resv_sdate, resv_edate, " + 1
					+ ", resv_cap, resv_sum"
					+ "  FROM CART"
					+ " where cart_no = " + currCartNo;
			
			int result = 0;
			
			result = jdbc.update(sql);
			
			if(result == 0){
				System.out.println("예약추가에 실패했습니다.");
			}else{
				System.out.println("예약이 추가되었습니다.");
			}
		}
		
	}

	public static int showSum() {
		String sql = null;
		
		sql = "select nvl(sum(resv_sum), 0) as sum from cart";
		
		int sum = (int)jdbc.selectOne(sql).get("SUM");
		
		System.out.println("장바구니 총 구매금액은 " + sum + "원 입니다.");
		
		return sum;
	}
	
}
