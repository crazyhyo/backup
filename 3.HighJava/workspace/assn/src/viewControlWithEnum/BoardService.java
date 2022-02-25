package viewControlWithEnum;

import java.math.BigDecimal;
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
	
	public BoardVO getCurrentBoard() { return currentBoard; }
	public int getCurrentBoardNo() { return currentBoard.getBoardNo(); }

	public static void load() {
		String sql = "";
		
		sql = "select board_no, board_title, board_writer, board_date, to_char(board_content) as content"
				+ " from jdbc_board"
				+ " order by board_no desc";
		
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
						value = rs.getInt(i);
					}else if(value instanceof Date) {
						value = rs.getDate(i);
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

	public static View boardList() {
		showList();
		int back = Controller.showCurrentChoices();
		int input = ScanUtil.nextInt();
		boolean flag = true;				//	flag가 true이면 정상처리됨
		switch(input) {
		case 1: flag = search(); break;
		case 2: add(); break;
		case 3: exit(); break;
		case 4: break;
		}
		if(flag) {
			View view = Controller.getCurrentView().select(input, back);
			
			return view;
		}else {
			return Controller.getCurrentView();
		}
	}

	private static void showList() {
		System.out.println();
		System.out.println();
		System.out.println("=================================게시판=================================");
		System.out.println();
		System.out.println();
		for(BoardVO board : list) {
			board.printBoard();
		}
		System.out.println();
	}

	private static boolean search() {
		System.out.println("조회할 글 번호를 입력하세요");
		int input = ScanUtil.nextInt();
		currentBoard = searchByNo(input);
		return currentBoard != null;
	}

	private static BoardVO searchByNo(int input) {
		String sql = "";
		sql = "select board_no, board_title, board_writer, board_date, to_char(board_content) as content" 
				+ " from jdbc_board"
				+ " where board_no = " + input;
		try{
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			
			rs.next();
			
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i = 1; i <= count; i++) {
				Object value = rs.getObject(i);
				if(value instanceof BigDecimal){
					value = ((BigDecimal)value).intValue();
				}else if(value instanceof Date) {
					value = ((Date)value);
				}
				map.put(metaData.getColumnName(i), value);
			}
			System.out.println("데이터를 찾았습니다.");
			return new BoardVO(map);
		}catch(SQLException ex) {
			System.out.println("데이터가 없습니다.");
			return null;
		}finally {
			JDBCUtil.disConnect(conn, stmt, pstmt, rs);
		}
	}

	private static void add() {
		System.out.print("제목을 입력하세요>");
		String title = ScanUtil.nextLine();
		System.out.print("내용을 입력하세요>");
		String content = ScanUtil.nextLine();
		System.out.print("작성자를 입력하세요>");
		String user = ScanUtil.nextLine();
        
        toAdd(title, content, user);
	}

	private static void toAdd(String title, String content, String user) {
		String sql = "";
		sql = "insert into jdbc_board(board_no, board_title, board_writer, board_date, board_content)"
				+ " values(board_seq.nextVal,'" + title + "','" + user + "', sysdate, '" + content+ "' )";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
			sql = "select board_no, board_title, board_writer, board_date, to_char(board_content) as content"
					+ " from jdbc_board"
					+ " where board_no = (select max(board_no) from jdbc_board)";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			
			rs.next();
			
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i = 1; i <= count; i++) {
				Object value = rs.getObject(i);
				if(value instanceof BigDecimal){
					value = ((BigDecimal)value).intValue();
				}else if(value instanceof Date) {
					value = ((Date)value);
				}
				map.put(metaData.getColumnName(i), value);
			}
			currentBoard = new BoardVO(map);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.disConnect(conn, stmt, pstmt, rs);
		}
		
	}

	private static void exit() {
		System.out.println("프로그램 종료");
		System.exit(0);
	}

	public static View boardDetail() {
		currentBoard.printBoardDetail();
		int back = Controller.showCurrentChoices();
		int input = ScanUtil.nextInt();
		boolean flag = true;			//	flag가 true이면 정상처리됨
		switch(input) {
		case 1: flag = update(); break;
		case 2: flag = delete(); break;
		case 3:	break;
		}
		if(flag) {
			View view = Controller.getCurrentView().select(input, back);
			return view;
		}else {
			return Controller.getCurrentView();
		}
	}
	
	private static boolean update() {
		System.out.print("제목을 입력하세요>");
		String title = ScanUtil.nextLine();
		System.out.print("내용을 입력하세요>");
		
		String content = ScanUtil.nextLine();
        System.out.println("작업완료");
        System.out.println("입력한 내용 : " + content);
        
        int result = toUpdate(title, content);
        if(result == 0) {
        	return false;
        }else {
        	return true;
        }
	}

	private static int toUpdate(String title, String content) {
		String sql = "";
			sql = "update jdbc_board"
				+ "   set board_title = '" + title + "',"
				+ "       board_content = '" + content + "'"
				+ " where board_no = " + currentBoard.getBoardNo();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			int result = pstmt.executeUpdate();
			
			sql = "select board_no, board_title, board_writer, board_date, to_char(board_content) as content" 
			 + "	 from jdbc_board"
			 + "	where board_no = " + currentBoard.getBoardNo();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			
			rs.next();
			
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i = 1; i <= count; i++) {
				Object value = rs.getObject(i);
				if(value instanceof BigDecimal){
					value = ((BigDecimal)value).intValue();
				}else if(value instanceof Date) {
					value = ((Date)value);
				}
				map.put(metaData.getColumnName(i), value);
			}
			
			currentBoard = new BoardVO(map);
			
			return result;
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.disConnect(conn, stmt, pstmt, rs);
		}
		return 0;
	}
	private static boolean delete() {
		System.out.println("정말로 삭제하시겠습니까?(y/n)");
		String ans = ScanUtil.nextLine();
		if(!(ans.equals("y") || ans.equals("Y"))) {
			return false;
		}else {
			deleteBoard();
			return true;
		}
		
	}

	private static void deleteBoard() {
		String sql = "";
		sql = "delete jdbc_board where board_no = " + currentBoard.getBoardNo();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);

			int result = pstmt.executeUpdate();
			currentBoard = null;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.disConnect(conn, stmt, pstmt, rs);
		}

	}

}
