package com.java.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class TestServlet extends HttpServlet{

	@Override
	public void destroy() {
		System.out.println("destroy...");
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init...");
		String message = config.getInitParameter("message");
		System.out.println(message);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
        System.out.println("doGet()");
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
        System.out.println("doPost()");
		
	}
	
}
