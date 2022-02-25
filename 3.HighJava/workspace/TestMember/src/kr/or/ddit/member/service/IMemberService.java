package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberDTO;

public interface IMemberService {
	
	public MemberDTO getMember(String id);
	
	public List<MemberDTO> getMemberList();
	
	public int registerMember(MemberDTO memberDTO);
	
	public int updateMember(MemberDTO memberDTO);
	
	public int deleteMember(String id);
	
	public List<MemberDTO> searchMember(MemberDTO memberDTO);
	
}
