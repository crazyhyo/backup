package kr.or.ddit.dao.spring;

import java.sql.SQLException;
import java.util.List;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.BoardVO;

public interface BoardDAOBean {
	
	public List<BoardVO> selectSearchBoardList(SearchCriteria cri) throws SQLException;

	public int selectSearchBoardListCount(SearchCriteria cri) throws SQLException;

	public BoardVO selectBoardByBno(int bno) throws SQLException;
	
	public BoardVO selectBoardByImage(String imageFile) throws SQLException;

	public void insertBoard(BoardVO board) throws SQLException;

	public void updateBoard(BoardVO board) throws SQLException;

	public void deleteBoard(int bno) throws SQLException;

	// increase viewcnt
	public void increaseViewCnt(int bno) throws SQLException;

	// return board_seq.nextval
	public int selectBoardSeqNext() throws SQLException;

}
