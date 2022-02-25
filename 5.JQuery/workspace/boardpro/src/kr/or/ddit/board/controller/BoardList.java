package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;

@WebServlet("/List.do")
public class BoardList extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        IBoardService boardService = BoardServiceImpl.getInstance();
        List<BoardVO> list = boardService.selectAll();

        req.setAttribute("list", list);

        req.getRequestDispatcher("/board/list.jsp").forward(req, resp);

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        IBoardService boardService = BoardServiceImpl.getInstance();

        int spage = req.getParameter("spage") == null?
            -1 : Integer.parseInt(req.getParameter("spage"));

        Map<String, Integer> map = new HashMap<String, Integer>();

        int perList = 5;
        int perPage = 3;
        
        int count = boardService.getTotalCount();
        
        int totalPage = (int)(Math.ceil(count / (double)perList));

        int startPage = ((spage - 1) / perPage * perPage) + 1;
        int endPage = startPage + perPage -1;
        if(endPage > totalPage) endPage = totalPage;

        int start = (spage - 1) * perList + 1;
        int end = start + perList - 1;


        map.put("start", start);
        map.put("end", end);
        
        List<BoardVO> pageList = boardService.selectByPage(map);
        req.setAttribute("pageList", pageList);
        req.setAttribute("spage", startPage);
        req.setAttribute("epage", endPage);
        req.setAttribute("tpage", totalPage);
        req.setAttribute("cpage", spage);

        req.getRequestDispatcher("/board/listPage.jsp").forward(req, resp);

	}

}
