package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;

@WebServlet("/searchAdd2.do")
public class SearchAdd2 extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		String add2_value = req.getParameter("add2_value");
		
		List<ZipVO> zipList = memberService.selectZipCode(add2_value);
		
		req.setAttribute("zipList", zipList);
		
		req.getRequestDispatcher("1005/zipcode.jsp").forward(req, resp);
		
	}
	
}
