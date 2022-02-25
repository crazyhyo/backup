package com.jsp.service;

import com.jsp.dto.MemberVO;
import java.util.List;
import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import com.jsp.dao.MemberDAO;

public class MockMemberDAOImpl implements MemberDAO{

  @Override
  public List<MemberVO> selectMemberList(SqlSession session) throws Exception{

    List<MemberVO> memberList = new ArrayList<MemberVO>();

    for(int i = 0; i < 10; i++){
      memberList.add(new MemberVO("kk"+i,"kk"+i));
    }

    return memberList;

  }


}

