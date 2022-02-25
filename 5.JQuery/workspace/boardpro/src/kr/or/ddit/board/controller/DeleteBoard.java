package kr.or.ddit.board.controller;

import static org.junit.Assert.assertNotNull;

import java.io.IOException;

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
		
		int num = Integer.parseInt(req.getParameter("num"));
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int result = boardService.deleteBoard(num);

		int count = boardService.getTotalCount();
		
        int perList = 5;
		
		int totalPage = (int)Math.ceil(count / (double)perList);
		
		req.setAttribute("result", result);
		req.setAttribute("totalPage", totalPage);
		
		req.getRequestDispatcher("board/delete.jsp").forward(req, resp);
		
	}
}
