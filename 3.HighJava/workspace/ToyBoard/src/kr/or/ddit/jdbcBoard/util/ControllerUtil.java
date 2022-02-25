package kr.or.ddit.jdbcBoard.util;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.jdbcBoard.service.IJdbcBoardService;
import kr.or.ddit.jdbcBoard.service.JdbcBoardServiceImpl;

public final class ControllerUtil {
	
  private static ControllerUtil controller;

  private ControllerUtil() {}

  public ControllerUtil getInstance(){
    if(controller == null){
      controller = new ControllerUtil();
    }
    return controller;
  }

  private static String prefix = "/WEB-INF/views/";
  private static String suffix = ".jsp";
  

  public static void forwardURL(String fileName, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

    req.getRequestDispatcher(prefix + fileName + suffix).forward(req, resp);

  }
  
  public static void forwardServlet(String url, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
	  req.getRequestDispatcher(url).forward(req, resp);
  }
  
  public static void redirectServlet(String url, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
	 resp.sendRedirect(req.getContextPath() + url);
  }


}
