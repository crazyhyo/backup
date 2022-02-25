package kr.or.ddit.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.jsp.dto.MemberVO;
import com.jsp.service.MemberService;

import kr.or.ddit.utils.ExceptionLoggerHelper;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{

	private MemberService memberService;
	
	public void setMemberSerivce(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
//		UserDetails userDetail = (UserDetails)authentication.getDetails();
//		String id = userDetail.getUsername();
		String id = (String)authentication.getPrincipal(); 
		
		MemberVO loginUser = null;
		
		try {
			loginUser = memberService.getMember(id);
//			request.getSession().setAttribute("loginUser", loginUser);
		} catch(Exception e) {
			e.printStackTrace();
			ExceptionLoggerHelper.write(request, e, memberService);
			PrintWriter out = response.getWriter();
			
			// security에서 successHandler를 overriding하는 시점에서는 에러를 직접처리해주어야 한다.
			// security에서 successHandler를 overriding하는 시점에서는 빈등록하여서 memberService를 주입할 수 없다.
			
			out.println("<scrpt>");
			out.println("alert('로그인에 실패했습니다.');");
			out.println("history.go(-1);");
			out.println("</scrpt>");
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		//session.setMaxInactiveInterval(10);
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	
}
