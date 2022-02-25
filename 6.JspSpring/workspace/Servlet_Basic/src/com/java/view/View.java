package com.java.view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class View{

    public static void loginForm(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException{
        response.setContentType("text/html;charset=utf-8");

        PrintWriter out = response.getWriter();

        String id = request.getParameter("id") != null?
        		request.getParameter("id") : "";
        String pwd = request.getParameter("pwd") !=null?
        		request.getParameter("pwd") : "";

        header(response, "LoginForm");
        out.println("<body>");
        out.println("<form action='login' method='post'>");
        out.println("아이디 : <input type='text' name='id' value='" + id +"' /><br/>");
        out.println("패스워드 : <input type='password' name='pwd' value='" + pwd +"' /><br/>");
        out.println("<input type='submit' value='로그인' />");
        out.println("</form>");
        footer(out);
    }

    private static void header(HttpServletResponse response, String title) 
    	throws IOException, ServletException{
    	
        response.setContentType("text/html;charset=utf-8");

        PrintWriter out = response.getWriter();
    	
        out.println("<!DOCTYPE html>");
        out.println("<head>");
        out.println("<title>");
        out.println(title);
        out.println("</title>");
        out.println("</head>");
    	
    }
    
    private static void footer(PrintWriter out) 
    		throws IOException, ServletException{
	        out.println("</body>");
	        out.println("</html>");
    }

	public static void alert(HttpServletResponse response, String message) 
			throws IOException, ServletException{
		response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('" + message + "')");
        out.println("</script>");
	}
}
