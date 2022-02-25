package kr.or.ddit.basic;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class T11_HttpSessionListenerTest extends HttpServlet{

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    // HttpSession 객체 생성 및 소멸관련 테스트
    HttpSession session = req.getSession(); // req.getSession(true)와 같음

    session.setAttribute("ATTR1", "attr1");
    session.setAttribute("ATTR1", "attr11");
    session.setAttribute("ATTR2", "attr2");

    session.removeAttribute("ATTR1");

    // HTTP 세션 영역 내에 HttpSessionBindingListener를 구현한 객체가
    // 바인딩 되면 호출됨.
    MySessionBindingListener bindingListener
      = new MySessionBindingListener();
    session.setAttribute("obj", bindingListener);
    session.removeAttribute("obj");

    session.invalidate(); // 세션객체 삭제
    

  }

  /*
   * 이 메서드가 있는 것과 없는 것의 차이점:
   * 이 메서드가 있으면 200 code가 나오고
   * 이 메서드가 없으면 [post로 서블릿이 요청될 때] 405 code가 나온다(not supported method)
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    doGet(req, resp);
  }

}
