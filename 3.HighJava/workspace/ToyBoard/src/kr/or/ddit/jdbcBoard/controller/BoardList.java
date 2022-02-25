package kr.or.ddit.jdbcBoard.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.jdbcBoard.service.IJdbcBoardService;
import kr.or.ddit.jdbcBoard.service.JdbcBoardServiceImpl;
import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

@WebServlet("/board/boardlist.do")
public class BoardList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		IJdbcBoardService jdbcBoardService = JdbcBoardServiceImpl.getInstance();

		List<JdbcBoardVO> boardList = jdbcBoardService.selectAllBoard();

		req.setAttribute("boardList", boardList);

		req.getRequestDispatcher("/WEB-INF/views/boardList.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
