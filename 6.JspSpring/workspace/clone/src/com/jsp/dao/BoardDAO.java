package com.jsp.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.BoardVO;

public interface BoardDAO {
	
	public List<BoardVO> selectSearchBoardList(SqlSession session, SearchCriteria cri) throws SQLException;
	
	public int selectSearchBoardListCount(SqlSession session, SearchCriteria cri) throws SQLException;
	
	public BoardVO selectBoardByBno(SqlSession session, int bno) throws SQLException;
	
	public void insertBoard(SqlSession session, BoardVO board) throws SQLException;
	
	public void updateBoard(SqlSession session, BoardVO board) throws SQLException;
	
	public void deleteBoard(SqlSession session, int bno) throws SQLException;
	
	// increase viewcnt
	public void increaseViewCnt(SqlSession session, int bno) throws SQLException;
	
	// return board_seq.nextval
	public int selectBoardSeqNext(SqlSession session) throws SQLException;
}
