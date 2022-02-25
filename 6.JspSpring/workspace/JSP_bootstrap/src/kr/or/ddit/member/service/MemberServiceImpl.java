package kr.or.ddit.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.PageMaker;
import kr.or.ddit.util.SearchCriteria;

public class MemberServiceImpl implements IMemberService{
	

	private SqlSessionFactory factory;
	private IMemberDao memberDao;
	
	private static IMemberService memberService;
	
	public void setSqlSessionFactory(SqlSessionFactory factory) {
		this.factory = factory;
	}
	public void setMemberDao(IMemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	private MemberServiceImpl() {}
	public static IMemberService getInstance() {
		if(memberService == null) {
			System.out.println("최초 service 객체 생성 및 반환");
			memberService = new MemberServiceImpl();
			return memberService;
		}else {
			System.out.println("기존 service객체 반환");
			return memberService;
		}
	}
	
	@Override
	public MemberDTO getMember(String id) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.getMember(id, session);
	}
	@Override
	public int registerMember(MemberDTO memberDTO) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.registerMember(memberDTO, session);
	}
	@Override
	public int updateMember(MemberDTO memberDTO) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.updateMember(memberDTO, session);
	}
	@Override
	public int deleteMember(String id) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.deleteMember(id, session);
	}
	@Override
	public int idCheck(String id) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.idCheck(id, session);
	}
	@Override
	public List<MemberDTO> searchMemberList(PagingVO pagingVO) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.searchMemberList(pagingVO, session);
	}
	@Override
	public int getSearchCount(PagingVO pagingVO) throws Exception {
		SqlSession session = factory.openSession();
		return memberDao.getSearchCount(pagingVO, session);
	}
	
	@Override
	public Map<String, Object> getMemberListPage(SearchCriteria cri) throws Exception {
		
		Map<String, Object> dataMap = null;
		
		SqlSession session = factory.openSession();
		
		try {
			
			List<MemberDTO> members = null;
			PageMaker pageMaker = null;
			
			members = memberDao.getMemberListPage(session, cri);
			pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(memberDao.getMemberListCount(session, cri));
			
			dataMap = new HashMap<String, Object>();
			
			dataMap.put("members", members);
			dataMap.put("pageMaker", pageMaker);
			
			session.commit();
		} catch(Exception e) {
			session.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
		
		return dataMap;
	}
	
	/*@Override
	public Map<String, Object> getMemberListPage(Criteria cri) throws Exception {
		
		Map<String, Object> dataMap = null;
		
		SqlSession session = factory.openSession();
		
		try {
			
			List<MemberDTO> members = null;
			PageMaker pageMaker = null;
			
			members = memberDao.getMemberListPage(session, cri);
			pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(memberDao.getMemberListCount(session, cri));
			
			dataMap = new HashMap<String, Object>();
			
			dataMap.put("members", members);
			dataMap.put("pageMaker", pageMaker);
			
			session.commit();
		} catch(Exception e) {
			session.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
		
		return dataMap;
	}
	*/
	
	
}
