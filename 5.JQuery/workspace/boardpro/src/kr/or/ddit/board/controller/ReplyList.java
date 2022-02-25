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
import kr.or.ddit.board.vo.ReplyVO;

@WebServlet("/ReplyList.do")
public class ReplyList extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        IBoardService boardService = BoardServiceImpl.getInstance();

        int bonum = req.getParameter("bonum") == null ?
                0 : Integer.parseInt(req.getParameter("bonum"));

        List<ReplyVO> list = boardService.selectReply(bonum);

        req.setAttribute("list", list);

        req.getRequestDispatcher("board/replyList.jsp").forward(req, resp);
		
	}
}
