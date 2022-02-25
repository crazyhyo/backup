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

@WebServlet("/board/delete.do")
public class BoardDelete extends HttpServlet{

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		IJdbcBoardService boardService = JdbcBoardServiceImpl.getInstance();
		boardService.deleteBoard(Integer.parseInt(req.getParameter("board_no")));
		ControllerUtil.redirectServlet("/board/boardlist.do", req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}

}
