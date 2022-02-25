package com.jsp.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.ReplyVO;

public interface ReplyDAO {
	
	public int selectReplySeqNextValue(SqlSession session) throws SQLException;
	
	public List<ReplyVO> selectReplyList(SqlSession session, int bno, SearchCriteria cri) throws SQLException;
	
	public int countReply(SqlSession session, int bno) throws SQLException;
	
	public void insertReply(SqlSession session, ReplyVO reply) throws SQLException;
	public void updateReply(SqlSession session, ReplyVO reply) throws SQLException;
	public void deleteReply(SqlSession session, int rno) throws SQLException;
}
