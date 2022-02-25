package kr.or.ddit.member.dao;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.OracleMyBatisSqlSessionFactory;
import kr.or.ddit.util.SearchCriteria;
import kr.or.ddit.util.SingletonOracleMyBatisSqlSessionFactory;

public class TestMemberDaoImpl {

	SqlSession session;
	SqlSessionFactory factory;
	IMemberDao memberDao;
	
	{
//		String xmlPath = "com/jsp/myBatis/config/sqlConfig.xml";
//		try {
//			Reader reader = Resources.getResourceAsReader(xmlPath);
//			factory = new SqlSessionFactoryBuilder().build(reader);
//			reader.close();
//		} catch (IOException e) {
//			System.out.println("session build fails");
//			e.printStackTrace();
//		}
		factory = SingletonOracleMyBatisSqlSessionFactory.getInstance();
	}
	
	@Test
	public void testGetMember() throws Exception {
		MemberDTO member = memberDao.getMember("mimi", session);
		
		Assert.assertEquals("mimi", member.getId());
	}
	@Test
	public void testRegisterMember() throws Exception {
		
		MemberDTO member = new MemberDTO();
		member.setId("id");
		member.setPwd("pwd");
		member.setEmail("email");
		member.setPhone("phone");
		member.setName("name");
		member.setAddress("address");
		member.setAuthority("authority");
		member.setEnabled(2);
		member.setRegdate("2021-12-12");
		member.setRegister("register");		
		int cnt = memberDao.registerMember(member, session);
		
		Assert.assertEquals(cnt, 1);
	}
	@Test
	public void testUpdateMember() throws Exception {
		MemberDTO member = new MemberDTO();
		member.setId("momo");
		member.setPwd("momo");
		member.setEmail("momo@naver.com");
		member.setPhone("01012341234");
		member.setName("세레나");
		member.setAddress("address");
		member.setAuthority("ROLE_USER");
		member.setEnabled(1);
		member.setRegdate("2020/08/17");
		member.setRegister("mimi");
		
		int cnt = memberDao.updateMember(member, session);
		
		Assert.assertEquals(cnt, 1);
	}
	@Test
	public void testIdCheck() throws Exception {
		int cnt2 = memberDao.idCheck("mimi", session);
		
		Assert.assertEquals(cnt2, 1);
	}
	

	@Test
	public void testSearchMemberList() throws Exception {
		
		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setSearchKey("id");
		pagingVO.setSearchWord("mimi");
		pagingVO.setCurrentPageNo(1);
		pagingVO.setTotalCount(7);
		
		List<MemberDTO> members = memberDao.searchMemberList(pagingVO, session);
		
		Assert.assertEquals(1, members.size());
	}
	@Test
	public void testGetSearchCount() throws Exception {
		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setSearchKey("id");
		pagingVO.setSearchWord("mimi");
		int cnt = memberDao.getSearchCount(pagingVO, session);
		
		Assert.assertEquals(1, cnt);
	}
	@Test
	public void testDeleteMember() throws Exception {
		int cnt = memberDao.deleteMember("id", session);
		
		Assert.assertEquals(cnt, 1);
	}
	
	
	
	@Test
	public void testGetMemberListCount() throws Exception {
		SearchCriteria cri = new SearchCriteria();
		String searchKey = "id";
		String searchWord = "m";
		
		cri.setSearchKey(searchKey);
		cri.setSearchWord(searchWord);
		
		int cnt = memberDao.getMemberListCount(session, cri);
		
		Assert.assertEquals(5, cnt);
	}
	
	@Test
	public void testGetMemberListPage() throws Exception {
		
		SearchCriteria cri = new SearchCriteria();
		String searchKey = "phone";
		String searchWord = "-";
		
		cri.setSearchKey(searchKey);
		cri.setSearchWord(searchWord);
		
		cri.setPerPageNum(2);
		
		List<MemberDTO> memberListPage = memberDao.getMemberListPage(session, cri);
		
		Assert.assertEquals(2, memberListPage.size());
		Assert.assertEquals("remon", memberListPage.get(0).getId());
	}
	@Before
	public void initSession() {
		session = factory.openSession(true);
		
		memberDao = MemberDaoImpl.getInstance();
	}
	
	@After
	public void closeSession() {
		session.close();
	}
}
