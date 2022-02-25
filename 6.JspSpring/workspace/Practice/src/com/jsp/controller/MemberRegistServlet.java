package com.jsp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.javassist.compiler.ast.Member;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jsp.command.MemberRegistCommand;
import com.jsp.dao.MemberDAO;
import com.jsp.dao.MemberDAOImpl;
import com.jsp.dataSource.OracleMyBatisSqlSessionFactory;
import com.jsp.dto.MemberVO;
import com.jsp.exception.NotDateException;
import com.jsp.exception.NotNumberException;
import com.jsp.service.MemberService;
import com.jsp.service.MemberServiceImpl;
import com.jsp.service.SearchMemberServiceImpl;

@WebServlet("/member/regist")
public class MemberRegistServlet extends HttpServlet{
	
	private MemberService memberService;
	
	{
		memberService = new SearchMemberServiceImpl();
		SqlSessionFactory factory = new OracleMyBatisSqlSessionFactory();
		MemberDAO memberDAO = new MemberDAOImpl();
		((MemberServiceImpl)memberService).setMemberDAO(memberDAO);
		((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/regist.jsp";
		request.getRequestDispatcher(url).forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/regist_success.jsp";
		MemberVO member = null;
		try {
			MemberRegistCommand command = (MemberRegistCommand)HttpRequestParameterAdapter.execute(request, MemberRegistCommand.class);
			
			member = command.toMemberVO();
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		try {
			memberService.regist(member);
		} catch (Exception e) {
			url = "/member/regist_fail.jsp";
			e.printStackTrace();
		}
		
		request.getRequestDispatcher(url).forward(request, response);
		
	}

}
