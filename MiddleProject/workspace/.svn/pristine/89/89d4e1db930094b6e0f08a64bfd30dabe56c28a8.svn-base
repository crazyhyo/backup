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

@WebServlet("/BoardInsert.do")
public class BoardInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		BoardVO vo = new BoardVO();
		
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		System.out.println(vo);
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		
		int num =service.boardInsert(vo);
		System.out.println("넘버를 테스트합니다 test : " + num);
		request.setAttribute("boardinsert", num);
		
		request.getRequestDispatcher("/WEB-INF/jsp/BoardInsert.jsp").forward(request, response);
		
		
	}

}






