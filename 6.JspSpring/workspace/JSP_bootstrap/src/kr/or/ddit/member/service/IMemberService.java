package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.SearchCriteria;

public interface IMemberService {
	
	public MemberDTO getMember(String id) throws Exception;
	
	public int registerMember(MemberDTO memberDTO) throws Exception;
	
	public int updateMember(MemberDTO memberDTO) throws Exception;
	
	public int deleteMember(String id) throws Exception;
	
	public int idCheck(String id) throws Exception;
	
	public List<MemberDTO> searchMemberList(PagingVO pagingVO) throws Exception;
	
	public int getSearchCount(PagingVO pagingVO) throws Exception;
	
/*	public Map<String, Object> getMemberListPage(Criteria cri) throws Exception;*/
	public Map<String, Object> getMemberListPage(SearchCriteria cri) throws Exception;
}
