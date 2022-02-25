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
import kr.or.ddit.util.vo.BoardVO;

@WebServlet("/BoardDetail.do")
public class BoardDetail extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int currentPageNo = req.getParameter("currentPageNo") == null?
				1 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		int boardNo = req.getParameter("boardNo") == null?
				1 : Integer.parseInt(req.getParameter("boardNo"));
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		BoardVO boardCard = boardService.boardCard(boardNo);
		
		req.setAttribute("boardCard", boardCard);
		req.setAttribute("currentPageNo", currentPageNo);
		
		req.getRequestDispatcher("/jsp/boardDetail.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
