package k_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JDBCUtil {

	//싱글톤 패턴 : 인스턴스의 생성을 제한하여 하나의 인스턴스만 사용하는 디자인 패턴
	
	//객체생성을 막기 위한 생성자
/*	private JDBCUtil(){
		
	}*/
	
	JDBCUtil(){
		
	}
	
	//객체를 보관할 변수
	private static JDBCUtil instance;
	
	//객체를 생성해서 빌려주는 메서드
	public static JDBCUtil getInstance(){
		if(instance == null){
			instance = new JDBCUtil();
		}
		return instance;
	}
	
	//디자인패턴 : 클래스를 만드는 양식
	
//	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
//	private String user = "LKH96";
//	private String password = "java";
//	
//	private Connection con = null;
//	private PreparedStatement ps = null;
//	private ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "TOY";
	String password = "java";
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	/*
	 * Map<String, Object> selectOne(String sql)		//조회의 결과가 단일 행
	 * List<Map<String, Object>> selectList(String sql)	//조회의 결과가 다중 행
	 * int update(String sql)							//insert, update, delete를 하면 영향을 받는 행의 수를 리턴
	 */
	
	public List<Map<String, Object>> selectList(String sql){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData();
			
			int columnCount = metaData.getColumnCount();
			
			while(rs.next()){
				HashMap<String, Object> map = new HashMap<String, Object>();
				for(int i = 1; i <= columnCount; i++){
					map.put(metaData.getColumnName(i), rs.getObject(i));
				}
				list.add(map);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}
		
		return list;
	}
	
	public Map<String, Object> selectOne(String sql){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData();
			
			int columnCount = metaData.getColumnCount();
			
			if(rs.next()){
				for(int i = 1; i <= columnCount; i++){
					map.put(metaData.getColumnName(i), rs.getObject(i));
				}
				
			}else{
				map = null;
			}
			
//			rs.next();
//			
//			for(int i = 1; i <= columnCount; i++){
//				map.put(metaData.getColumnName(i), rs.getObject(i));
//			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}
		return map;
	}
	
	public int update(String sql){
		int result = 0;
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}
		return result;
	}
	
}
