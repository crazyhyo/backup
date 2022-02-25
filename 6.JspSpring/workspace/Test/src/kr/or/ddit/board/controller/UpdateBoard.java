package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.util.vo.BoardDTO;
import kr.or.ddit.util.vo.BoardVO;

@WebServlet("/UpdateBoard.do")
public class UpdateBoard extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
resp.setCharacterEncoding("utf-8");
		
		String title = req.getParameter("title") == null?
				"제목없음" : req.getParameter("title");
		
		String content = req.getParameter("content") == null?
				"내용없음" : req.getParameter("content");
		
		BoardDTO boardDTO = new BoardDTO();
		
		boardDTO.setTitle(title);
		boardDTO.setContent(content);
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int boardNo = boardService.updateBoard(boardDTO);
		
		if(boardNo > 0) {
			System.out.println("수정완료!!");
			
			BoardVO boardCard = boardService.boardCard(boardNo);
			
			req.setAttribute("boardCard", boardCard);
			
			req.getRequestDispatcher("/jsp/boardDetail.jsp").forward(req, resp);
			
		}else {
			req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
		}
		
		
	}
}
