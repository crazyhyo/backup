package kr.or.ddit.dao;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.jsp.dao.MemberDAO;
import com.jsp.dto.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:kr/or/ddit/context/root-context.xml")
@Transactional
public class TestMemberDAOImpl {

	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void testSelectMember() throws Exception{
		String id = "mimi";
		
		MemberVO member = memberDAO.selectMemberById(sqlSession, id);
		
		Assert.assertEquals("mimi", member.getId());
	}
	
	@Test
	@Rollback
	public void testInsertMember() throws SQLException{
		
		MemberVO member = new MemberVO();
		member.setId("id");
		member.setPwd("pwd");
		member.setName("name");
		member.setEmail("email@mail.ail");
		member.setPhone("010-0000-0000");
		member.setPicture("noimage.jpg");
		member.setAuthority("ROLE_USER");
		member.setAddress("address");
		
		memberDAO.insertMember(sqlSession, member);
		
		MemberVO result = memberDAO.selectMemberById(sqlSession, "id");
				
		Assert.assertEquals("id", result.getId());
	}
}
