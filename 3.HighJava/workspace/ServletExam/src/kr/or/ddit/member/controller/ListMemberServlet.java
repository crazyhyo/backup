package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.cmm.vo.PagingVO;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImp1;
import kr.or.ddit.member.vo.MemberVO;

public class ListMemberServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청 페이지 번호
		int pageNo = req.getParameter("pageNo") == null ?
				1 : Integer.parseInt(req.getParameter("pageNo"));
		// 1. 서비스 객체 생성하기
		IMemberService memService = MemberServiceImp1.getInstance();
		
		// 1.2 페이징 객체 생성
		int totalCnt = memService.getTotalCnt();
		PagingVO pagingVO = new PagingVO();
		pagingVO.setTotalCount(totalCnt);
		pagingVO.setCountPerPage(10);
		pagingVO.setPageSize(15);
		pagingVO.setCurrentPageNo(pageNo);
		
		// 2. 회원정보 조회
		List<MemberVO> memList = memService.getAllMemberList(pagingVO);
		
		req.setAttribute("memList", memList);
		req.setAttribute("pagingVO", pagingVO);
		
		// 3. 뷰페이지로 전달
		req.getRequestDispatcher("/WEB-INF/views/member/list.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	
}
