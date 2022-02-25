package k_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class JDBC {

	public static void main(String[] args) {
		/*
		 *  JDBC(Java Databace Connectivity)
		 *  - 자바의 데이터베이스를 연결해주는 라이브러리
		 *  - ojdbc : 오라클 JDBC
		 *  
		 *  JDBC 작성 단계
		 *  1. Connection 생성(DB연결)
		 *  2. Statement 생성(쿼리 작성)
		 *  3. Query 실행
		 *  4. ResultSet에서 결과 추출(Select인 경우)
		 *  5. ResultSet, Statement, Connection 닫기
		 */
		
		//데이터베이스 접속 정보
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		//jdbc:oracle:thin: <- 접속할 때 사용할 드라이버 @ 앞쪽에 위치
		//localhost <- ip주소
		//1521 <- 포트
		//xe <- 서비스아이디(SID)
		String user = "LKH96";
		String password = "java";
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			
//			String sql = "SELECT * from member";
//			String sql = "insert into member values('','','','')";
			String sql = "SELECT A.MEM_ID AS 회원번호,       A.MEM_NAME AS 회원명,       B.AMT AS 구매금액,       RANK() OVER(ORDER BY AMT DESC) AS 순위  FROM MEMBER A,       (SELECT B.MEM_ID AS MID,               SUM(A.CART_QTY * C.PROD_PRICE) AS AMT          FROM CART A, MEMBER B, PROD C         WHERE A.CART_MEMBER = B.MEM_ID               AND A.CART_PROD = C.PROD_ID               AND SUBSTR(A.CART_NO,1,6) = '200505'         GROUP BY B.MEM_ID, B.MEM_NAME         ORDER BY 2) B WHERE A.MEM_ID = B.MID";
			//JDBC로 쿼리를 작성할 때는 세미콜론을 넣으면 안됨
			ps = con.prepareStatement(sql);

			//select
			rs = ps.executeQuery();
			//insert, update, delete

			//자바에서 쿼리를 날려서 데이터베이스가 달라지면 자동으로 커밋됨(롤백으로 살릴 수 없음), auto commit
			
//			int result = ps.executeUpdate();
			//정수형 리턴값은 영향받은 행의 개수
			//여기까지는 rs가 아무것도 바라보지 않음
			
			ResultSetMetaData metaData = rs.getMetaData(); // 메타데이터 : 데이터에 대한 데이터
			
			int columnCount = metaData.getColumnCount();
			
			for(int i = 1; i <= columnCount; i++){
				System.out.print(metaData.getColumnName(i) + "\t");
			}
			System.out.println();
			while(rs.next()){	//next수행 이후 해당 쿼리의 레코드가 있다면 그 결과를 바라보게 됨 
				String memId = rs.getString(1);			// 컬럼의 인덱스, 첫 번째 컬럼
				String temp = rs.getString(2);			// 컬럼의 인덱스, 첫 번째 컬럼
				String temp2 = rs.getString(3);			// 컬럼의 인덱스, 첫 번째 컬럼
				String temp3 = rs.getString(4);			// 컬럼의 인덱스, 첫 번째 컬럼
//				String memPass = rs.getString("MEM_PASS");	//컬럼의 이름
//				System.out.println("MEM_ID : " + memId + "/ MEM_PASS : " + memPass);
				System.out.println("회원번호 : " + memId + "/ 회원명 : " + temp + "/ 구매금액 : " + temp2 + "/ 순위: " + temp3);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs != null) try { rs.close(); } catch (Exception e) {}
			if(ps != null) try { ps.close(); } catch (Exception e) {}
			if(con != null) try { con.close(); } catch (Exception e) {}
		}
		//드라이버 : 서로 다른 애를 연결시켜주는 중간다리 같은 애
		
	}

}
