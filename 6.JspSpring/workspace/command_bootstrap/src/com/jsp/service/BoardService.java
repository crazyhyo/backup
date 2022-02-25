package com.jsp.service;

import java.sql.SQLException;
import java.util.Map;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.BoardVO;

public interface BoardService {

	public Map<String, Object> getBoardList(SearchCriteria cri) throws SQLException;
	
	public BoardVO getBoard(int bno) throws SQLException;
	public BoardVO getBoardForModify(int bno) throws SQLException;
	
	public void regist(BoardVO board) throws SQLException;
	public void modify(BoardVO board) throws SQLException;
	public void remove(int bno) throws SQLException;
}
