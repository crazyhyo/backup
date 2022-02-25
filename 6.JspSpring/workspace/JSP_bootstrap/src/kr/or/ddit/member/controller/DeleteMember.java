package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
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

public class DeleteMember extends HttpServlet{
	
	private IMemberService memberService = InitMemberService.initMemberService();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

        // 입력
		String id = req.getParameter("id");
        
        // 처리
		int numDelete;
		try {
			numDelete = memberService.deleteMember(id);
			if(numDelete == 0) {
	            // 삭제 실패
	            // 처리
	            MemberDTO member = new MemberDTO();
				member = memberService.getMember(id);

	            // 출력
	            req.setAttribute("commandName", "삭제");
	            req.setAttribute("flag", "fail");
				req.setAttribute("member", member);
	            req.setAttribute("failUrl", "/JSP_bootstrap/detail?id=" + id);
				req.getRequestDispatcher("/message").forward(req, resp);

			}else {

	            // 삭제 성공
	            // 출력
	            req.setAttribute("commandName", "삭제");
	            req.setAttribute("flag", "success");
	            req.setAttribute("successUrl", "/JSP_bootstrap/list");
				req.getRequestDispatcher("/message").forward(req, resp);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
