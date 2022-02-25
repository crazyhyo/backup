package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;

public class BoardServiceImpl implements IBoardService{
	
	private IBoardDao dao;
	private static IBoardService service;
	
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getInstance();
	}
	public static IBoardService getInstance() {
		if(service == null) {
			service = new BoardServiceImpl();
		}
		return service;
	}
	@Override
	public List<BoardVO> selectAll(){
		List<BoardVO> list = null;
		try {
			list = dao.selectAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<BoardVO> selectByPage(Map<String, Integer> map){
        List<BoardVO> list = null;
        try{
            list = dao.selectByPage(map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return list;
	}
	@Override
	public int getTotalCount() {
		int cnt = 0;
		try {
			cnt = dao.getTotalCount();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int insertBoard(BoardVO vo) {
		
		int cnt = 0;
		try {
			cnt = dao.insertBoard(vo);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int insertReply(ReplyVO vo) {
		int cnt = 0;
		try {
			cnt = dao.insertReply(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public List<ReplyVO> selectReply(int bonum) {
		List<ReplyVO> list = null;
		try {
			list = dao.selectReply(bonum);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

    @Override
    public int deleteReply(int renum){
        int cnt = 0;
        try{
            cnt = dao.deleteReply(renum);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cnt;
    }
	@Override
	public int updateReply(ReplyVO vo) {
		int cnt = 0;
		try {
			cnt = dao.updateReply(vo);
		} catch (SQLException e) {
            e.printStackTrace();
        }
		return cnt;
	}
	@Override
	public int updateHit(int num) {
		int cnt = 0;
		try {
			cnt = dao.updateHit(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int deleteBoard(int num) {
		int cnt = 0;
		try {
			cnt = dao.deleteBoard(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public int updateBoard(BoardVO vo) {
		int cnt = 0;
		try {
			cnt = dao.updateBoard(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
