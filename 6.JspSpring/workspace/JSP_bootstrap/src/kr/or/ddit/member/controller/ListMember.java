package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.InitMemberService;
import kr.or.ddit.util.OracleMyBatisSqlSessionFactory;
import kr.or.ddit.util.SearchCriteria;
import kr.or.ddit.util.SingletonOracleMyBatisSqlSessionFactory;

// 회원 목록 화면을  출력한다
// 사용자가 검색한 경우 searchKey와 searchWord에 값을 할당하고
// 검색하지 않은 경우 빈 스트링이 할당된다
public class ListMember extends HttpServlet{

	
	IMemberService memberService;
	{
		memberService = MemberServiceImpl.getInstance();
		SqlSessionFactory factory = new OracleMyBatisSqlSessionFactory();
		IMemberDao memberDao = MemberDaoImpl.getInstance();
		((MemberServiceImpl)memberService).setMemberDao(memberDao);
		((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
	}
	
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
		Integer perPageNum 	= req.getParameter("perPageNum") == null?
				10 : Integer.parseInt(req.getParameter("perPageNum"));
		
		try {
//			Criteria cri = new Criteria();
			SearchCriteria cri = new SearchCriteria(page, perPageNum, searchKey, searchWord);
//			cri.setSearchKey(searchKey);
//			cri.setSearchWord(searchWord);
//			cri.setPage(page);
//			cri.setPerPageNum(perPageNum);
			
			Map<String, Object> dataMap = memberService.getMemberListPage(cri);
			
			req.setAttribute("dataMap", dataMap);
			
			req.getRequestDispatcher("/memberList.jsp").forward(req, resp);
			
		} catch(Exception e) {
			
			e.printStackTrace();
			req.getRequestDispatcher("/error.jsp").forward(req, resp);
		}
			
	}
}
