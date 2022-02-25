package com.jsp.dao;

import java.io.Reader;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Before;
import org.junit.After;
import org.junit.Assert;
import org.junit.Test;
import com.jsp.dao.MemberDAO;
import com.jsp.dao.MemberDAOImpl;
import java.util.List;
import com.jsp.dto.MemberVO;

public class TestMemberDAOImpl{

  private SqlSession session;
  private MemberDAO memberDAO = new MemberDAOImpl();
  private SqlSessionFactory factory;

  {

    String path = "com/jsp/myBatis/config/sqlConfig.xml";

    try{
      Reader reader = Resources.getResourceAsReader(path);
      factory = new SqlSessionFactoryBuilder().build(reader);
      reader.close();
    } catch(Exception e){
      e.printStackTrace();
    }

  }

  @Before
  public void openSqlSession(){
    session = factory.openSession();
  }

  @After
  public void closeSession(){
    session.close();
  }

  @Test
  public void testSQL() throws Exception{
    List<MemberVO> memberList = memberDAO.selectMemberList(session);
    Assert.assertEquals(7, memberList.size());
  }

}
