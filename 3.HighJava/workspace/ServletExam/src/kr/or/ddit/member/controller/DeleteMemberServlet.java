/*
 * 21/10/01 
 * author : Lee KwangHyo
 */

package kr.or.ddit.member.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImp1;

@WebServlet("/member/delete.do")
public class DeleteMemberServlet extends HttpServlet{

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String memId = req.getParameter("memId");

    // 1. 서비스 객체 생성하기
    IMemberService memService = MemberServiceImp1.getInstance();

    // 2. 회원정보 조회
    int cnt = memService.deleteMember(memId);

    String msg = cnt > 0 ? "success" : "fail";

    // 3. View 화면으로 이동
    String redirectUrl = req.getContextPath() 
      + "/member/list.do?msg="
      + URLEncoder.encode(msg, "utf-8");
    resp.sendRedirect(redirectUrl);	// 목록조회화면으로 리다이렉트
  }

}
