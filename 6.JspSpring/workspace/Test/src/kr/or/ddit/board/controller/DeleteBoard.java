package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/DeleteBoard.do")
public class DeleteBoard extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int currentPageNo = req.getParameter("currentPageNo") == null?
				1 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		int boardNo = req.getParameter("boardNo") == null?
				1 : Integer.parseInt(req.getParameter("boardNo"));
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int cnt = boardService.deleteBoard(boardNo);
		
		if(cnt > 0) {
			
			req.setAttribute("currentPageNo", currentPageNo);
			
			req.getRequestDispatcher("/jsp/board.jsp").forward(req, resp);
			
		}else {
			req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
		}
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
