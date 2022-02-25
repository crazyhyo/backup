package kr.or.ddit.member.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;

public class UpdateMember extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String name = req.getParameter("name");
		String address = req.getParameter("address");
		String authority = req.getParameter("authority") == ""?
				"ROLE_USER" : req.getParameter("authority");
		Integer enabled = Integer.parseInt(req.getParameter("enabled"));
		
		String regdate;
		regdate = req.getParameter("regdate") == ""?
				sdf.format(new Date()) : req.getParameter("regdate");
		
		MemberDTO member = new MemberDTO();
		
		member.setId(id);
		member.setPwd(pwd);
		member.setEmail(email);
		member.setPhone(phone);
		member.setName(name);
		member.setAddress(address);
		member.setAuthority(authority);
		member.setEnabled(enabled);
		member.setRegdate(regdate);
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		int cnt = memberService.updateMember(member); 
		
		if(cnt == 0) {
			
			req.getRequestDispatcher((String)req.getServletContext().getAttribute("errorJsp")).forward(req, resp);
			
		}else {
			
			member = memberService.getMember(id);
			
			req.setAttribute("member", member);
			
//			req.getRequestDispatcher("/memberDetail.jsp").forward(req, resp);
			resp.sendRedirect((String)req.getServletContext().getAttribute("detailUrl") + "?id=" + id);
		}		
	}
}
