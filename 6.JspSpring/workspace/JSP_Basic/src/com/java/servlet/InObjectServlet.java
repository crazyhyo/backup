package com.java.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.dto.MemberVO;

@WebServlet("/inObject")
public class InObjectServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		ServletContext application = request.getServletContext();
		
		request.setAttribute("msg", "pageContextMsg");
	    request.setAttribute("msg", "requestMsg");
	    session.setAttribute("msg", "sessionMsg");
	    application.setAttribute("msg", "applicationMsg");

	    Map<String,String> dataMap = new HashMap<String, String>();
	    dataMap.put("girlGroup", "asdf");
	    
	    request.setAttribute("dataMap", dataMap);
	    MemberVO member = new MemberVO();
	    member.setId("mimi");
	    member.setPwd("mimi");
	    request.setAttribute("member", member);
	    
	    request.getRequestDispatcher("/inObject.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
