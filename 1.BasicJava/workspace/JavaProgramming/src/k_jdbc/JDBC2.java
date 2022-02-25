package k_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class JDBC2 {

	public static void main(String[] args) {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "LKH96";
		String password = "java";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
//			String sql = "select cart_member as 실험"
			String sql = "select *"
					+ " from cart"
					+ " where cart_member = ?"
					+ " and cart_qty > ?";

			// ? 는 뭘까
			//JDBC에서 쿼리를 작성할 때 값 대신에 ?로 바꾸고 ?의 값을 나중에 세팅함
			
			ps = con.prepareStatement(sql);
			ps.setString(1, "a001");
			//첫번째 ?에 String "a001"을 넣겠다
			ps.setInt(2, 5);
			//두번째 ?에 int 5를 넣겠다.
			//set으로 ?에 넣는 것은 값만 넣을 수 있음
			rs = ps.executeQuery();
			
			ResultSetMetaData metaData = rs.getMetaData(); // 메타데이터 : 데이터에 대한 데이터
			
			int columnCount = metaData.getColumnCount();
			
			for(int i = 1; i <= columnCount; i++){
				System.out.println(metaData.getColumnName(i) + "\t");
			}
			
			while(rs.next()){
				for(int i = 1; i <= columnCount; i++){
					Object value = rs.getObject(i);
					System.out.print(value + "\t");
				}
				System.out.println();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}

	}

}
