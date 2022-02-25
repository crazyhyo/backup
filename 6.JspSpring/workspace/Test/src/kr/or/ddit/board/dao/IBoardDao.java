package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.util.vo.BoardDTO;
import kr.or.ddit.util.vo.BoardVO;
import kr.or.ddit.util.vo.PagingVO;

public interface IBoardDao {
	
	public List<BoardVO>  boardPagingList(PagingVO pagingVO) throws SQLException;
	
	public int getTotalRecord() throws SQLException;
	
	public BoardVO boardCard(int boardNo) throws SQLException;
	
	public int updateHit(int boardNo) throws SQLException;
	
	public int updateReport(int boardNo) throws SQLException;
	
	public int updateBoard(BoardDTO boardDTO) throws SQLException;
	
	public int deleteBoard(int boardNo) throws SQLException;
	
	public int insertBoard(BoardDTO boardDTO) throws SQLException;
}
