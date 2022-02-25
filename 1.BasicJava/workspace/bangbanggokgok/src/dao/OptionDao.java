package dao;

import java.util.List;
import java.util.Map;

import util.JDBCUtil;

public class OptionDao {

	
	private OptionDao() {
	}

	private static OptionDao instance;

	public static OptionDao getInstance() {
		if (instance == null) {
			instance = new OptionDao();
		}
		return instance;
	}
	
	private static JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public static String lodgeQuery = new String();
	public static String roomQuery = new String();
	
	
	public List<Map<String, Object>> cityList() {
		String sql = null;
		
		sql = "select city_code, city_nm"
			+ "  from city";
		
		return jdbc.selectList(sql);
	}

	public List<Map<String, Object>> provList(int input) {
		String sql = null;
		
		sql = "select prov_code, prov_nm"
			+ "  from prov"
			+ " where city_code = " + input;
		
		return jdbc.selectList(sql);
	}

	public static void convertQuery(Map<String, Object> option) {
		
		lodgeQuery = "";
		roomQuery = "";
		
		lodgeQuery += option.get("CITY") 		!= null? " and b.city_code = " + option.get("CITY") : "";
		lodgeQuery += option.get("PROV") 		!= null? " and b.prov_code = " + option.get("PROV") : "";
		roomQuery += option.get("CAPACITY") 	!= null? " and " + option.get("CAPACITY") + " between c.ro_min_cap and c.ro_max_cap"+"" : "";
		lodgeQuery += option.get("RATING") 		!= null? " and a.pavg >= " + option.get("RATING") : "";
		roomQuery += option.get("MIN_PRICE") 	!= null? " and c.ro_n_price >= " + option.get("MIN_PRICE") : "";
		roomQuery += option.get("MAX_PRICE") 	!= null? " and c.ro_n_price <= " + option.get("MAX_PRICE") : "";
		
	}

}
