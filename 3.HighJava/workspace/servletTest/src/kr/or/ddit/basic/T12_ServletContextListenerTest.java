/*
 * 21/09/30 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class T12_ServletContextListenerTest extends HttpServlet{

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    doGet(req, resp);
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    req.getServletContext().setAttribute("ATTR1", "attr1");
    req.getServletContext().setAttribute("ATTR1", "attr11");
    req.getServletContext().setAttribute("ATTR2", "attr2");

    this.getServletContext().removeAttribute("ATTR1");

  }

}
