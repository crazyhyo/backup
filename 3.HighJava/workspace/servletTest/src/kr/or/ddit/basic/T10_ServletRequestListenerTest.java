/*
 * 21/09/29 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class T10_ServletRequestListenerTest extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("ATTR1", "arrt1");     // 속성값 추가
        req.setAttribute("ATTR1", "arrt10");     // 속성값 변경
        req.setAttribute("ATTR2", "arrt2");     // 속성값 추가
        req.setAttribute("ATTR3", "arrt3");     // 속성값 추가

        req.removeAttribute("ATTR1");           // 속성값 제거
    }

}
