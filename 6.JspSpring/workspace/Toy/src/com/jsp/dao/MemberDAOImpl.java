package com.jsp.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.jsp.dto.MemberVO;
import org.apache.ibatis.session.SqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

  @Override
  public List<MemberVO> selectMemberList(SqlSession session) throws Exception {

    List<MemberVO> memberList =
      session.selectList("Member-Mapper.selectMemberList");
      return memberList;
  }

}
