package k_jdbc;

import java.util.List;
import java.util.Map;

public class JDBCTest {

	public static void main(String[] args) {
		
		JDBCUtil jdbc = JDBCUtil.getInstance();
		
		List<Map<String, Object>> list = jdbc.selectList("select cart_qty from cart where cart_qty > 6");
		Map<String, Object> map = jdbc.selectOne("select cart_member from cart where cart_qty > 6");
		
		int test = jdbc.update("delete cart where cart_qty > 6");
		
		System.out.println(list);
		System.out.println(map);
		System.out.println(test);
		
	}

}
