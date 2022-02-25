package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.SearchCriteria;

public interface IMemberDao {
	
	public MemberDTO getMember(String id, SqlSession session) throws Exception;
	
	public int registerMember(MemberDTO memberDTO, SqlSession session)  throws Exception;
	
	public int updateMember(MemberDTO memberDTO, SqlSession session)  throws Exception;
	
	public int deleteMember(String id, SqlSession session) throws Exception;
	
	public int idCheck(String id, SqlSession session) throws Exception;
	
	public List<MemberDTO> searchMemberList(PagingVO pagingVO, SqlSession session)  throws Exception;
	
/*	public int getMemberListCount(SqlSession session, Criteria cri) throws Exception;

	public List<MemberDTO> getMemberListPage(SqlSession session, Criteria cri) throws Exception;*/
	public int getMemberListCount(SqlSession session, SearchCriteria cri) throws Exception;
	
	public List<MemberDTO> getMemberListPage(SqlSession session, SearchCriteria cri) throws Exception;
	
	public int getSearchCount(PagingVO pagingVO, SqlSession session)  throws Exception;
	
/*	public MemberDTO getMember(String id) throws Exception;
	
	public int registerMember(MemberDTO memberDTO)  throws Exception;
	
	public int updateMember(MemberDTO memberDTO)  throws Exception;
	
	public int deleteMember(String id) throws Exception;
	
	public int idCheck(String id) throws Exception;
	
	public List<MemberDTO> searchMemberList(PagingVO pagingVO)  throws Exception;
	
	public int getSearchCount(PagingVO pagingVO)  throws Exception;*/

}
