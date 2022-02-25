package kr.or.ddit.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;

@WebServlet("/Insert.do")
public class Insert extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		
		BoardVO bv = new BoardVO();
		
//		if(req.getRemoteAddr() != req.getLocalAddr()) {
//			System.out.println("다른 사용자 침입");
//			req.getRequestDispatcher("/board/trap.jsp").forward(req, resp);
//		}
		
		try {
			BeanUtils.populate(bv, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		bv.setWip(req.getRemoteAddr());
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int boardNum = boardService.insertBoard(bv);
		
		req.setAttribute("result", boardNum);
		
		req.getRequestDispatcher("/board/result.jsp").forward(req, resp);
	}
}
