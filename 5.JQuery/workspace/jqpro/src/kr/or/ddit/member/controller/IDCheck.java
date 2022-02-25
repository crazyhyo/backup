package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

@WebServlet("/IDCheck.do")
public class IDCheck extends HttpServlet{
	
	private static final long serialVersionID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String userId = req.getParameter("idvalue");
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		if(memberService.selectByMemId(userId) == null && userId != null) {
			req.setAttribute("userId", userId);
		}
		
		req.getRequestDispatcher("1005/idcheck.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
