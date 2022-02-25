package board.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import board.vo.BoardVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class BoardDaoImpl implements IBoardDao{

	private static BoardDaoImpl instance = null;
	private SqlMapClient smc;
	private final String namespace;
	
	private BoardDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
		namespace = "board";
	}
	
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
			int cnt = (int) smc.queryForObject(namespace + ".chkBoard", boardNo);
			chk = cnt > 0;
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return chk;
	}

	@Override
	public List<BoardVO> getAllBoard() {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		try {
			boardList = smc.queryForList(namespace + ".getAllBoard");
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return boardList;
	}

	@Override
	public int insertBoard(BoardVO bv) {
		int boardNo = 0;
		try {
			Object obj = smc.insert(namespace + ".insertBoard", bv);
			
			if(obj == null) {
				boardNo = (int) smc.queryForObject(namespace + ".maxBoardNo");
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return boardNo;
	}
	
	@Override
	public BoardVO selectBoard(int boardNo) {
		BoardVO tempBoard = new BoardVO();
		try {
			tempBoard = (BoardVO) smc.queryForObject(namespace + ".selectOneBoard", boardNo);
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return tempBoard;
	}
	
	@Override
	public int updateBoard(BoardVO bv) {
		int cnt = 0;
		try {
			
			cnt = smc.update(namespace + ".updateBoard", bv);
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteBoard(int boardNo) {
		int cnt = 0;
		try {
			
			cnt = smc.delete(namespace + ".deleteBoard", boardNo);
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return cnt;
	}

	@Override
	public List<BoardVO> getSearchBoard(BoardVO bv) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		try {
			
			boardList = smc.queryForList(namespace + ".getSearchBoard", bv);
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return boardList;
	}

}
