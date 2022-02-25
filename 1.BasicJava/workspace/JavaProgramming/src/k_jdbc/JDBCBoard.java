package k_jdbc;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import play.ScanUtil;

public class JDBCBoard {

	JDBCUtil jdbc		= JDBCUtil.getInstance();
	SimpleDateFormat sdf= new SimpleDateFormat("MM.dd");
	
	public static void main(String[] args) {
		new JDBCBoard().start();
	}
	
	void start(){
		
		ArrayList<HashMap<String, Object>> boardTable = null;
		while(true){
			boardTable = (ArrayList) jdbc.selectList("select * from TB_JDBC_BOARD order by BOARD_NO");
			System.out.println("------------------------------------------------");
			System.out.println("번호\t제목\t작성자\t작성일");
			System.out.println("------------------------------------------------");
			for(int i = boardTable.size() - 1; i >= 0; i--){
				HashMap<String, Object> board = boardTable.get(i);
				System.out.println(board.get("BOARD_NO")
						+ "\t" + board.get("TITLE")
						+ "\t" + board.get("USER_ID")
						+ "\t" + sdf.format(board.get("REG_DATE"))
						);
			}
			System.out.println("------------------------------------------------");
			System.out.println("1.조회\t2.등록\t0.종료");
			System.out.println("번호입력>");
			int input = ScanUtil.nextInt();
			
			switch(input){
			case 1:	//조회
				read();
				break;
			case 2:	//등록
				insert(boardTable);
				break;
			case 0:	//종료
				System.out.println("프로그램이 종료되었습니다.");
				System.exit(0);
				break;
			}
		}
	}
	
	void insert(ArrayList<HashMap<String, Object>> boardTable){
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		System.out.print("이름>");
		String user = ScanUtil.nextLine();
		
		String sql = null;
		
		
		sql = "insert into TB_JDBC_BOARD(BOARD_NO, TITLE, CONTENT, USER_ID, REG_DATE) values((select NVL(max(BOARD_NO) + 1,0) from TB_JDBC_BOARD)"
				+ ", '" + title + "', '" + content + "', '" + user + "', sysdate)";
		
		jdbc.update(sql);
		
		System.out.println("게시글 등록이 완료되었습니다.");
	}
	
	void read(){
		System.out.print("조회할 게시글 번호 입력>");
		int no = ScanUtil.nextInt();
		
		String sql = null;
		
		sql = "select * from TB_JDBC_BOARD where BOARD_NO = " + no;
		
		Map<String, Object> board = jdbc.selectOne(sql);
		
		System.out.println("------------------------------------------------");
		System.out.println("번호\t: " + board.get("BOARD_NO"));
		System.out.println("작성자\t: " + board.get("USER_ID"));
		System.out.println("작성일\t: " + board.get("REG_DATE"));
		System.out.println("제목\t: " + board.get("TITLE"));
		System.out.println("내용\t: " + board.get("CONTENT"));
		System.out.println("------------------------------------------------");
		System.out.println("1.수정\t2.삭제\t0.목록");
		
		System.out.print("번호입력");
		int input = ScanUtil.nextInt();
		
		switch(input){
		case 1:	//수정
			update(no);
			break;
		case 2:	//삭제
			delete(no);
			break;
		}
	}
	
	void update(int no){
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		
		String sql = "update TB_JDBC_BOARD set TITLE = '" + title + "', CONTENT = '" + content + "' where BOARD_NO = " + no;
		
		jdbc.update(sql);
		
		System.out.println("수정이 완료되었습니다.");
		
	}
	void delete(int no){
		
		String sql = "delete TB_JDBC_BOARD where BOARD_NO = " + no;
		
		jdbc.update(sql);
		
		System.out.println("삭제가 완료되었습니다.");
	}
}
