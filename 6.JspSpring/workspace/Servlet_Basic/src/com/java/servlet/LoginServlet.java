package com.java.servlet;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java.utils.Message;
import com.java.view.View;

public class LoginServlet extends HttpServlet{

	Message message;
	
    @Override
	public void init(ServletConfig config) throws ServletException {
    	String propertiesPath = config.getInitParameter("message.properties");
    	
    	message = Message.getInstance();
    	try {
			message.initMessage(propertiesPath);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{

        View.loginForm(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
    	
    	String id = request.getParameter("id");
    	String pwd = request.getParameter("pwd");
    	boolean result = true;
    	
    	result = id.equals("mimi") && pwd.equals("mimi");
    	
    	if(result) {
    		View.alert(response, message.getMessage("message.loginSuccess"));
    	}else {
    		View.alert(response, message.getMessage("message.loginFail"));
    		View.loginForm(request, response);
    	}
    	
    }
}
