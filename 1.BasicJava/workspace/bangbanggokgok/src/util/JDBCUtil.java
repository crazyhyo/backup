/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	JDBCUtil.java
 * Revision			:	0.1
 * Date				:	2021.08.12
 * Author			:	Lee KwangHyo
 * 
 */

package util;

import java.math.BigDecimal;
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
	private JDBCUtil(){
		
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
	
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "bangbanggokgok";
	private String password = "java";
	
	private Connection con = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	/*
	 * Map<String, Object> selectOne(String sql)
	 * List<Map<String, Object>> selectList(String sql)
	 * int update(String sql)
	 */
	
	public Map<String, Object> selectOne(String sql){
		Map<String, Object> map = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData();
			
			int columnCount = metaData.getColumnCount();
			
			if(rs.next()){
				map = new HashMap<>();
				for(int i = 1; i <= columnCount; i++){
					map.put(metaData.getColumnName(i), convertValue(rs.getObject(i)));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(ps != null) try { ps.close(); } catch(Exception e) {}
			if(con != null) try { con.close(); } catch(Exception e) {}
		}
		
		return map;
	}
	
	public List<Map<String, Object>> selectList(String sql){
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData();
			
			int columnCount = metaData.getColumnCount();
			
			while(rs.next()){
				HashMap<String, Object> map = new HashMap<>();
				for(int i = 1; i <= columnCount; i++){
					map.put(metaData.getColumnName(i), convertValue(rs.getObject(i)));
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(ps != null) try { ps.close(); } catch(Exception e) {}
			if(con != null) try { con.close(); } catch(Exception e) {}
		}
		
		return list;
	}
	
	public int update(String sql){
		int result = 0;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(ps != null) try { ps.close(); } catch(Exception e) {}
			if(con != null) try { con.close(); } catch(Exception e) {}
		}
		
		return result;
	}
	
	Object convertValue(Object value){
		if(value instanceof BigDecimal){
			value = ((BigDecimal)value).intValue();
		}
		
		return value;
	}
	
	public List<Object> selectRawData(String sql){
		List<Object> list = new ArrayList<>();
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			list.add(rs);
			ResultSetMetaData metaData = rs.getMetaData();
			list.add(metaData);
			int columnCount = metaData.getColumnCount();
			list.add(columnCount);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {}
			if(ps != null) try { ps.close(); } catch(Exception e) {}
			if(con != null) try { con.close(); } catch(Exception e) {}
		}
		
		return list;
	}
	
}
