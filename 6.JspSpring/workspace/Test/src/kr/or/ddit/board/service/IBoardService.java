package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.util.vo.BoardDTO;
import kr.or.ddit.util.vo.BoardVO;
import kr.or.ddit.util.vo.PagingVO;

public interface IBoardService {

	public List<BoardVO>  boardPagingList(PagingVO pagingVO);
	
	public int getTotalRecord();
	
	public BoardVO boardCard(int boardNo);
	
	public int updateReport(int boardNo);
	
	public int updateBoard(BoardDTO boardDTO);
	
	public int deleteBoard(int boardNo);
	
	public int insertBoard(BoardDTO boardDTO);
}
