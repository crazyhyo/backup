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
import kr.or.ddit.util.InitMemberService;

public class DetailMember extends HttpServlet{
	
	private IMemberService memberService = InitMemberService.initMemberService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
        // 입력
		String id = req.getParameter("id");
		Integer page = req.getParameter("page") == null?
				1 : Integer.parseInt(req.getParameter("page"));
		
        // id 정보 없이 상세페이지에 오면 error 페이지로 연결한다
		if(id == null) {
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}else {
            // 처리
			MemberDTO member;
			try {
				member = memberService.getMember(id);
				int statusCode = member.getEnabled();
				String status = "";
				if(statusCode == 1) {
					status = "재직";
				}else if(statusCode == 0) {
					status = "퇴직";
				}else if(statusCode == 2) {
					status = "휴직";
				}
				
	            // 출력
				req.setAttribute("member", member);
				req.setAttribute("status", status);
	            req.setAttribute("page", page);
				
				req.getRequestDispatcher("/memberDetail.jsp").forward(req, resp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
