
/*
 * showlist : o
 * searchLodge : o
 * lodgeDetail : X
 * addLodge : o
 * getRoomList : o
 * modifyLodge : o
 * deleteLodge : o
 * 
 */


/*
 * 주소 출력시 \t\t추가
 * 숙박시설 종류 출력 \t 삭제
 */

package dao;

import java.util.List;
import java.util.Map;

import controller.Controller;
import service.LodgeService;
import service.MemberService;
import service.RoomService;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;

public class LodgeDao {
	private LodgeDao(){}
	private static LodgeDao instance = null;
	private static JDBCUtil jdbcUtil = JDBCUtil.getInstance();
	
	public static LodgeDao getInstance(){
		if(instance == null){
			instance = new LodgeDao();
		}
		return instance;
	}

	public int showList() {
		String sql = null;
		
		sql = OptionDao.QueriedLodge();
		
		
		List<Map<String, Object>> selectList = jdbcUtil.selectList(sql);
		
		String pavg = null;
		String ravg = null;
		
		if(selectList.size() == 0) {
			System.out.println("해당 조건에 맞는 숙소가 없습니다.");
			ScanUtil.stop(1000);
			return -1;
		}else {
			for(Map<String, Object> walk : selectList){
				pavg = (int)walk.get("PAVG") != -1 ? String.valueOf(walk.get("PAVG")) : "정보없음";
				ravg = (int)walk.get("RAVG") != -1 ? String.valueOf(walk.get("RAVG")) : "정보없음";
				
				System.out.println("숙소번호\t\t:" + "\t\t" + walk.get("LOD_NO"));
				System.out.println("숙소명\t\t:" + "\t\t" + walk.get("LOD_NM"));
				System.out.println("숙박시설종류\t:" + "\t\t" + walk.get("LOD_CODE_NM"));
				System.out.println("주소\t\t:\t\t" + walk.get("LOD_ADD_DETAIL"));				
				System.out.println("평점\t\t:" + "\t\t" + ravg);
				System.out.println("가격\t\t:" + "\t\t" + pavg);
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			}
		}
		return 0;
	}

	public void showOwnList() {
		String sql = null;
		
		sql = "SELECT A.LOD_NO, A.LOD_NM, A.RAVG, A.PAVG,"
				+ "          A.LOD_ADD_DETAIL, C.LOD_DETAIL, A.LOD_CODE_NM "
				+ "     FROM V_LODGE_LIST A, OWNERSHIP B, LODGE C"
				+ "    WHERE A.LOD_NO = C.LOD_NO "
				+ "      AND C.LOD_NO = B.LOD_NO "
				+ "      AND B.MEM_NO = " + MemberService.currentMember.get("MEM_NO")
				+ "      AND C.LOD_ACTIVE = 1";
		List<Map<String, Object>> selectList = jdbcUtil.selectList(sql);
		
		String pavg = null;
		String ravg = null;
		
		if(selectList.size() == 0) {
			System.out.println("현재 등록되있는 숙소가 없습니다.");
			ScanUtil.stop(1000);
		}else {
			for(Map<String, Object> walk : selectList){
				pavg = (int)walk.get("PAVG") != -1 ? String.valueOf(walk.get("PAVG")) : "정보없음";
				ravg = (int)walk.get("RAVG") != -1 ? String.valueOf(walk.get("RAVG")) : "정보없음";
				
				System.out.println("숙소번호\t\t:" + "\t\t" + walk.get("LOD_NO"));
				System.out.println("숙소명\t\t:" + "\t\t" + walk.get("LOD_NM"));
				System.out.println("숙박시설종류\t:" + "\t\t" + walk.get("LOD_CODE_NM"));
				System.out.println("주소\t\t:\t\t" + walk.get("LOD_ADD_DETAIL"));				
				System.out.println("평점\t\t:" + "\t\t" + ravg);
				System.out.println("가격\t\t:" + "\t\t" + pavg);
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			}
		}
		
	}
	
	
	public int selectLodge(Map<String, Object> currentLodge) {
	
		Map<String, Object> printLodge = ConvPrint(currentLodge);
		
		String pavg = null;
		String ravg = null;
		
		if(printLodge == null) {
			System.out.println("해당 숙소가 없습니다.");
			return -1;
		}else {
			
			pavg = (int)printLodge.get("PAVG") != -1 ? String.valueOf(printLodge.get("PAVG")) : "정보없음";
			ravg = (int)printLodge.get("RAVG") != -1 ? String.valueOf(printLodge.get("RAVG")) : "정보없음";
			
			
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");				
				System.out.println("숙소번호\t:" + "\t\t" + printLodge.get("LOD_NO"));
				System.out.println("숙소명\t:" + "\t\t" + printLodge.get("LOD_NM"));
				System.out.println("주소\t:\t\t" + printLodge.get("LOD_ADD_DETAIL"));				
				System.out.println("평점\t:" + "\t\t" + ravg);
				System.out.println("가격\t:" + "\t\t" + pavg);
				System.out.println("인사말\t:" + "\t\t" + printLodge.get("LOD_DETAIL"));
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		}
		return 0;
	}
	
	public Map<String, Object> searchLodge() {
		System.out.print("선택하실 숙소 번호를 선택해 주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = OptionDao.QueriedLodge();
		sql += "   and c.LOD_NO = " + input  ;
		
		
		return jdbcUtil.selectOne(sql);
	}
	
	public Map<String, Object> searchOwnerLodge() {
		System.out.print("선택하실 숙소 번호를 선택해 주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = "SELECT A.LOD_NO, A.LOD_NM, A.LOD_CODE, A.CITY_CODE, "
				+ "			 A.PROV_CODE, A.LOD_ADD_DETAIL, A.LOD_ACTIVE"
				+ "		FROM LODGE A, OWNERSHIP B "
				+ "    WHERE A.LOD_NO = B.LOD_NO"
				+ "      AND B.MEM_NO = " + MemberService.getMemNo()
				+ " 	 AND A.LOD_NO = " + input;
		
		return jdbcUtil.selectOne(sql);
	}
	
	private Map<String, Object> ConvPrint(Map<String, Object> currentLodge) {
		String sql = "SELECT A.LOD_NO, A.LOD_NM, A.RAVG, A.PAVG ,"
				+ "          A.LOD_ADD_DETAIL, C.LOD_DETAIL, A.LOD_CODE_NM "
				+ "     FROM V_LODGE_LIST A, LODGE C"
				+ "    WHERE A.LOD_NO = C.LOD_NO "
				+ "      AND A.LOD_NO = " + LodgeService.getLodgeNo()  
				+ "      AND C.LOD_ACTIVE = 1";
		return jdbcUtil.selectOne(sql);
	}
		
	public int addLodge(){
	      
	      
	      System.out.println("건물명을 입력해주세요.");
	      String lodgeName = ScanUtil.nextLine();
	      String sql = "SELECT A.LOD_NM, A.LOD_ACTIVE FROM LODGE A, OWNERSHIP B WHERE A.LOD_NM = '" + lodgeName + "' "
	            + "      AND B.MEM_NO = " + MemberService.getMemNo();
	   Map<String,Object> actLodge = jdbcUtil.selectOne(sql);
	   if (actLodge == null) {
		   int lodgeCode = 0;
		   int lodgeCityNo = 0;
		   int lodgeProvNo = 0;
		   List<Map<String, Object>> CityProv = null;
		   List<Map<String, Object>> lodgeProv = null;
		   
	      do{
	    	  System.out.println("숙박시설의 카테고리를 선택해주세요.>");
	    	  System.out.println("1.호텔, 2.모텔, 3.펜션, 4.리조트, 5.게스트하우스");
		      lodgeCode = ScanUtil.nextInt();
	      } while(lodgeCode < 0 || lodgeCode > 6);
	      
	      do{
	    	  System.out.println("주소지에서 시에 해당하는 숫자를 입력해주세요");
		      sql = "SELECT * FROM CITY "
		            +     " ORDER BY CITY_CODE   ";
		      CityProv = jdbcUtil.selectList(sql);
		      for (int i = 0; i < CityProv.size(); i++) {
		         System.out.print(CityProv.get(i).get("CITY_CODE") + "." + CityProv.get(i).get("CITY_NM") + "\t");
		         if(i % 3 == 2){
		        	 System.out.println();
		         }
		      }
			  System.out.print(">");
			  lodgeCityNo = ScanUtil.nextInt();
		  } while (lodgeCityNo < 0 || lodgeCityNo > CityProv.size());
	      
		  do{
			  System.out.println("주소지에서 구에 해당하는 숫자를 입력해주세요");
		      sql = "SELECT * FROM PROV "
		            + "    WHERE CITY_CODE = " + lodgeCityNo;
		      lodgeProv = jdbcUtil.selectList(sql);
		      for (int i = 1; i < lodgeProv.size(); i++) {
		    	 
		         System.out.print(lodgeProv.get(i).get("PROV_CODE") + "." + lodgeProv.get(i).get("PROV_NM") + "\t");
		         if(i % 5 == 0){
		        	 System.out.println();
		         }
		      }
		      System.out.print(">");
		      lodgeProvNo = ScanUtil.nextInt();
		  } while (lodgeProvNo < 2 || lodgeProvNo > lodgeProv.size() );
			  
	      System.out.println("주소를 전부 입력해주세요.");
	      String lodgeAddDetail = ScanUtil.nextLine();
	      System.out.println("건물을 소개하는 안내문을 입력해주세요.");
	      String lodgeDetail = ScanUtil.nextLine();
	      
	      sql = "INSERT INTO LODGE VALUES("
	            + " (SELECT MAX(LOD_NO)+1 FROM LODGE)   , "
	            + "     trim('" + lodgeName +             "') , " 
	            + "     " + lodgeCode +             " , " 
	            + "     " + lodgeCityNo +          " , " 
	            + "     " + lodgeProvNo +          " , " 
	            + "     trim('" + lodgeAddDetail +        "') , " 
	            + "     trim('" + lodgeDetail +            "') , "
	            + "      " + 1 +                 ") ";
	      
	      jdbcUtil.update(sql);
	      
	      //소유권 추가
	      sql = "INSERT INTO OWNERSHIP VALUES( "
	      +     " ' " + MemberService.getMemNo()            + " ' , "
	      +     " " + " (SELECT NVL(MAX(LOD_NO),0) FROM LODGE)" + " ) " ;
	      
	      return jdbcUtil.update(sql);
	      
	      } else if ((int)actLodge.get("LOD_ACTIVE") == 0) {
	      System.out.println("해당하는 숙소는 이전에 추가한 이력이 있습니다.");
	      System.out.println("재사용 하시겠습니까? (y/n) >");
	      String input = ScanUtil.nextLine();
	      if (input.equals("y") || input.equals("Y")) {
	         sql = "UPDATE LODGE "
	               + "SET LOD_ACTIVE = 1"
	             + "WHERE LOD_NM = '" + actLodge.get("LOD_NM") + "' ";
	      
	         jdbcUtil.update(sql);
	      
	         System.out.println("복구완료");
	      
	      } else {
	         System.out.println("취소하셨습니다.");
	      }   
	   } else {
	      System.out.println("이미 해당하는 건물이 존재합니다.");
	      }
	      return 0;
	   }
	
	public int modifyLodge(){
		System.out.println("건물명을 입력해주세요.");
		String lodgeName = ScanUtil.nextLine();
		 
		int lodgeCode = 0;
		int lodgeCityNo = 0;
		int lodgeProvNo = 0;
		List<Map<String, Object>> CityProv = null;
		List<Map<String, Object>> lodgeProv = null;
		   
	    do{
	    	  System.out.println("숙박시설의 카테고리를 선택해주세요.>");
	    	  System.out.println("1.호텔, 2.모텔, 3.펜션, 4.리조트, 5.게스트하우스");
		      lodgeCode = ScanUtil.nextInt();
	    } while(lodgeCode < 0 || lodgeCode > 6);
	      
	    do{
	    	  System.out.println("주소지에서 시에 해당하는 숫자를 입력해주세요");
		      String sql = "SELECT * FROM CITY "
		            +     " ORDER BY CITY_CODE   ";
		      CityProv = jdbcUtil.selectList(sql);
		      for (int i = 0; i < CityProv.size(); i++) {
		         System.out.print(CityProv.get(i).get("CITY_CODE") + "." + CityProv.get(i).get("CITY_NM") + "\t");
		         if(i % 3 == 2){
		        	 System.out.println();
		         }
		      }
			  System.out.print(">");
			  lodgeCityNo = ScanUtil.nextInt();
		} while (lodgeCityNo < 0 || lodgeCityNo > CityProv.size());
	      
		do{
			  System.out.println("주소지에서 구에 해당하는 숫자를 입력해주세요");
		      String sql = "SELECT * FROM PROV "
		            + "    WHERE CITY_CODE = " + lodgeCityNo;
		      lodgeProv = jdbcUtil.selectList(sql);
		      for (int i = 1; i < lodgeProv.size(); i++) {
		    	 
		         System.out.print(lodgeProv.get(i).get("PROV_CODE") + "." + lodgeProv.get(i).get("PROV_NM") + "\t");
		         if(i % 5 == 0){
		        	 System.out.println();
		         }
		      }
		      System.out.print(">");
		      lodgeProvNo = ScanUtil.nextInt();
		} while (lodgeProvNo < 2 || lodgeProvNo > lodgeProv.size() );
			  
		System.out.println("주소를 전부 입력해주세요.");
		String lodgeAddDetail = ScanUtil.nextLine();
		System.out.println("건물을 소개하는 안내문을 입력해주세요.");
		String lodgeDetail = ScanUtil.nextLine();
		
		String sql = "UPDATE LODGE "
				+ "   SET   LOD_NM =   ' " + lodgeName +  				 " ' , " 
				+ "  		LOD_CODE = ' " + lodgeCode +  	 	  	     " ' , " 
				+ " 		CITY_CODE =   ' " + lodgeCityNo +   	 " ' , " 
				+ " 		PROV_CODE =   ' " + lodgeProvNo +   	 " ' , " 
				+ "  		LOD_ADD_DETAIL =  ' " + lodgeAddDetail + 	 " ' , " 
				+ "  		LOD_DETAIL =   ' " + lodgeDetail +    		 " '"
				+ "   WHERE LOD_NO = " + LodgeService.getLodgeNo() ;
		
		return jdbcUtil.update(sql);
	}
	
	//활성화테이블
	public int deleteLodge(){
	    
	      String sql = "SELECT LOD_NO, RESV_CODE FROM RESERVATION "
	            + "      WHERE LOD_NO =" + LodgeService.getLodgeNo()
	            + "           AND RESV_CODE = 1";
	      List<Map<String,Object>> actLodge = jdbcUtil.selectList(sql);
	      if (actLodge.size() == 0) {
	         sql = "UPDATE LODGE "
	         +    "    SET LOD_ACTIVE = 0"
	         + "     WHERE LOD_NO = " + LodgeService.getLodgeNo();
	         jdbcUtil.update(sql);
	         System.out.println("삭제되었습니다.");
	      } else {
	         System.out.println("예약이 존재해 삭제할 수 없습니다.");
	         ScanUtil.stop(1000);
	      }
	      
	      return 0;
	   }
	
	public List<Map<String, Object>> getRoomList() {
		List<Map<String, Object>> roomList = null;
		String sql = "select a.ro_no || '호실' as no, '방 종류 : ' || b.ro_code_nm as type, '가격 : ' || ro_n_price as price"
				+ "     from room a, room_code b"
				+ "    where a.ro_code = b.ro_code"
				+ "          and lod_no = " + LodgeService.getLodgeNo()
				+ "          and ro_active = 1"
 				+ "          order by ro_no   " ;
		
		roomList = jdbcUtil.selectList(sql);
		
		for (int i = 0; i < roomList.size(); i++) {
			System.out.println(roomList.get(i).get("NO") + "\t"
					+ 		   roomList.get(i).get("TYPE") + "\t"
					+		   roomList.get(i).get("PRICE")       );
			
		}
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		
		return jdbcUtil.selectList(sql);
	}
	
	public int salesManage(){
	      
	      System.out.println("조회하고싶은 년도를 입력해주세요 >");
	      int year = ScanUtil.nextInt();
	      System.out.println("────────────────────────────");
	      System.out.println(LodgeService.getLodgeName() +  " " + year + "년 월별 매출 ");
	      System.out.println("────────────────────────────");
	      //System.out.println("출력중입니다...");
	      Map<String, Object> result = null;
	      int sum = 0;
	      for (int i = 1; i <= 12; i++) {
	         String sql = "SELECT NVL(SUM(RESV_SUM),0) AS 매출  "
	               + " FROM RESERVATION "
	               + " WHERE NVL(EXTRACT(MONTH FROM RESV_SDATE),0) = " + i
	               + "   AND LOD_NO = " + LodgeService.getLodgeNo()
	               + "   AND NVL(EXTRACT(YEAR FROM RESV_SDATE),0) = " + year;
	         result = jdbcUtil.selectOne(sql);
	         System.out.println(i + "월 매출합계\t: \t" + result.get("매출") + "원");
	         sum += (int)result.get("매출");
	      }
	      System.out.println("────────────────────────────");
	      System.out.println("총 매출합계\t: \t" + sum + "원");
	      System.out.println("────────────────────────────");
	      System.out.println("0.돌아가기 >");
	      int input = ScanUtil.nextInt();
	      switch (input) {
	      case 0:
	         return View.LODGE_MANAGE;
	      }
	      return View.LODGE_MANAGE;
	   }
	
}
	