package k_jdbc;

import java.util.List;
import java.util.Map;

public class ToyBoard {

	public static void main(String[] args) {
		
//		MakeQuery instance = MakeQuery.getInstance();
		
//		instance.update("delete toystudent");
		
//		Map<String, Object> map = instance.selectOne("select * from toystudent");
//		List<Map<String, Object>> list = instance.selectList(
//				"select stud_id, stud_name, kor, eng, math, society, science, java, oracle,"
//				+ " kor + eng + math + society + science + java + oracle as tsum,"
//				+ " round((kor + eng + math + society + science + java + oracle) / 7, 2) as tavg, rank"
//				+ " from TOYSTUDENT"
//				+ " order by rank");
//		
//		if(map == null){
//			instance.addToTable();
//			instance.getRank();
//		}
//		
//		System.out.println("학번\t이름\t국어\t영어\t수학\t사회\t과학\tJAVA\tORACLE\t합계\t평균\t석차");
//		instance.printAll(list);
//		
//		instance.printSubSum(instance.getSubSum());
//		instance.printSubAvg(instance.getSubAvg());
		
		String convQuery = null;
		
		System.out.println(("CITY") == null);
		
		convQuery += ("CITY") != null? (" and city_code = " + ("CITY")) : null;
		System.out.println(convQuery);
		convQuery += ("PROV") != null? (" and prov_code = " + ("PROV")) : null;
		System.out.println(convQuery);
		convQuery += ("RATING") != null? (" and pavg >= " + ("RATING")) : null;
		System.out.println(convQuery);
		convQuery += ("MIN_PRICE") != null? (" and ro_price >= " + ("MIN_PRICE")) : null;
		System.out.println(convQuery);
		convQuery += ("MAX_PRICE") != null? (" and ro_price <= " + ("MAX_PRICE")) : null;
		System.out.println(convQuery);
		convQuery += ("SDATE") != null? (" and city_code = " + ("SDATE")) : null;
		System.out.println(convQuery);
		convQuery += ("EDATE") != null? (" and city_code = " + ("EDATE")) : null;
		System.out.println(convQuery);
//		convQuery += ("CITY") == null? (" and city_code = " + ("CITY")) : null;
//		convQuery += " and prov_code = " + ("PROV");
//		convQuery += " and  = " + ("CAPACITY");
//		convQuery += " and pavg >= " + ("RATING");
//		convQuery += " and ro_price >= " + ("MIN_PRICE");
//		convQuery += " and ro_prive <= " + ("MAX_PRICE");
//		convQuery += " and  = " + ("SDATE");
//		convQuery += " and city_code = " + ("EDATE");
		
		
		
	}
	
	

}
