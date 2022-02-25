package com.jsp.dao;

import java.util.List;
import com.jsp.dto.MemberVO;

import org.apache.ibatis.session.SqlSession;

public interface MemberDAO {

  public abstract List<MemberVO> selectMemberList(SqlSession session) throws Exception;

}
