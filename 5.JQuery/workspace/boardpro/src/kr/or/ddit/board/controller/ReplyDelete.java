package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/ReplyDelete.do")
public class ReplyDelete extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int renum = req.getParameter("renum") == null ?
				0 : Integer.parseInt(req.getParameter("renum"));
		if(renum == 0) {
			System.out.println(renum);
		}
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int result = boardService.deleteReply(renum);
		
		req.setAttribute("result", result);
		
		req.getRequestDispatcher("board/result.jsp").forward(req, resp);
	}
}
