package kr.or.ddit.service;

import java.sql.SQLException;

import kr.or.ddit.dao.MemberDAO;

public class MemberServiceImpl implements MemberService{
	
	private MemberDAO memberDAO = null;
	
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}

	@Override
	public int getMberSequence() throws SQLException {
		int seqVal = memberDAO.selectMberGenSeqNext();
		return seqVal;
	}
	
	

}
