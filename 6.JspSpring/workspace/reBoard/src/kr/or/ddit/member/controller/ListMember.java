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

// 회원 목록 화면을  출력한다
// 사용자가 검색한 경우 searchKey와 searchWord에 값을 할당하고
// 검색하지 않은 경우 빈 스트링이 할당된다
public class ListMember extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
        // 입력
		Integer page = req.getParameter("page") == null?
				1 : Integer.parseInt(req.getParameter("page"));
		String searchKey    = req.getParameter("searchKey");
		String searchWord   = req.getParameter("searchWord");
		
        // getSearchCount를 수행하기 위한 pagingVO 설정
        // 이를 통해 페이징에 필요한 numMember를 얻는다
		PagingVO pagingVO = new PagingVO();
		
		pagingVO.setCurrentPageNo(page);
		pagingVO.setSearchKey(searchKey);
		pagingVO.setSearchWord(searchWord);
		
		IMemberService memberService = MemberServiceImpl.getInstance();

		int numMember = memberService.getSearchCount(pagingVO);
		
		pagingVO.setTotalCount(numMember);
		
        // 현재 페이지에 출력되는 회원들
		List<MemberDTO> members = memberService.searchMemberList(pagingVO);
		
        // 출력
		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchWord", searchWord);
		req.setAttribute("pagingVO", pagingVO);
		req.setAttribute("members", members);
		req.setAttribute("page", page);
		
        req.getRequestDispatcher("/memberList.jsp?page=" + page).forward(req, resp);			
	}
}
