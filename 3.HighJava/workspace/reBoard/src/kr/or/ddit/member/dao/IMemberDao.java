package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;

public interface IMemberDao {
	
	public MemberDTO getMember(String id) throws SQLException;
	
	public List<MemberDTO> getMemberList() throws SQLException;
	
	public int registerMember(MemberDTO memberDTO)  throws SQLException;
	
	public int updateMember(MemberDTO memberDTO)  throws SQLException;
	
	public int deleteMember(String id) throws SQLException;
	
	public List<MemberDTO> searchMember(MemberDTO memberDTO)  throws SQLException;	
	
	public int getMemberCount() throws SQLException;
	
	public List<MemberDTO> getMemberPagingList(PagingVO pagingVO)  throws SQLException;
	
	public int idCheck(String id) throws SQLException;
	
	public List<MemberDTO> searchMemberList(PagingVO pagingVO)  throws SQLException;
	
	public int getSearchCount(PagingVO pagingVO)  throws SQLException;
}
