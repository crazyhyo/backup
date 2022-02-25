package dao;

import java.util.Map;

import service.MemberService;
import util.JDBCUtil;
import util.ScanUtil;


public class MemberDao {

	private MemberDao(){}
	private static MemberDao instance;
	public static MemberDao getInstance(){
		if(instance == null){
			instance = new MemberDao();
		}
		return instance;
	}
	
	private static JDBCUtil jdbc =  JDBCUtil.getInstance();
		
	public int checkDoubleId(Object mem_id){
		
		String sql = "SELECT * FROM MEMBER WHERE MEM_ID = '" + mem_id + "'";
		
		return jdbc.update(sql);
	}
	
	public int insertMem(Map<String, Object> temp, int mem_code){
		
		String sql = "INSERT INTO MEMBER VALUES("
				+ "(SELECT NVL(MAX(MEM_NO)+1,0) FROM MEMBER),"
				+ "'" + temp.get("MEM_ID") + "',"
				+ "'" + temp.get("MEM_PW") + "',"
				+ "'" + temp.get("MEM_NM") + "',"
				+ "'" + temp.get("MEM_TEL") + "',"
				+ "'" + temp.get("MEM_EMAIL") + "',"
				+ "'" + mem_code + "',"
				+ "'" + 1 + "')";
		
		return jdbc.update(sql);
	}
	
	public Map<String, Object> insertNon(String mem_nm, String mem_tel){
		
		String sql = "INSERT INTO MEMBER(MEM_NM,MEM_TEL,MEM_CODE,MEM_ACTIVE)"
				+ " VALUES("
				+ "'" + mem_nm + "',"
				+ "'" + mem_tel + "',"
				+ "3, 1)";
		
		return jdbc.selectOne(sql);
	}
	
	public Map<String, Object> selectMem(String m_id, String m_pw){
		String sql = "SELECT MEM_NO, MEM_ID, MEM_PW, MEM_NM, MEM_EMAIL, MEM_TEL, MEM_CODE, MEM_ACTIVE"
				+ " FROM MEMBER"
				+ " WHERE MEM_ID = " + "'" + m_id + "'"
				+ " AND MEM_PW = " + "'" + m_pw + "'";
		
		return jdbc.selectOne(sql);
	}
	
	public Map<String, Object> selectResH_Non(String mem_tel){
	
	String sql = "SELECT  A.RESV_NO, A.ORD_NO, A.LOD_NO, A.RO_NO,"
			+ "A.RESV_SDATE, A.RESV_EDATE, A.RESV_CODE, A.RESV_CAP, A.RESV_SUM, B.ORD_DATE"
			+ " FROM RESERVATION A, TBL_ORDER B ,"
			+ "(SELECT MEM_NO FROM MEMBER WHERE MEM_TEL = "
			+ "'" + mem_tel + "') C"
			+ " WHERE A.ORD_NO = B.ORD_NO"
			+ " AND B.MEM_NO = C.MEM_NO";
	
	return jdbc.selectOne(sql);
}
	
	public int valid_mem(String mem_tel){
		String sql = "SELECT * FROM MEMBER "
				+ " WHERE MEM_TEL = " + "'" + mem_tel + "'"
				+ " AND MEM_CODE = 1";
		
		return jdbc.update(sql);
	}
	
	public Map<String, Object> updateInfo(String mem_pw, String mem_tel, String mem_email){
	      
	      String sql = "UPDATE MEMBER SET"
	            + " MEM_PW = " + "'" + mem_pw + "',"
	            + " MEM_TEL = " + "'" + mem_tel + "',"
	            + " MEM_EMAIL = " + "'" + mem_email + "'"
	            + " WHERE MEM_NO = " + MemberService.getMemNo();
	      jdbc.update(sql);
	      sql = "SELECT * FROM MEMBER WHERE MEM_NO = " + MemberService.currentMember.get("MEM_NO");
	      return jdbc.selectOne(sql);
	   }
	
	public Map<String, Object> searchPw(String mem_id, String mem_email){
		
		String sql = "SELECT MEM_PW FROM MEMBER"
				+ " WHERE MEM_ID = " + "'" + mem_id + "'"
				+ " AND MEM_EMAIL = " + "'" + mem_email + "'";
		
		return jdbc.selectOne(sql);
	}

	public int deleteMem() {
		
		String sql = "UPDATE MEMBER SET MEM_ACTIVE = " + 0
				+ " WHERE MEM_NO = "
				+ MemberService.currentMember.get("MEM_NO");
		
		return jdbc.update(sql);
	}

	public static Map<String, Object> guestPayment() {
		String tel = null;
		String name = null;
		System.out.print("이름을 입력해주세요>");
		name = ScanUtil.nextLine(); 
		System.out.print("전화번호를 입력해주세요>");
		tel = ScanUtil.nextLine(); 
		int no = 0;
		int result = 0;
		
		String sql = null;
		
		sql = "select nvl(max(mem_no) + 1 ,0) as no from member";
		
		no = (int)jdbc.selectOne(sql).get("NO");
		
		sql = "insert into member(mem_no, mem_code, mem_active, mem_nm, mem_tel) "
				+ "   values( " + no + ", 3, 1, '" + name + "', '" + tel + "') ";
		
		result = jdbc.update(sql);
		
		if(result == 0) {
			System.out.println("비회원 결제에 실패했습니다.");
			return null;
		}else {
			sql = "select * from member where mem_no = " + no;
			
			Map<String, Object> insertMember = jdbc.selectOne(sql);
			
			return insertMember;
		}
	}
	
}
