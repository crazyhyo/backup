package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.ibatis.config.SqlMapClientFactory;

public class BoardDaoImpl implements IBoardDao{

	private SqlMapClient smc;
	private static IBoardDao dao;
	private final String nameSpace = "board.";
	
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
	public List<BoardVO> selectAll() throws SQLException {
		List<BoardVO> list = null;
		list = (List<BoardVO>)smc.queryForList(nameSpace + "selectAll");
		return list;
	}

	@Override
	public List<BoardVO> selectByPage(Map<String, Integer> map) throws SQLException {
        List<BoardVO> list = null;
        list = (List<BoardVO>)smc.queryForList(nameSpace + "selectByPage", map);
		return list;
	}

	@Override
	public int getTotalCount() throws SQLException {
		int cnt = 0;
		cnt = (int)smc.queryForObject(nameSpace + "getTotalCount");
		return cnt;
	}

	@Override
	public int insertBoard(BoardVO vo) throws SQLException {
		int cnt = 0;
		cnt = (int)smc.insert(nameSpace + "insertBoard", vo);
		return cnt;
	}

	@Override
	public int insertReply(ReplyVO vo) throws SQLException {
		int cnt = 0;
		cnt = (int)smc.insert("reply.insertReply", vo);
		return cnt;
	}

	@Override
	public List<ReplyVO> selectReply(int bonum) throws SQLException {
		List<ReplyVO> list = null;
		list = (List<ReplyVO>)smc.queryForList("reply.selectReply", bonum);
		return list;
	}

    @Override
    public int deleteReply(int renum) throws SQLException {
        int cnt = 0;
        cnt = (int) smc.delete("reply.deleteReply", renum);
        return cnt;
    }

	@Override
	public int updateReply(ReplyVO vo) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.update("reply.updateReply", vo);
		return cnt;
	}

	@Override
	public int updateHit(int num) throws SQLException {
		int cnt =0;
		cnt = (int) smc.update("board.updateHit", num);
		return cnt;
	}

	@Override
	public int deleteBoard(int num) throws SQLException {
		int cnt = 0;
		cnt = (int) smc.delete("board.deleteBoard", num);
		return cnt;
	}

	@Override
	public int updateBoard(BoardVO vo) throws SQLException {
		int cnt = 0;
		cnt = smc.update(nameSpace + "updateBoard", vo);
		return cnt;
	}

}
