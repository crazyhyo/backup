package dao;

import java.util.List;
import java.util.Map;

import service.MemberService;
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

	public static String QueriedLodge(){
		String sql;
		sql = "select a.lod_no, a.lod_nm , a.ravg , a.pavg ,"
				+ "          a.lod_add_detail , c.lod_detail , a.lod_code_nm "
				+ "     from v_lodge_list a, lodge c"
				+ "    where a.lod_no = c.lod_no"
				+ "      AND c.LOD_ACTIVE = 1 ";
		if(lodgeQuery == null){
			
		}else{
			sql += lodgeQuery;
			
			}	
		return sql;
			
	}
	
	public static void convertQuery(Map<String, Object> option) {
		
		lodgeQuery = "";
		
		lodgeQuery += option.get("CITY") 		!= null? " and a.city = " + option.get("CITY") : "";

		//NULL POINTER ERROR 고치기
		if(option.get("PROV") == null){
			
		}else if((int)option.get("PROV") != 1){
			lodgeQuery += option.get("PROV") 		!= null? " and a.prov = " + option.get("PROV") : "";
		}
		lodgeQuery += option.get("RATING") 		!= null? " and a.ravg >= " + option.get("RATING") : "";
		lodgeQuery += option.get("MIN_PRICE") 	!= null? " and a.pavg >= " + option.get("MIN_PRICE") : "";
		lodgeQuery += option.get("MAX_PRICE") 	!= null? " and a.pavg <= " + option.get("MAX_PRICE") : "";
		lodgeQuery += option.get("TYPE")		!= null? " and a.lcode = " + option.get("TYPE") : "";
	}

}
