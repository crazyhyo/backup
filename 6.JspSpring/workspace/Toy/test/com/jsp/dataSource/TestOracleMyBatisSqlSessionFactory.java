package com.jsp.dataSource;

import static org.junit.Assert.*;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.jsp.dto.MemberVO;


public class TestOracleMyBatisSqlSessionFactory {

  private SqlSessionFactory sessionFactory = new OracleMyBatisSqlSessionFactory();
  SqlSession session;

  @Before
  public void init() {
    session = sessionFactory.openSession();
  }

  @Test
  public void sessionNotNullTest() {
    Assert.assertNotNull(session);
  }
  @Test
  public void connectionNotNullTest() {
    Assert.assertNotNull(session.getConnection());
  }

  @Test
  public void sqlTest() {

    List<MemberVO> members = session.selectList("Member-Mapper.selectMemberList");

    Assert.assertEquals(7, members.size());
  }

  @After
  public void complete() {
    session.close();
  }

}
