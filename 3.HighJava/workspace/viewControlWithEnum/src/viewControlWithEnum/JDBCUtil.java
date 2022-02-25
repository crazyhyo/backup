package viewControlWithEnum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtil {
	
	static {	// static블록 : JDBCUtil이 로딩되는 시점(다른 클래스에서 JDBCUtil을 실행하는 시점)에 한번 실행됨
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");	// 해당 클래스가 있는지 체크, 있다면 아무일도 없음, 없다면 예외발생
			System.out.println("드라이버 로딩 완료!");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패!");
			e.printStackTrace();
		}
	}
	
	/**
	 * 커넥션 객체 생성
	 * @return Connection 객체
	 */
	public static Connection getConnection() {
		
		try {
			return DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe",
					"LKH96",
					"java");
		}catch(SQLException ex) {
			System.out.println("DB 연결 실패!");
			ex.printStackTrace();
			
			return null;
		}
	}
	
	/**
	 * 자원 반납
	 * @param conn
	 * @param stmt
	 * @param pstmt
	 * @param rs
	 */
	public static void disConnect(
			Connection conn,
			Statement stmt,
			PreparedStatement pstmt,
			ResultSet rs
			) {
		if(rs != null) 		try { rs.close(); } 	catch(SQLException ex) {}
		if(pstmt != null) 	try { pstmt.close(); } 	catch(SQLException ex) {}
		if(stmt != null) 	try { stmt.close(); } 	catch(SQLException ex) {}
		if(conn != null) 	try { conn.close(); } 	catch(SQLException ex) {}
		
	}
}
