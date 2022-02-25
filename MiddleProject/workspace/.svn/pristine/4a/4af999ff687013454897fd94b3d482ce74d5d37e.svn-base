package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.prod.service.IprodService;
import kr.or.ddit.prod.service.prodServiceImpl;
import kr.or.ddit.prod.vo.prodVO;

/**
 * Servlet implementation class ProdList
 */
@WebServlet("/ProdList.do")
public class ProdList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProdList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int pno = Integer.parseInt(request.getParameter("prod_no"));
		request.setCharacterEncoding("utf-8");
		
		List<prodVO> list = null;
		
		IprodService service = prodServiceImpl.getInstance();
		
		list = service.selectProd(pno);
		
		request.setAttribute("prodList", list);
		
		request.getRequestDispatcher("/WEB-INF/jsp/prodList.jsp").forward(request, response);
	}


}
