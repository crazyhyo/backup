package viewControlWithEnum;

import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class BoardService {
	
	private static BoardService instance = null;
	
	private static Connection conn;
	private static PreparedStatement pstmt;
	private static Statement stmt;
	private static ResultSet rs;
	private static ResultSetMetaData metaData;
	
	public static BoardVO currentBoard;
	public static List<BoardVO> list;
	
	private BoardService() {
		currentBoard = new BoardVO();
		list = new ArrayList<BoardVO>();
	}
	
	public static BoardService getInstance() {
		if(instance == null) {
			instance = new BoardService();
		}
		return instance;
	}
	
	
	public static View boardList() {
		showList();
		int back = Controller.getCurrentView().printChoices();
		int input = ScanUtil.nextInt();
		switch(input) {
		case 1: search(); break;
		}
		View view = Controller.getCurrentView().select(input, back);
		return view;
	}

	private static void search() {
		System.out.println("조회할 글 번호를 입력하세요");
		int input = ScanUtil.nextInt();
		
	}

	private static void showList() {
		for(BoardVO board : list) {
			board.printBoard();
		}
	}

	public static View searchedList() {
		System.out.println("|||" + Controller.getCurrentView().name() + "|||");
		return null;
	}

	public static View boardDetail() {
		System.out.println("|||" + Controller.getCurrentView().name() + "|||");
		return null;
	}
	
	public BoardVO getCurrentBoard() { return currentBoard; }
	public int getCurrentBoardNo() { return currentBoard.getBoardNo(); }

	public static void load() {
		String sql = "";
		
		sql = "select * from jdbc_board order by board_no desc";
		
		list = new ArrayList<BoardVO>();
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				for(int i = 1; i <= count; i++) {
					Object value = rs.getObject(i);
					if(value instanceof BigDecimal){
						value = ((BigDecimal)value).intValue();
					}else if(value instanceof Clob) {
						value = ((Clob)value).toString();
					}else if(value instanceof Date) {
						value = ((Date)value);
					}
					map.put(metaData.getColumnName(i), value);
				}
				list.add(new BoardVO(map));
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil.disConnect(conn, stmt, pstmt, rs);
		}
	}

}
