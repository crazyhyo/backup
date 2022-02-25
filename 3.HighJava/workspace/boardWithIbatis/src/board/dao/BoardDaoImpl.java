package board.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ibatis.sqlmap.client.SqlMapClient;

import board.vo.BoardVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class BoardDaoImpl implements IBoardDao{

	
	private static final Logger LOGGER = Logger.getLogger("log4jexam.wql.Query");
	private static BoardDaoImpl instance = null;
	private String nameSpace;
	SqlMapClient smc;
	
	private BoardDaoImpl() {
		nameSpace = "boardDao";
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static BoardDaoImpl getInstance() {
		if(instance == null) {
			instance = new BoardDaoImpl();
		}
		return instance;
	}
	
	@Override
	public boolean chkBoard(String boardNo) {
		boolean chk = false;
		try {
            int cnt = (Integer)smc.queryForObject(nameSpace + ".chkBoard", boardNo);
				return cnt > 0 ? true : false;
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return chk;
	}

	@Override
	public List<BoardVO> getAllBoard() {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		try {
			boardList = (List<BoardVO>)smc.queryForList(nameSpace + ".getAllBoard");
			return boardList;
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return boardList;
	}

	@Override
	public String insertBoard(BoardVO bv) {
		String boardNo = "";
		try {
			Object obj = smc.insert(nameSpace + ".insertBoard", bv);
			if(obj == null) {
				boardNo = (String)smc.queryForObject(nameSpace + ".maxBoardNo");
				return boardNo;
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return boardNo;
	}

	@Override
	public int updateBoard(BoardVO bv) {
		int cnt = 0;
		try {
			cnt = smc.update(nameSpace + ".updateBoard");
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteBoard(String boardNo) {
		int cnt = 0;
		try {
			cnt = smc.delete(nameSpace + ".deleteBoard", boardNo);
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return cnt;
	}

	@Override
	public List<BoardVO> getSearchBoard(BoardVO bv) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		return null;
		/*try {
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
		return boardList;*/
	}

	@Override
	public BoardVO selectBoard(String boardNo) {
		BoardVO board = new BoardVO();
		try {
			
			LOGGER.debug("===selectBoard 실행 전===");
			
			board = (BoardVO) smc.queryForObject(nameSpace + ".selectBoard", boardNo);
			
			LOGGER.debug("selectBoard 결과 : " + board);
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return board;
	}

}
