package kr.or.ddit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

public class MyJDBCUtil {
	private static ResourceBundle bundle;
	private static Connection conn;
	private static Statement stmt;
	private static PreparedStatement pstmt;
	private static ResultSet rs;
	private static ResultSetMetaData metaData;
	private static MyJDBCUtil instance;
	
	private MyJDBCUtil() {}
	
	public static MyJDBCUtil getInstance() {
		if(instance == null) {
			instance = new MyJDBCUtil();
		}
		return instance;
	}
	
	static {
		bundle = ResourceBundle.getBundle("db");
		try {
			Class.forName(bundle.getString("driver"));
			System.out.println("드라이버 로딩 완료");
		} catch (ClassNotFoundException e1) {
			System.out.println("드라이버 로딩 실패");
			e1.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		try {
			conn = DriverManager.getConnection(
					bundle.getString("url"),
					bundle.getString("user"),
					bundle.getString("pass"));
			System.out.println("DB연결 성공");
		} catch (SQLException e) {
			System.out.println("DB연결 실패");
			e.printStackTrace();
		}
		
		return conn;
	}
	
	private static void disConnect(
			Connection conn,
			Statement stmt,
			PreparedStatement pstmt,
			ResultSet rs) {
		if(rs != null)	try { rs.close(); } catch(SQLException ex) {}
		if(stmt != null)	try { stmt.close(); } catch(SQLException ex) {}
		if(pstmt != null)	try { pstmt.close(); } catch(SQLException ex) {}
		if(conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
	
	public static List<Map<String, Object>> selectList(String sql){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			conn = DriverManager.getConnection(
					bundle.getString("url"),
					bundle.getString("user"),
					bundle.getString("pass"));
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			metaData = rs.getMetaData();
			
			int count = metaData.getColumnCount();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				for(int i = 1; i <= count; i++) {
					map.put(metaData.getColumnName(i), rs.getObject(i));
				}
				list.add(map);
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			disConnect(conn, stmt, pstmt, rs);
		}
		return list;
	}
	
	public static Map<String, Object> selectOne(String sql){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			conn = DriverManager.getConnection(
					bundle.getString("url"),
					bundle.getString("user"),
					bundle.getString("pass"));
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			metaData = rs.getMetaData();
			
			int count = metaData.getColumnCount();
			
			for(int i = 1; i <= count; i++) {
				map.put(metaData.getColumnName(i), rs.getObject(i));
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			disConnect(conn, stmt, pstmt, rs);
		}
		
		return map;
	}
	
	public static int update(String sql) {
		int cnt = -1;
		try {
			conn = DriverManager.getConnection(
					bundle.getString("url"),
					bundle.getString("user"),
					bundle.getString("pass"));
			pstmt = conn.prepareStatement(sql);
			cnt = pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			disConnect(conn, stmt, pstmt, rs);
		}
		return cnt;
	}
}
