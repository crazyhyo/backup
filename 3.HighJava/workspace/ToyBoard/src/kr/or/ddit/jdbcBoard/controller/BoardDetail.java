package kr.or.ddit.jdbcBoard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.jdbcBoard.service.IJdbcBoardService;
import kr.or.ddit.jdbcBoard.service.JdbcBoardServiceImpl;
import kr.or.ddit.jdbcBoard.util.ControllerUtil;
import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

@WebServlet("/board/detail.do")
public class BoardDetail extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		IJdbcBoardService jdbcBoardService = JdbcBoardServiceImpl.getInstance();
		
		int board_no = Integer.parseInt(req.getParameter("board_no"));
		
		boolean flag = jdbcBoardService.chkBoard(board_no);
		
		String link = "";
		
		JdbcBoardVO board = null;
		
		if(flag) {
			board = jdbcBoardService.selectBoard(board_no);
			req.setAttribute("board", board);
			link = "detail";
		}else {
			link = "notFoundBoardNo";
		}
		
		ControllerUtil.forwardURL(link, req, resp);
		
	}

}