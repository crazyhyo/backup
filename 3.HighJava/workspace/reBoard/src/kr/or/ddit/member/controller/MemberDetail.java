package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;

public class MemberDetail extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		
		if(id == null) {
			req.getRequestDispatcher((String)req.getServletContext().getAttribute("errorJsp")).forward(req, resp);
		}else {
		
			IMemberService memberService = MemberServiceImpl.getInstance();
			
			MemberDTO member = memberService.getMember(id);
			
			req.setAttribute("member", member);
			
			int statusCode = member.getEnabled();
			String status = "";
			if(statusCode == 1) {
				status = "재직";
			}else if(statusCode == 0) {
				status = "퇴직";
			}else if(statusCode == 2) {
				status = "휴직";
			}
			
			req.setAttribute("status", status);
			
			req.getRequestDispatcher((String)req.getServletContext().getAttribute("detailJsp")).forward(req, resp);
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
