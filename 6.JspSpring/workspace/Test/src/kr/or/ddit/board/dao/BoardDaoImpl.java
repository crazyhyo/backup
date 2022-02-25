package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.util.SqlMapClientFactory;
import kr.or.ddit.util.vo.BoardDTO;
import kr.or.ddit.util.vo.BoardVO;
import kr.or.ddit.util.vo.PagingVO;

public class BoardDaoImpl implements IBoardDao{
	
	private String nameSpace = "board.";
	private SqlMapClient smc;
	private static IBoardDao dao;
	private BoardDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IBoardDao getInstance() {
		if(dao == null) {
			dao = new BoardDaoImpl();
		}
		return dao;
	}
	
	
	@Override
	public List<BoardVO> boardPagingList(PagingVO pagingVO) throws SQLException {
		List<BoardVO> list = null;
		list = (List<BoardVO>) smc.queryForList(nameSpace + "boardPagingList", pagingVO);
		return list;
	}

	@Override
	public int getTotalRecord() throws SQLException {
		int cnt = 0;
		cnt = (int)smc.queryForObject(nameSpace + "getTotalRecord");
		return cnt;
	}

	@Override
	public BoardVO boardCard(int boardNo) throws SQLException {
		BoardVO vo = null;
		vo = (BoardVO) smc.queryForObject(nameSpace + "boardCard", boardNo);
		return vo;
	}

	@Override
	public int updateHit(int boardNo) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.update(nameSpace + "updateHit", boardNo);
		return cnt;
	}

	@Override
	public int updateReport(int boardNo) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.update(nameSpace + "updateReport", boardNo);
		return cnt;
	}

	@Override
	public int updateBoard(BoardDTO boardDTO) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.update(nameSpace + "updateBoard", boardDTO);
		return cnt;
	}

	@Override
	public int deleteBoard(int boardNo) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.delete(nameSpace + "deleteBoard", boardNo);
		return cnt;
	}

	@Override
	public int insertBoard(BoardDTO boardDTO) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.insert(nameSpace + "insertBoard", boardDTO);
		return cnt;
	}

}
