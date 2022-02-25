package com.jsp.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.PdsVO;

public interface PdsDAO {

	public List<PdsVO> selectSearchPdsList(SqlSession session, SearchCriteria cri) throws SQLException;
	public int selectSearchPdsListCount(SqlSession session, SearchCriteria cri) throws SQLException;
	
	public PdsVO selectPdsByPno(SqlSession session, int pno) throws SQLException;
	
	public void insertPds(SqlSession session, PdsVO pds) throws SQLException;
	public void updatePds(SqlSession session, PdsVO pds) throws SQLException;
	public void deletePds(SqlSession session, int pno) throws SQLException;
	
	public void increaseViewCnt(SqlSession session, int pno) throws SQLException;
	
	public int selectPdsSeqNext(SqlSession session) throws SQLException;
}
