package k_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Delete {

	public static void main(String[] args) {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "TOY";
		String password = "java";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
			String sql = "delete cart"
					+ " where rownum = 1";

			ps = con.prepareStatement(sql);
//			ps.setString(1, "a001");
			//첫번째 ?에 String "a001"을 넣겠다
//			ps.setInt(2, 5);
			//두번째 ?에 int 5를 넣겠다.
			//set으로 ?에 넣는 것은 값만 넣을 수 있음
			int res = ps.executeUpdate();
			System.out.println(res);
			
//			ResultSetMetaData metaData = rs.getMetaData(); // 메타데이터 : 데이터에 대한 데이터
//			
//			int columnCount = metaData.getColumnCount();
//			
//			for(int i = 1; i <= columnCount; i++){
//				System.out.print(metaData.getColumnName(i) + "\t");
//			}
//			System.out.println();
//			
//			while(rs.next()){
//				for(int i = 1; i <= columnCount; i++){
//					Object value = rs.getObject(i);
//					System.out.print(value + "\t");
//				}
//				System.out.println();
//			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}

	}

}
