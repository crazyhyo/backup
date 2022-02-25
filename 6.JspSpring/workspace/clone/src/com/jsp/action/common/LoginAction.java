package com.jsp.action.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jsp.action.Action;
import com.jsp.exception.InvalidPasswordException;
import com.jsp.exception.NotFoundIDException;
import com.jsp.service.MemberServiceForModify;

public class LoginAction implements Action{
	
	private MemberServiceForModify memberServiceForModify;
	public void setMemberServiceForModify(MemberServiceForModify memberServiceForModify) {
		this.memberServiceForModify = memberServiceForModify;
	}


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "redirect:/index.do";

		//입력
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		try {
			memberServiceForModify.login(id, pwd);
			
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", memberServiceForModify.getMember(id));
			session.setMaxInactiveInterval(6 * 60);

		} catch (NotFoundIDException | InvalidPasswordException e) {
			e.printStackTrace();
			
			System.out.println("is Here????????");
			
			request.setAttribute("message", e.getMessage());
			url = "/common/login_fail";
			return url;
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
		return url;
	}
	

}
