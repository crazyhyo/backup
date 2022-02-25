package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.cmm.vo.BoardPagingVO;

@WebServlet("/BlahBoardPagingList.do")
public class BlahBoardPagingList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		BoardPagingVO boardPagingVO = new BoardPagingVO();
		
		int currentPageNo = req.getParameter("currentPageNo") == null ?
				0 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		int totalCount = boardService.countBlahBoard();
		
		boardPagingVO.setCurrentPageNo(currentPageNo);
		
		boardPagingVO.setTotalCount(totalCount);
		
		List<Map<String,Object>> blahBoardPagingList = boardService.blahBoardPagingList(boardPagingVO);
		
		req.setAttribute("blahBoardPagingList", blahBoardPagingList);
		
		req.setAttribute("boardPagingVO", boardPagingVO);
		
		req.getRequestDispatcher("/WEB-INF/jsp/blahBoardPagingList.jsp").forward(req, resp);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
