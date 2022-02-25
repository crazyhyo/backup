package com.jsp.service;

import com.jsp.service.MemberService;
import com.jsp.service.MemberServiceImpl;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSession;
import java.io.Reader;
import org.junit.Test;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import com.jsp.service.MockMemberDAOImpl;
import java.util.List;
import com.jsp.dto.MemberVO;
import java.io.Reader;
import org.junit.Assert;


public class TestMemberServiceImpl{

  private MemberService memberService = new MemberServiceImpl();

  private SqlSessionFactory factory;
  private SqlSession session;

  {

    String path = "com/jsp/myBatis/config/sqlConfig.xml";

    try{
      Reader reader = Resources.getResourceAsReader(path);
      factory = new SqlSessionFactoryBuilder().build(reader);
      reader.close();
    } catch(Exception e){
      e.printStackTrace();
    }

    ((MemberServiceImpl)memberService).setMemberDAO(new MockMemberDAOImpl());
    ((MemberServiceImpl)memberService).setSqlSessionFactory(factory);

    session = factory.openSession();

  }

  @Test
  public void testGetMemberList() throws Exception{

    List<MemberVO> memberList = memberService.getMemberList();

    Assert.assertEquals(10, memberList.size());
    Assert.assertEquals("kk0", memberList.get(0).getId());
  }

}
