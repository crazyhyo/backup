package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;

public interface IMemberService {
	
	public MemberDTO getMember(String id);
	
	public int registerMember(MemberDTO memberDTO);
	
	public int updateMember(MemberDTO memberDTO);
	
	public int deleteMember(String id);
	
	public int idCheck(String id);
	
	public List<MemberDTO> searchMemberList(PagingVO pagingVO);
	
	public int getSearchCount(PagingVO pagingVO);
}
