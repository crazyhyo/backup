package kr.or.ddit.test;

import java.util.List;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.util.vo.BoardVO;
import kr.or.ddit.util.vo.PagingVO;

public class Test {
	public static void main(String[] args) {
		int currentPageNo = 1;
		
		IBoardService boardService = BoardServiceImpl.getInstance();
		
		int totalCount = boardService.getTotalRecord();
		
		PagingVO pagingVO = new PagingVO();
		pagingVO.setTotalCount(totalCount);
		pagingVO.setCurrentPageNo(currentPageNo);
		
		List<BoardVO> boardPagingList = boardService.boardPagingList(pagingVO);
		
		System.out.println(boardPagingList.size());
	}
}
