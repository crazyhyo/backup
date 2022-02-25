package board.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import board.vo.BoardVO;
import kr.or.ddit.util.JDBCUtil3;

public class BoardDaoImpl implements IBoardDao{

    private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static BoardDaoImpl instance = null;
	
	private BoardDaoImpl() { }
	
	public static BoardDaoImpl getInstance() {
		if(instance == null) {
			instance = new BoardDaoImpl();
		}
		return instance;
	}
	
	@Override
	public boolean chkBoard(int boardNo) {
		boolean chk = false;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select count(board_no) cnt from jdbc_board"
					+ "    where board_no = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				chk = rs.getInt("cnt") > 0 ? true : false;
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return chk;
	}

	@Override
	public List<BoardVO> getAllBoard() {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select * from jdbc_board"
					+ "    order by board_no desc";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int boardNo = rs.getInt("board_no");
				String boardTitle = rs.getString("board_title");
				String boardWriter = rs.getString("board_writer");
				Date boardDate = rs.getDate("board_date");
				String boardContent = rs.getString("board_content");
				
				BoardVO board = new BoardVO(boardNo, boardTitle, boardWriter, boardDate, boardContent);
				boardList.add(board);
			}
			
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return boardList;
	}

	@Override
	public int insertBoard(BoardVO bv) {
		int cnt = 0;
		int boardNo = 0;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "insert into jdbc_board(board_no, board_title, board_writer, board_date, board_content)"
					+ "   values(board_seq.nextVal,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bv.getBoardTitle());
			pstmt.setString(2, bv.getBoardWriter());
			pstmt.setString(3, bv.getBoardContent());
			
			cnt = pstmt.executeUpdate();
			
			if(cnt > 0) {
				sql = "select max(board_no) as bod_max from jdbc_board";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					boardNo = rs.getInt("BOD_MAX");
				}
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return boardNo;
	}

	@Override
	public int updateBoard(BoardVO bv) {
		int cnt = 0;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "update jdbc_board"
					+ "      set board_title = ?"
					+ "			 ,board_content = ?"
					+ "			 ,board_date = sysdate"
					+ "	   where board_no = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bv.getBoardTitle());
			pstmt.setString(2, bv.getBoardContent());
			pstmt.setInt(3, bv.getBoardNo());
			
			cnt = pstmt.executeUpdate();
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public int deleteBoard(int boardNo) {
		int cnt = 0;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "delete jdbc_board"
					+ "    where board_no = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNo);
			
			cnt = pstmt.executeUpdate();
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public List<BoardVO> getSearchBoard(BoardVO bv) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select * from jdbc_board where 1 = 1";
			
			int index = 1;
			
			if(bv.getBoardTitle() != null && !bv.getBoardTitle().equals("")) {
				sql += " and board_title like '%' || ? || '%' ";
			}
			if(bv.getBoardContent() != null && !bv.getBoardContent().equals("")) {
				sql += " and board_content like '%' || ? || '%' ";
			}
			if(bv.getBoardWriter() != null && !bv.getBoardWriter().equals("")) {
				sql += " and board_writer = ? ";
			}
			sql += " order by board_no desc";
			
			pstmt = conn.prepareStatement(sql);
			
			if(bv.getBoardTitle() != null && !bv.getBoardTitle().equals("")) {
				pstmt.setString(index++, bv.getBoardTitle());
			}
			if(bv.getBoardContent() != null && !bv.getBoardContent().equals("")) {
				pstmt.setString(index++, bv.getBoardContent());
			}
			if(bv.getBoardWriter() != null && !bv.getBoardWriter().equals("")) {
				pstmt.setString(index++, bv.getBoardWriter());
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int boardNo = rs.getInt("board_no");
				String boardTitle = rs.getString("board_title");
				String boardWriter = rs.getString("board_writer");
				Date boardDate = rs.getDate("board_date");
				String boardContent = rs.getString("board_content");
				
				BoardVO board = new BoardVO();
				board.setBoardNo(boardNo);
				board.setBoardTitle(boardTitle);
				board.setBoardWriter(boardWriter);
				board.setBoardDate(boardDate);
				board.setBoardContent(boardContent);
				
				boardList.add(board);
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		return boardList;
	}

	@Override
	public BoardVO selectBoard(int boardNo) {
		BoardVO board = null;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select board_no, board_title, board_writer, board_date, board_content"
					+ "	    from jdbc_board"
					+ "	   where board_no = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String boardTitle = rs.getString("board_title");
				String boardWriter = rs.getString("board_writer");
				Date boardDate = rs.getDate("board_date");
				String boardContent = rs.getString("board_content");
				
				board = new BoardVO();
				board.setBoardNo(boardNo);
				board.setBoardTitle(boardTitle);
				board.setBoardWriter(boardWriter);
				board.setBoardDate(boardDate);
				board.setBoardContent(boardContent);
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			JDBCUtil3.disConnect(conn, stmt, pstmt, rs);
		}
		
		return board;
	}

}
