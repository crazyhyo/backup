package kr.or.ddit.jdbcBoard.service;

import java.util.List;

import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

public interface IJdbcBoardService {

//		public int insertBoard(JdbcBoardVO boardVO);
		
		public boolean chkBoard(int board_no);
		
		public JdbcBoardVO selectBoard(int board_no);
		
		public List<JdbcBoardVO> selectAllBoard();
		
//		public int updateBoard(JdbcBoardVO boardVO);
		
		public int deleteBoard(int board_no);
		
		public List<JdbcBoardVO> searchBoard(JdbcBoardVO boardVO);
}
