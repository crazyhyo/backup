package kr.or.ddit.member.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.InitMemberService;

public class RegisterMember extends HttpServlet{
	
	private IMemberService memberService = InitMemberService.initMemberService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

        // 입력(정규화)
		String id        = req.getParameter("id");
		String pwd       = req.getParameter("pwd");
		String email     = req.getParameter("email");
		String phone     = req.getParameter("phone");
		String name      = req.getParameter("name");
		String address   = req.getParameter("address");
		String authority = req.getParameter("authority") == ""?
				"ROLE_USER" : req.getParameter("authority");
		Integer enabled  = Integer.parseInt(req.getParameter("enabled"));
		String register  = req.getParameter("register") == ""?
				"mimi" : req.getParameter("register");
        // regdate 정규화
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String regdate   = req.getParameter("regdate") == ""?
				sdf.format(new Date()) : req.getParameter("regdate");
		
        // 처리

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
		member.setRegister(register);
		
		int numRegist;
		try {
			numRegist = memberService.registerMember(member);
			// 등록 실패시 페이징 처리된 목록화면으로 이동
			PagingVO pagingVO = new PagingVO();
			pagingVO.setCurrentPageNo(1);
			
			int numMember = memberService.getSearchCount(pagingVO);
			pagingVO.setTotalCount(numMember);
			
			if(numRegist == 0) {
	            // 등록 실패
	            // 출력
	            req.setAttribute("commandName", "등록");
	            req.setAttribute("page", 1);
	            req.setAttribute("flag", "fail");
	            req.setAttribute("failUrl", "/JSP_bootstrap/list");
				req.getRequestDispatcher("/message").forward(req, resp);
				
			}else {
	            // 등록 성공
				member = memberService.getMember(id);
	            // 출력
	            req.setAttribute("commandName", "등록");
	            req.setAttribute("page", 1);
	            req.setAttribute("flag", "success");
				req.setAttribute("member", member);
	            req.setAttribute("successUrl", "/JSP_bootstrap/detail?id=" + id);
				req.getRequestDispatcher("/message").forward(req, resp);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        
	}
}
