package kr.or.ddit.company.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.cmm.vo.CompanyPagingVO;
import kr.or.ddit.company.service.CompanyServiceImpl;
import kr.or.ddit.company.service.ICompanyService;
import kr.or.ddit.company.vo.CompanyVO;


@WebServlet("/CompanyPagingList.do")
public class CompanyPagingList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		CompanyPagingVO companyPagingVO = new CompanyPagingVO();
		
		int currentPageNo = req.getParameter("currentPageNo") == null ?
				0 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		ICompanyService companyService = CompanyServiceImpl.getInstance();
		
		int totalCount = companyService.getTotalCompanyCount();
		
		companyPagingVO.setCurrentPageNo(currentPageNo);
		
		companyPagingVO.setTotalCount(totalCount);
		
		List<CompanyVO> companyPagingList = companyService.companyPagingList(companyPagingVO);
		
		req.setAttribute("companyPagingList", companyPagingList);
		
		req.getRequestDispatcher("/WEB-INF/jsp/companyPagingList.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}
}
