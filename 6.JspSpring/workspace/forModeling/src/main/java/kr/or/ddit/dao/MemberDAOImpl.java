package kr.or.ddit.dao;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;

public class MemberDAOImpl implements MemberDAO{
	
	private SqlSession sqlSession = null;
	private String nameSpace = "Member-Mapper.";
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int selectMberGenSeqNext() throws SQLException{
		int seqVal = sqlSession.selectOne(nameSpace + "selectMberGenSeqNext"); 
		return seqVal;
	}

}
