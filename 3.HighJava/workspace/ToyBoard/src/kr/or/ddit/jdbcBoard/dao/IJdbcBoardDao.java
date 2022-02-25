package kr.or.ddit.jdbcBoard.dao;

import java.util.List;

import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

public interface IJdbcBoardDao {
	
//		public int insertBoard(JdbcBoardVO boardVO);
		
		public boolean chkBoard(int board_no);
		
		public JdbcBoardVO selectBoard(int board_no);
		
		public List<JdbcBoardVO> selectAllBoard();
		
//		public int updateBoard(JdbcBoardVO boardVO);
		
		public int deleteBoard(int board_no);
		
		public List<JdbcBoardVO> searchBoard(JdbcBoardVO boardVO);
		
}
