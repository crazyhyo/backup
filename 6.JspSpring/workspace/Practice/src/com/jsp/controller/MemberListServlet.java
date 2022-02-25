package com.jsp.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;

import com.jsp.command.Criteria;
import com.jsp.command.SearchCriteria;
import com.jsp.dao.MemberDAO;
import com.jsp.dao.MemberDAOImpl;
import com.jsp.dataSource.OracleMyBatisSqlSessionFactory;
import com.jsp.exception.NotNumberException;
import com.jsp.service.MemberService;
import com.jsp.service.MemberServiceImpl;
import com.jsp.service.SearchMemberServiceImpl;

public class MemberListServlet extends HttpServlet{
	
	private MemberService memberService;
	
	{
		memberService = new SearchMemberServiceImpl();
		SqlSessionFactory factory = new OracleMyBatisSqlSessionFactory();
		MemberDAO memberDAO = new MemberDAOImpl();
		((MemberServiceImpl)memberService).setMemberDAO(memberDAO);
		((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		String url = "/member/list.jsp";
		
		String pageParam = request.getParameter("page");
		String perPageNumParam = request.getParameter("perPageNum");
		String searchTypeParam = request.getParameter("searchType");
		String keywordParam = request.getParameter("keyword");
		
		
		try {
			
			Criteria cri = null;
			if(pageParam != null && perPageNumParam != null) {
				cri = new SearchCriteria(pageParam, perPageNumParam, searchTypeParam, keywordParam);
			}else {
				cri = new SearchCriteria();
			}
			
//			List<MemberVO> memberList = memberService.getMemberList();
//			List<MemberVO> memberList = memberService.getMemberList(cri);
			
			Map<String, Object> dataMap = memberService.getMemberListPage(cri);
			request.setAttribute("dataMap", dataMap);
			
		}catch (NotNumberException e) {
			request.setAttribute("exception", e);
			url = "/error/message.jsp";
		}catch(Exception e) {
			url = "/error/500.jsp";
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
	}
}
