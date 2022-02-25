package kr.or.ddit.member.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/MemberJoin.do")
public class MemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("UTF-8");
		
		MemberVO memVO = new MemberVO();
		
		try {
			BeanUtils.populate(memVO, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		
		// 1. service 객체 생성
		IMemberService service = MemberServiceImpl.getInstance();
		
		int result = 0;
		
		// 2. service메서드 호출하기 - 결과값 받기
		String memId = "";
		
		// 3. 결과값 request에 저장
		req.setAttribute("memId", memId);
		
		// 4. jsp로 forward하기
		if(result == -1) {
			req.getRequestDispatcher("home/login.jsp").forward(req, resp);
		} else { // 회원가입 success 페이지로 이동
			req.getRequestDispatcher("home/joinCompleted.html").forward(req, resp);
		}
	}

}
