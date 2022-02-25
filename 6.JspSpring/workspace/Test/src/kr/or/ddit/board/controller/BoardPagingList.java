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
import kr.or.ddit.util.vo.PagingVO;

@WebServlet("/BoardPagingList.do")
public class BoardPagingList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int currentPageNo = req.getParameter("currentPageNo") == null?
				1 : Integer.parseInt(req.getParameter("currentPageNo"));
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int totalCount = boardService.getTotalRecord();
		
		PagingVO pagingVO = new PagingVO();
		pagingVO.setTotalCount(totalCount);
		pagingVO.setCurrentPageNo(currentPageNo);
		
		List<BoardVO> boardPagingList = boardService.boardPagingList(pagingVO);
		
		System.out.println(boardPagingList.size());
		
		req.setAttribute("boardPagingList", boardPagingList);
		
		req.getRequestDispatcher("/jsp/boardList.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
