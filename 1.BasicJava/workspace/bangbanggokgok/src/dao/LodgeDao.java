/*
 * public static LodgeDao getInstance() : O
 * public void showList(Map<String, Object> constraint) : X
 * public Map<String, Object> searchLodge() : O
 * public List<Map<String, Object>> getRoomList() : O
 * 
 * Lee KwangHyo
 * 
 */

package dao;

import java.util.List;
import java.util.Map;

import service.LodgeService;
import service.OptionService;
import util.JDBCUtil;
import util.ScanUtil;

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

	public void showList(Map<String, Object> constraint) {
		String sql = null;
		if((int)MemberService.currentMember.get("MEM_CODE") != 2){
		sql = "SELECT A.LOD_NO as 숙소번호, A.LOD_NM as 숙소명, A.RAVG as 평점, A.PAVG as 가격,"
				+ "          A.LOD_ADD_DETAIL AS 주소, C.LOD_DETAIL AS 건물상세, A.LOD_CODE_NM AS 숙박시설종류 "
				+ "     FROM V_LODGE_LIST A, LODGE C"
				+ "    WHERE A.LOD_NO = C.LOD_NO" ;
		}else{
			
			sql = "SELECT A.LOD_NO as 숙소번호, A.LOD_NM as 숙소명, A.RAVG as 평점, A.PAVG as 가격,"
					+ "          A.LOD_ADD_DETAIL AS 주소, C.LOD_DETAIL AS 건물상세, A.LOD_CODE_NM AS 숙박시설종류 "
					+ "     FROM V_LODGE_LIST A, OWNERSHIP B, LODGE C"
					+ "    WHERE A.LOD_NO = C.LOD_NO "
					+ "      AND C.LOD_NO = B.LOD_NO "
					+ "      AND B.MEM_NO = " + MemberService.currentMember.get("MEM_NO") ;
		}
		
		
		List<Map<String, Object>> selectList = jdbcUtil.selectList(sql);
		
		if(selectList.size() == 0) {
			System.out.println("해당 테이블의 레코드가 없습니다.");
		}else {
			for(Map<String, Object> walk : selectList){
				System.out.println("숙소번호 :" + "\t\t" + walk.get("숙소번호"));
				System.out.println("숙소명 :" + "\t\t" + walk.get("숙소명"));
				System.out.println("숙박시설종류 :" + "\t\t" + walk.get("숙박시설종류"));
				System.out.println(walk.get("주소"));				
				System.out.println("평점 :" + "\t\t" + walk.get("평점"));
				System.out.println("가격 :" + "\t\t" + walk.get("가격"));
				System.out.println("-------------------------------------------------");
			}
		}
		
	}

	public void lodgeDetail(Map<String, Object> currentLodge) {
	
		
		if(currentLodge.size() == 0) {
			System.out.println("해당 테이블의 레코드가 없습니다.");
		}else {

				System.out.println("숙소번호 :" + "\t\t\t" + currentLodge.get("숙소번호"));
				System.out.println("숙소명 :" + "\t\t\t" + currentLodge.get("숙소명"));
				System.out.println(currentLodge.get("주소"));
				System.out.println("평점 :" + "\t\t\t" + currentLodge.get("평점"));
				System.out.println("인사말 :" + "\t\t\t" + currentLodge.get("건물상세"));
				System.out.println("-------------------------------------------------");
		}
		
	}
	
	public Map<String, Object> searchLodge() {
		System.out.print("선택하실 숙소 번호를 선택해 주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = null;
		if((int)MemberService.currentMember.get("MEM_CODE") != 2){
		sql = "SELECT A.LOD_NO as 숙소번호, A.LOD_NM as 숙소명, A.RAVG as 평점, A.PAVG as 가격,"
				+ "          A.LOD_ADD_DETAIL AS 주소, C.LOD_DETAIL AS 건물상세, A.LOD_CODE_NM AS 숙박시설종류 "
				+ "     FROM V_LODGE_LIST A, LODGE C"
				+ "    WHERE A.LOD_NO = C.LOD_NO "
				+ "      AND A.LOD_NO = " + input  ;
		}else{
			
			sql = "SELECT A.LOD_NO as 숙소번호, A.LOD_NM as 숙소명, A.RAVG as 평점, A.PAVG as 가격,"
					+ "          A.LOD_ADD_DETAIL AS 주소, C.LOD_DETAIL AS 건물상세, A.LOD_CODE_NM AS 숙박시설종류 "
					+ "     FROM V_LODGE_LIST A, OWNERSHIP B, LODGE C"
					+ "    WHERE A.LOD_NO = C.LOD_NO "
					+ "      AND C.LOD_NO = B.LOD_NO "
					+ "      AND B.MEM_NO = " + MemberService.currentMember.get("MEM_NO")
					+ "      and A.LOD_NO = " + input ;
		}
		
		return jdbcUtil.selectOne(sql);
	}
	
	public int addLodge(){
		System.out.println("건물명을 입력해주세요.");
		String lodgeName = ScanUtil.nextLine();
		System.out.println("숙박시설의 카테고리를 선택해주세요.>");
		System.out.println("1.호텔, 2.모텔, 3.펜션, 4.리조트, 5.게스트하우스");
		int lodgeCode = ScanUtil.nextInt();
		System.out.println("주소지에서 시에 해당하는 숫자를 입력해주세요");
		String sql = "SELECT * FROM CITY "
				+ 	 " ORDER BY CITY_CODE	";
		List<Map<String, Object>> CityProv = jdbcUtil.selectList(sql);
		for (int i = 0; i <= CityProv.size(); i++) {
			System.out.print(CityProv.get(i).get("CITY_CODE") + "." + CityProv.get(i).get("CITY_NM") + "\t");
		}
		System.out.print(">");
		int lodgeCityNo = ScanUtil.nextInt();
		System.out.println("주소지에서 구에 해당하는 숫자를 입력해주세요");
		sql = "SELECT * FROM PROV "
				+ "    WHERE CITY_CODE = " + lodgeCityNo;
		List<Map<String, Object>> lodgeProv = jdbcUtil.selectList(sql);
		for (int i = 1; i < lodgeProv.size(); i++) {
			System.out.print(lodgeProv.get(i).get("PROV_CODE") + "." + lodgeProv.get(i).get("PROV_NM") + "\t");
		}
		System.out.print(">");
		int lodgeProvNo = ScanUtil.nextInt();
		System.out.println("주소를 전부 입력해주세요.");
		String lodgeAddDetail = ScanUtil.nextLine();
		System.out.println("건물을 소개하는 안내문을 입력해주세요.");
		String lodgeDetail = ScanUtil.nextLine();
		
		sql = "INSERT INTO LODGE VALUES("
				+ " (SELECT MAX(LOD_NO)+1 FROM LODGE)   , "
				+ "     ' " + lodgeName +  	 	    " ' , " 
				+ "     ' " + lodgeCode +  	 	    " ' , " 
				+ "     ' " + lodgeCityNo +   	    " ' , " 
				+ "     ' " + lodgeProvNo +   	    " ' , " 
				+ "     ' " + lodgeAddDetail + 	    " ' , " 
				+ "     ' " + lodgeDetail +    	     " ' )";
		
		jdbcUtil.update(sql);
		
		//소유권 추가
		sql = "INSERT INTO OWNERSHIP VALUES( "
		+     " ' " + MemberService.currentMember.get("MEM_NO")            + " ' , "
		+     " " + " (SELECT NVL(MAX(LOD_NO),0) FROM LODGE)" + " ) " ;
		
		return jdbcUtil.update(sql);
	}
	
	public int modifyLodge(){
		System.out.println("건물명을 입력해주세요.");
		String lodgeName = ScanUtil.nextLine();
		System.out.println("숙박시설의 카테고리를 선택해주세요.>");
		System.out.println("1.호텔, 2.모텔, 3.펜션, 4.리조트, 5.게스트하우스");
		int lodgeCode = ScanUtil.nextInt();
		System.out.println("주소지에서 시에 해당하는 숫자를 입력해주세요");
		String sql = "SELECT * FROM CITY ";
		List<Map<String, Object>> CityProv = jdbcUtil.selectList(sql);
		for (int i = 0; i < CityProv.size(); i++) {
			System.out.print(CityProv.get(i).get("CITY_CODE") + "." + CityProv.get(i).get("CITY_NM") + "\t");
		}
		System.out.print(">");
		int lodgeCityNo = ScanUtil.nextInt();
		System.out.println("주소지에서 구에 해당하는 숫자를 입력해주세요");
		sql = "SELECT * FROM PROV "
				+ "    WHERE CITY_CODE = " + lodgeCityNo;
		List<Map<String, Object>> lodgeProv = jdbcUtil.selectList(sql);
		for (int i = 1; i < lodgeProv.size(); i++) {
			System.out.print(lodgeProv.get(i).get("PROV_CODE") + "." + lodgeProv.get(i).get("PROV_NM") + "\t");
		}
		System.out.print(">");
		int lodgeProvNo = ScanUtil.nextInt();
		System.out.println("주소를 전부 입력해주세요.");
		String lodgeAddDetail = ScanUtil.nextLine();
		System.out.println("건물을 소개하는 안내문을 입력해주세요.");
		String lodgeDetail = ScanUtil.nextLine();
		
		sql = "UPDATE LODGE "
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
		
		String sql = "UPDATE LODGE "
				+    "	 SET LOD_ACTIVE = 0 ";

		System.out.println("삭제되었습니다.");
		return jdbcUtil.update(sql);
	}
	
	public List<Map<String, Object>> getRoomList() {
		List<Map<String, Object>> roomList = null;
		String sql = "select a.ro_no || '호실' as no, '방 종류 : ' || b.ro_code_nm as type, '가격 : ' || ro_n_price as price"
				+ "     from room a, room_code b"
				+ "    where a.ro_code = b.ro_code"
				+ "          and lod_no = " + LodgeService.getLodgeNo();
		
		roomList = jdbcUtil.selectList(sql);
		
		for (int i = 0; i < roomList.size(); i++) {
			System.out.println(roomList.get(i).get("NO") + "\t"
					+ 		   roomList.get(i).get("TYPE") + "\t"
					+		   roomList.get(i).get("PRICE")       );
			
		}
		System.out.println("-------------------------------");
		
		return jdbcUtil.selectList(sql);
	}
	
	
	
}
