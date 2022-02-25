package com.jsp.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.jsp.command.Criteria;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.MemberVO;

public class MemberDAOImpl implements MemberDAO{

	@Override
	public List<MemberVO> selectMemberList(SqlSession session) throws Exception {
		List<MemberVO> memberList 
			= session.selectList("Member-Mapper.selectMemberList");
		
		return memberList;
	}

	@Override
	public List<MemberVO> selectMemberList(SqlSession session, Criteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<MemberVO> memberList 
		= session.selectList("Member-Mapper.selectMemberList", null, rowBounds);
	
		return memberList;
	}

	@Override
	public int selectMemberListCount(SqlSession session) throws Exception {
		int totalCount = session.selectOne("Member-Mapper.selectMemberListCount");

		return totalCount;
	}

	@Override
	public List<MemberVO> selectMemberList(SqlSession session, SearchCriteria cri) throws Exception {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<MemberVO> memberList 
			= session.selectList("Member-Mapper.selectSearchMemberList", cri, rowBounds);
	
		return memberList;
	}

	@Override
	public int selectMemberListCount(SqlSession session, SearchCriteria cri) throws Exception {
		int totalCount = 0;
		totalCount = session.selectOne("Member-Mapper.selectSearchMemberListCount", cri);
		return totalCount;
	}

	@Override
	public MemberVO selectMemberById(SqlSession session, String id) throws SQLException {
		MemberVO member = null;
		member = session.selectOne("Member-Mapper.selectMemberById", id);
		return member;
	}

	@Override
	public void insertMember(SqlSession session, MemberVO member) throws Exception {
		session.update("Member-Mapper.insertMember", member);
	}


}
