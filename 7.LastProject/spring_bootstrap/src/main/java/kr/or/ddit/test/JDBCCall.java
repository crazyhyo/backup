package kr.or.ddit.test;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCCall {
	
	public static void main(String[] args){
		try (
				Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "JSP", "JSP");
				CallableStatement cstmt = conn.prepareCall("{call SEQ_RESET(?)}");
				){
			cstmt.setString(1, "SEQ_TEST");
			
			cstmt.executeUpdate();
			System.out.println("test close");
		} catch(Exception e) {
			e.printStackTrace();
		} 
		
	}
}
