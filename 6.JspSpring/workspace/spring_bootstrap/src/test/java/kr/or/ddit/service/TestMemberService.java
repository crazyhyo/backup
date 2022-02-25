package kr.or.ddit.service;

import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.MemberVO;
import com.jsp.service.MemberServiceForModify;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:kr/or/ddit/context/root-context.xml")
public class TestMemberService {

	//@Resource(name="memberServiceForModify")
	/*
	@Autowired
	@Qualifier(value="memberServiceForModify")
	
	이후 application-context의 해당 bean 찾아서
	<qualifier name?="memberServiceForModify" />
	를 추가해 주어야 함
	즉, 안쓴다.
	*/
	
	@Autowired
	private MemberServiceForModify service;
	
	{
/*		ApplicationContext applicationContext = new GenericXmlApplicationContext("classpath:kr/or/ddit/context/root-context.xml");
		applicationContext.getBean(MemberServiceForModifyImpl.class);*/
	}
	
	@Before
	public void init() {
		
	}
	
	@Test
	public void testGetList() throws Exception{
		/*
		ApplicationContext ctx = new GenericXmlApplicationContext("classpath:kr/or/ddit/context/root-context.xml");
//		service = ctx.getBean("memberServiceForModify", MemberServiceForModifyImpl.class); 
		service = ctx.getBean(MemberServiceForModifyImpl.class); 
		*/
		SearchCriteria cri = new SearchCriteria();
		
		List<MemberVO> memberList = (List<MemberVO>)service.getMemberListPage(cri).get("memberList");
		
		Assert.assertEquals(10, memberList.size());
	}
	
	
}
