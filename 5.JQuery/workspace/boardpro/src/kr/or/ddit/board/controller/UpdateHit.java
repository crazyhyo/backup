package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/UpdateHit.do")
public class UpdateHit extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int num = req.getParameter("num") == null?
				0 : Integer.parseInt(req.getParameter("num"));
		
		if (num == 0) {
			System.out.println("asdf");
		}
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int result = boardService.updateHit(num);
		
		req.setAttribute("result", result);
		
		req.getRequestDispatcher("board/result.jsp").forward(req, resp);
		
	}
}
