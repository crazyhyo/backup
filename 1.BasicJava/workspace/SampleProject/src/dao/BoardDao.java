package dao;

import java.util.List;
import java.util.Map;
import controller.Controller;
import service.BoardService;
import util.JDBCUtil;
import util.ScanUtil;


public class BoardDao {
	//싱글톤 패턴
	private BoardDao(){}
	private static BoardDao instance;
	public static BoardDao getInstance(){
		if(instance == null){
			instance = new BoardDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public List<Map<String, Object>> selectBoardList(){
		String sql = "SELECT A.BOARD_NO, A.TITLE, B.USER_NAME, A.REG_DATE"
				+ "     FROM TB_JDBC_BOARD A"
				+ "     LEFT OUTER JOIN TB_JDBC_USER B ON (A.USER_ID = B.USER_ID)"
				+ "    ORDER BY A.BOARD_NO DESC";
		
		return jdbc.selectList(sql);
	}

	public Map<String, Object> searchBoard() {
		System.out.print("조회할 게시글 번호를 입력하세요>");
		int input = ScanUtil.nextInt();
		
		String sql = "SELECT A.BOARD_NO, B.USER_NAME, A.REG_DATE, A.TITLE, A.CONTENT"
				+ "     FROM TB_JDBC_BOARD A, TB_JDBC_USER B"
				+ "    WHERE A.USER_ID = B.USER_ID"
				+ "          AND A.BOARD_NO = " + input;
		
//		System.out.println(sql);
		
		return jdbc.selectOne(sql);
		}

	public Map<String, Object> addBoard() {
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		
		String sql = "INSERT INTO TB_JDBC_BOARD(BOARD_NO, TITLE, CONTENT, USER_ID, REG_DATE)"
				+ "   VALUES((SELECT NVL(MAX(BOARD_NO) + 1,1) FROM TB_JDBC_BOARD), '"
				+ title + "', '"
				+ content + "', '"
				+ Controller.getUserId() + "', SYSDATE)";
		
//		System.out.println(sql);
		
		jdbc.update(sql);
		
		sql = "SELECT A.BOARD_NO, B.USER_NAME, A.REG_DATE, A.TITLE, A.CONTENT"
				+ "    FROM TB_JDBC_BOARD A, TB_JDBC_USER B"
				+ "    WHERE A.USER_ID = B.USER_ID"
				+ "          AND A.BOARD_NO = (SELECT NVL(MAX(BOARD_NO), 0) FROM TB_JDBC_BOARD)";
		
//		System.out.println(sql);
		
		return jdbc.selectOne(sql);
		
	}

	public int deleteBoard() {
		if(!isApprochable()){
			System.out.println("권한이 없습니다.");
			return 0;
		}
		String sql = "DELETE TB_JDBC_BOARD"
				+ "    WHERE BOARD_NO = " + BoardService.getBoardNo();
		
		return jdbc.update(sql);
	}

	public Map<String, Object> updateBoard() {
		if(!isApprochable()){
			System.out.println("권한이 없습니다.");
			return null;
		}
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		
		String sql = "UPDATE TB_JDBC_BOARD"
				+ "      SET TITLE = '"	+ title
				+ "', CONTENT = '"	+ content 
				+ "' WHERE BOARD_NO = " + BoardService.getBoardNo();
//		System.out.println(sql);
		
		jdbc.update(sql);
		
		sql = "SELECT A.BOARD_NO, B.USER_NAME, A.REG_DATE, A.TITLE, A.CONTENT"
				+ "     FROM TB_JDBC_BOARD A, TB_JDBC_USER B"
				+ "    WHERE A.USER_ID = B.USER_ID"
				+ "          AND A.BOARD_NO = " + BoardService.getBoardNo();
		
//		System.out.println(sql);
		
		return jdbc.selectOne(sql);
	}

	private boolean isApprochable() {
		int boardNo = BoardService.getBoardNo();
		String crtId = Controller.getUserId();
		String sql = "SELECT *"
				+ "     FROM TB_JDBC_BOARD A, TB_JDBC_USER B"
				+ "    WHERE A.USER_ID = B.USER_ID"
				+ "          AND B.USER_ID = '" + crtId + "'"
						+ "  AND A.BOARD_NO = " + boardNo;
		if(jdbc.selectOne(sql) == null){
			return false;
		}else{
			return true;
		}
	}
	
}
