package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdVO;

@WebServlet("/prod.do")
public class ProdOptionList extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		String prod_lgu = (String)req.getParameter("prod_lgu");
		
		IProdService prodService = ProdServiceImpl.getInstance();
		
		List<ProdVO> prodList = (List<ProdVO>)prodService.selectProdByLGU(prod_lgu);
		req.setAttribute("prodList", prodList);
		
		req.getRequestDispatcher("/1001/prodOptionList.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String prod_id = req.getParameter("prod_id");
		
		IProdService prodService = ProdServiceImpl.getInstance();
		
		ProdVO prod = (ProdVO)prodService.selectProdById(prod_id);
		
		req.setAttribute("prod", prod);
		
		req.getRequestDispatcher("/1001/prodDetail.jsp").forward(req, resp);
		
	}
}
