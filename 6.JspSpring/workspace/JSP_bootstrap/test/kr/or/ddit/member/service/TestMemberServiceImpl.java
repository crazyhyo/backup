package kr.or.ddit.member.service;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.OracleMyBatisSqlSessionFactory;
import kr.or.ddit.util.PageMaker;
import kr.or.ddit.util.SearchCriteria;
import kr.or.ddit.util.SingletonOracleMyBatisSqlSessionFactory;

public class TestMemberServiceImpl {

	SqlSession session;
	SqlSessionFactory factory;
	IMemberDao memberDao;
	
	IMemberService memberService;
	
	
	
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
		memberDao = MemberDaoImpl.getInstance();
		memberService = MemberServiceImpl.getInstance();
		
		((MemberServiceImpl)memberService).setMemberDao(memberDao);
		((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
	}
	
	@Test
	public void testGetMember() throws Exception {
		MemberDTO member = memberService.getMember("mimi");
		
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
		int cnt = memberService.registerMember(member);
		
		Assert.assertEquals(cnt, 1);
	}
	@Test
	public void testUpdateMember() throws Exception {
		MemberDTO member = new MemberDTO();
		member.setId("lala");
		member.setPwd("pwd");
		member.setEmail("email");
		member.setPhone("phone");
		member.setName("UPname");
		member.setAddress("address");
		member.setAuthority("authority");
		member.setEnabled(2);
		member.setRegdate("2021-12-14");
		member.setRegister("register");
		
		int cnt = memberService.updateMember(member);
		
		Assert.assertEquals(cnt, 1);
	}
	@Test
	public void testIdCheck() throws Exception {
		int cnt2 = memberService.idCheck("mimi");
		
		Assert.assertEquals(cnt2, 1);
	}
	

	@Test
	public void testSearchMemberList() throws Exception {
		
		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setSearchKey("id");
		pagingVO.setSearchWord("mimi");
		pagingVO.setCurrentPageNo(1);
		pagingVO.setTotalCount(7);
		
		List<MemberDTO> members = memberService.searchMemberList(pagingVO);
		
		Assert.assertEquals(1, members.size());
	}
	@Test
	public void testGetSearchCount() throws Exception {
		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setSearchKey("id");
		pagingVO.setSearchWord("mimi");
		int cnt = memberService.getSearchCount(pagingVO);
		
		Assert.assertEquals(1, cnt);
	}
	@Test
	public void testDeleteMember() throws Exception {
		int cnt = memberService.deleteMember("id");
		
		Assert.assertEquals(cnt, 1);
	}
	
	@Test
	public void testGetMemberListPage() throws Exception {
		
		SearchCriteria cri = new SearchCriteria();
		
		Map<String, Object> dataMap = memberService.getMemberListPage(cri);
		List<MemberDTO> members = (List<MemberDTO>)dataMap.get("members");
		PageMaker pageMaker = (PageMaker)dataMap.get("pageMaker");
		
		Assert.assertEquals(2, dataMap.size());
		Assert.assertEquals(7, members.size());
		Assert.assertEquals(7, pageMaker.getTotalCount());
	}
	
	
}
