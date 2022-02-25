package com.jsp.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import com.jsp.dto.MemberVO;

import java.io.IOException;
import java.util.List;
import com.jsp.service.MemberServiceImpl;
import com.jsp.service.MemberService;
import com.jsp.dao.MemberDAO;
import com.jsp.dao.MemberDAOImpl;
import com.jsp.dataSource.OracleMyBatisSqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactory;

public class MemberListServlet extends HttpServlet{

  private MemberService memberService = new MemberServiceImpl();

  {
    SqlSessionFactory factory = new OracleMyBatisSqlSessionFactory();
    MemberDAO memberDAO = new MemberDAOImpl();

    ((MemberServiceImpl)memberService).setMemberDAO(memberDAO);
    ((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{

    String url = "/member/list.jsp";
    List<MemberVO> memberList = null;
    try{
      memberList = memberService.getMemberList();
      request.setAttribute("memberList", memberList);
    } catch(Exception e){
      url = "/error/500.jsp";
    }
    request.getRequestDispatcher(url).forward(request, response);

  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{

  }
}
