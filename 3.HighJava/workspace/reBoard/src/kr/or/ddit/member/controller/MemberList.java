package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;

public class MemberList extends HttpServlet{
	

    @Override
    public void init(ServletConfig config) throws ServletException{

        String urlPath = config.getInitParameter("urlPatterns.properties");

        String jspPath = config.getInitParameter("jspPath.properties");
        
        Properties urlProperties = new Properties();
        Properties jspProperties = new Properties();
        Reader reader1;
        Reader reader2;
		try {
			reader1 = Resources.getResourceAsReader(urlPath);
			urlProperties.load(reader1);
			reader2 = Resources.getResourceAsReader(jspPath);
			jspProperties.load(reader2);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
        ServletContext application = config.getServletContext();
        application.setAttribute("deleteUrl", urlProperties.getProperty("url.deleteMember"));
        application.setAttribute("idCheckUrl", urlProperties.getProperty("url.idcheck"));
        application.setAttribute("detailUrl", urlProperties.getProperty("url.detailMember"));
        application.setAttribute("listUrl", urlProperties.getProperty("url.listMember"));
        application.setAttribute("registUrl", urlProperties.getProperty("url.registMember"));
        application.setAttribute("searchUrl", urlProperties.getProperty("url.searchMember"));
        application.setAttribute("updateUrl", urlProperties.getProperty("url.updateMember"));

        application.setAttribute("listJsp", jspProperties.getProperty("jspPath.list"));
        application.setAttribute("detailJsp", jspProperties.getProperty("jspPath.detail"));
        application.setAttribute("errorJsp", jspProperties.getProperty("jspPath.error"));
        application.setAttribute("idCheckJsp", jspProperties.getProperty("jspPath.idCheck"));

    }
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		Integer currentPageNo = req.getParameter("currentPageNo") == null?
				1 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		HttpSession session = req.getSession();
		
		session.setAttribute("currentPageNo", currentPageNo);
		
		if(currentPageNo == 0) {
		
			IMemberService memberService = MemberServiceImpl.getInstance();
			
			List<MemberDTO> memberList = memberService.getMemberList();
			
			req.setAttribute("memberList", memberList);
			
			req.getRequestDispatcher((String)req.getServletContext().getAttribute("listJsp")).forward(req, resp);
		}else {
			IMemberService memberService = MemberServiceImpl.getInstance();
			
			PagingVO pagingVO = new PagingVO();
			
			int totalCount = memberService.getMemberCount();
			
			pagingVO.setCurrentPageNo(currentPageNo);
			pagingVO.setTotalCount(totalCount);
			
			List<MemberDTO> memberPagingList = memberService.getMemberPagingList(pagingVO);
			
			req.setAttribute("memberList", memberPagingList);
			
			req.setAttribute("pagingVO", pagingVO);
			
			req.setAttribute("isSearch", false);
			
			req.getRequestDispatcher((String)req.getServletContext().getAttribute("listJsp")).forward(req, resp);			
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
