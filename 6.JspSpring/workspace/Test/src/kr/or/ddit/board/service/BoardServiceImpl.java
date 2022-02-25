package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.util.vo.BoardDTO;
import kr.or.ddit.util.vo.BoardVO;
import kr.or.ddit.util.vo.PagingVO;

public class BoardServiceImpl implements IBoardService{
	
	private IBoardDao dao;
	private static IBoardService boardService;
	
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getInstance();
	}
	public static IBoardService getInstance() {
		if(boardService == null) {
			boardService = new BoardServiceImpl();
		}
		return boardService;
	}
	@Override
	public List<BoardVO> boardPagingList(PagingVO pagingVO) {
		List<BoardVO> list = null;
		try {
			list = dao.boardPagingList(pagingVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getTotalRecord() {
		int cnt = 0;
		try {
			cnt = dao.getTotalRecord();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public BoardVO boardCard(int boardNo){
		BoardVO vo = null;
		try {
			int cnt = dao.updateHit(boardNo);
			vo = dao.boardCard(boardNo);
			if(cnt == 1) {
				System.out.println("조회수 증가함!!!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	@Override
	public int updateReport(int boardNo){
		int cnt = 0;
		try {
			cnt = dao.updateReport(boardNo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int updateBoard(BoardDTO boardDTO){
		int cnt = 0;
		try {
			cnt = dao.updateBoard(boardDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int deleteBoard(int boardNo){
		int cnt = 0;
		try {
			cnt = dao.deleteBoard(boardNo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int insertBoard(BoardDTO boardDTO){
		int cnt = 0;
		try {
			cnt = dao.insertBoard(boardDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

}
