package com.jsp.service;

import java.util.List;
import com.jsp.dto.MemberVO;

public interface MemberService{

  public List<MemberVO> getMemberList() throws Exception;

}
