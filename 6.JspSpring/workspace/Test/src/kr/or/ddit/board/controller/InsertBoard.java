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

@WebServlet("/InsertBoard.do")
public class InsertBoard extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setCharacterEncoding("utf-8");
		
		String title = req.getParameter("title") == null?
				"제목없음" : req.getParameter("title");
		
		String content = req.getParameter("content") == null?
				"내용없음" : req.getParameter("content");
		
		int memNo = req.getParameter("memNo") == null?
				1 : Integer.parseInt(req.getParameter("memNo"));
		
		BoardDTO boardDTO = new BoardDTO();
		
		boardDTO.setMemNo(memNo);
		boardDTO.setTitle(title);
		boardDTO.setContent(content);
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int boardNo = boardService.insertBoard(boardDTO);
		
		if(boardNo > 0) {
			System.out.println("등록완료!!");
			
			BoardVO boardCard = boardService.boardCard(boardNo);
			
			req.setAttribute("boardCard", boardCard);
			
			req.getRequestDispatcher("/jsp/boardDetail.jsp").forward(req, resp);
			
		}else {
			req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
		}
		
		
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}
