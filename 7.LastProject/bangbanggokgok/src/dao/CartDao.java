package dao;

import java.util.List;
import java.util.Map;

import service.LodgeService;
import service.OptionService;
import service.RoomService;
import util.JDBCUtil;
/*
 * selectCartList
 * selectOne
 * 
 */
public class CartDao {
	
	   //싱글톤 패턴	
 	   private CartDao(){}
	   private static CartDao instance;
	   public static CartDao getInstance(){
		   if(instance == null){
			   instance = new CartDao();
		   }
		   return instance;
}
	   //장바구니 목록 (전체)
	   private static JDBCUtil jdbc = JDBCUtil.getInstance();
	   
	   public static List<Map<String,Object>> selectCartList(){
		   String sql = "SELECT * FROM CART";
		
		   return jdbc.selectList(sql);
	   }
	   
	   //장바구니 목록에서 1가지만 선택 할때(결제 단계 전)
	   //CART_DETAIL에 해당하는 부분, 사용은 안할 예정이나 일단 구현 해놓음
	   public Map<String,Object> selectCartOne(){
		   String sql = "SELECT CART_NO, LOD_NM, LOD_ADD_CITY, LOD_ADD_PROV, "
		   		+ "LOD_ADD_DETAIL, LOD_NO, RO_NO, RO_CODE_NM, RO_CIN, RO_COUT, RESV_SDATE, "
		   		+ "RESV_EDATE, RESV_CAP, RESV_SUM"
		   		+ "		   FROM CART"
		   		+ "		   ORDER BY 1 DESC";
		   
		   return jdbc.selectOne(sql);
	   }

	public static int delete(int cartNo) {
		String sql = "DELETE FROM CART"
	  		+ "		 WHERE CART_NO =  " + cartNo;
		return jdbc.update(sql);
	}

	public static int alldelete() {
		String sql = "DELETE FROM CART";
		return jdbc.update(sql);
	}

	public static Map<String, Object> insertCart() {
		
		String sql = null;
		
		sql = "select nvl(max(cart_no) + 1, 1) as no from cart";
		
		int no = 1;
		
		no = (int)jdbc.selectOne(sql).get("NO");
		
		Map<String, Object> tmpCart = null;
		
		sql = "insert into cart(CART_NO, LOD_NO, RO_NO, LOD_NM, CITY_CODE, PROV_CODE"
				+ ", LOD_ADD_DETAIL, RO_CODE_NM, RO_CIN, RO_COUT, RESV_SDATE, RESV_EDATE"
				+ ", RESV_CAP, RESV_SUM) "
				+ "select " +  no + ", b.lod_no, c.ro_no, b.lod_nm, b.city_code, b.prov_code"
				+ ", b.lod_add_detail, d.ro_code_nm, c.ro_cin, c.ro_cout"
				+ ", to_date('" + OptionService.getSdate() + "'), to_date('" + OptionService.getEdate() + "')"
				+ ", " + OptionService.getCap() + ", " + OptionService.getSum()
				+ " from lodge b, room c, room_code d"
				+ " where b.lod_no = c.lod_no"
				+ "       and c.ro_code = d.ro_code"
				+ "       and b.lod_no = " + LodgeService.getLodgeNo()
				+ "       and c.ro_no = " + RoomService.getRoomNo();
		
		int result = 0;
		
		result = jdbc.update(sql);
		
		if(result != 0){
			sql = "select * from cart where cart_no = " + no;
			
			tmpCart = jdbc.selectOne(sql);
			
			return tmpCart;
			
		}else{
			return null;
		}
	}
}
