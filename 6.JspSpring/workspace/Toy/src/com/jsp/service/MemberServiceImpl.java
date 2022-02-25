package com.jsp.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.List;
import com.jsp.dto.MemberVO;
import com.jsp.dao.MemberDAOImpl;
import com.jsp.dao.MemberDAO;

public class MemberServiceImpl implements MemberService{

  private SqlSessionFactory factory;
  private MemberDAO memberDAO;
  public void setSqlSessionFactory(SqlSessionFactory factory) {
    this.factory = factory;
  }
  public void setMemberDAO(MemberDAO memberDAO) {
    this.memberDAO = memberDAO;
  }

  @Override
  public List<MemberVO> getMemberList() throws Exception{

    SqlSession session = factory.openSession(false);
    List<MemberVO> memberList = null;

    try{
       memberList = memberDAO.selectMemberList(session);
       session.commit();

    } catch(Exception e){
      session.rollback();
      e.printStackTrace();

      throw e;
    }

    return memberList;

  }

}
