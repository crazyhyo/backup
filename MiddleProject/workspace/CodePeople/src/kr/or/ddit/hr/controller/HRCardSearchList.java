package kr.or.ddit.hr.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.concurrent.SynchronousQueue;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.cmm.vo.HRPagingVO;
import kr.or.ddit.hr.service.HRServiceImpl;
import kr.or.ddit.hr.service.IHRService;
import kr.or.ddit.hr.vo.HRCardVO;
import kr.or.ddit.hr.vo.HRSearchVO;

/**
 * Servlet implementation class HRCardSearchList
 */
@WebServlet("/HRCardSearchList.do")
public class HRCardSearchList extends HttpServlet {
	String prefix = "/WEB-INF/jsp/";
	String suffix = ".jsp";
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HRCardSearchList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HRSearchVO hrSearchVO = new HRSearchVO();		
		
		System.out.println(req.getParameterMap());
		try {
			BeanUtils.populate(hrSearchVO, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		System.out.println("null값");
		System.out.println(hrSearchVO==null);
		
		IHRService hrService =  HRServiceImpl.getInstance();
		int searchTotalCount = hrService.getTotalCardSearchCount(hrSearchVO);
		System.out.println("total카운트");
		System.out.println(searchTotalCount);
		
		int currentPageNo = hrSearchVO.getCurrentPageNo();
		
		
		HRPagingVO hrPagingVO = new HRPagingVO();
		
		System.out.println(currentPageNo);
		System.out.println(searchTotalCount);
		
		hrPagingVO.setCurrentPageNo(currentPageNo);
		hrPagingVO.setTotalCount(searchTotalCount);
		
		hrSearchVO.setFirstRecNo(hrPagingVO.getFirstRecNo());
		hrSearchVO.setLastRecNo(hrPagingVO.getLastRecNo());
		
		System.out.println(hrPagingVO.getFirstRecNo());
		System.out.println(hrPagingVO.getLastRecNo());
		
		List<HRCardVO> hrCardSearchList = hrService.hrCardPagingSearchList(hrSearchVO);
		System.out.println(hrSearchVO);
		
		req.setAttribute("hrCardSearchList", hrCardSearchList);
		req.setAttribute("hrPagingVO", hrPagingVO);
		req.getRequestDispatcher(prefix+"SShrCardPagingSearchList"+suffix).forward(req, resp);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
