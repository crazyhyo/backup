package com.jsp.action.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.action.Action;
import com.jsp.dto.BoardVO;
import com.jsp.service.BoardService;

public class BoardDetailAction implements Action{

	private BoardService boardService;
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "/board/detail";
		
		try {
			int bno = Integer.parseInt(request.getParameter("bno"));
			
			String from = request.getParameter("from");
			
/*			if(from==null) {
				BoardVO board = boardService.getBoard(bno);
				request.setAttribute("board", board);
			}else if(from != null && from.equals("modify")){
				
				System.out.println("modify bno : " + bno + "!!!!!!!!!!!!!!!!!!");
				
				BoardVO board = boardService.getBoardForModify(bno);
				System.out.println(board);
				
				
				request.setAttribute("board", board);
			}*/
			
			BoardVO board = null;
			if(from != null && from.equals("modify")) {
				board = boardService.getBoardForModify(bno);
			}else {
				board = boardService.getBoard(bno);
			}
			request.setAttribute("board", board);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
		}
		
		return url;
	}
	

}
