package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;

public class SearchMember extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		Integer currentPageNo = req.getParameter("currentPageNo") == null?
				1 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		String searchTag = req.getParameter("searchTag");
		String search = req.getParameter("search");
		
		req.setAttribute("searchTag", searchTag);
		req.setAttribute("search", search);
		
		PagingVO pagingVO = new PagingVO();
		
		if(searchTag.equals("id")) {
			pagingVO.setId(search);
		}else if(searchTag.equals("email")) {
			pagingVO.setEmail(search);
		}else if(searchTag.equals("phone")) {
			pagingVO.setPhone(search);
		}else if(searchTag.equals("name")) {
			pagingVO.setName(search);
		}
		
		pagingVO.setCurrentPageNo(currentPageNo);
		
		int totalCount = memberService.getSearchCount(pagingVO);
		
		pagingVO.setTotalCount(totalCount);
		
		List<MemberDTO> memberList = memberService.searchMemberList(pagingVO);
		
		req.setAttribute("pagingVO", pagingVO);
		
		req.setAttribute("memberList", memberList);
		
		req.setAttribute("isSearch", true);
		
		req.getRequestDispatcher((String)req.getServletContext().getAttribute("listJsp")).forward(req, resp);
	}
}
