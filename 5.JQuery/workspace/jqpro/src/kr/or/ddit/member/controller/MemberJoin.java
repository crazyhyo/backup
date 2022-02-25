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
public class MemberJoin extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		MemberVO mv = new MemberVO();
		
		try {
			BeanUtils.populate(mv, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
//		mv.setMem_id(req.getParameter("mem_id"));
//		mv.setMem_add1(req.getParameter("mem_add1"));
//		mv.setMem_add2(req.getParameter("mem_add2"));
//		mv.setMem_bir(req.getParameter("mem_bir"));
//		mv.setMem_pass(req.getParameter("mem_pass"));
//		mv.setMem_mail(req.getParameter("mem_mail"));
//		mv.setMem_hp(req.getParameter("mem_hp"));
//		mv.setMem_zip(req.getParameter("mem_zip"));
//		mv.setMem_name(req.getParameter("mem_name"));
		
		String mem_id = memberService.insertMember(mv);
		
		req.setAttribute("mem_id", mem_id);
		
		req.getRequestDispatcher("/1005/insert.jsp").forward(req, resp);
		
		
	}

}
