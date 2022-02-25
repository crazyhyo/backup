package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberDTO;

public interface IMemberDao {
	
	public MemberDTO getMember(String id) throws SQLException;
	
	public List<MemberDTO> getMemberList() throws SQLException;
	
	public int registerMember(MemberDTO memberDTO)  throws SQLException;
	
	public int updateMember(MemberDTO memberDTO)  throws SQLException;
	
	public int deleteMember(String id) throws SQLException;
	
	public List<MemberDTO> searchMember(MemberDTO memberDTO)  throws SQLException;
	
}
