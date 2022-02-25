package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

public class IdCheck extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 입력
		String id = request.getParameter("id");
		
        // 처리
		IMemberService memberService = MemberServiceImpl.getInstance();
		int cnt = memberService.idCheck(id);
		
        // 출력
		request.setAttribute("cnt", cnt);
		
		request.getRequestDispatcher("/idCheck.jsp").forward(request, response);
		
	}

}
