package kr.or.ddit.dao.spring;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jsp.command.SearchCriteria;
import com.jsp.dao.ReplyDAO;
import com.jsp.dto.ReplyVO;

public class ReplyDAOImplTemplate implements ReplyDAOBean{
	
	private ReplyDAO replyDAO;
	private SqlSession session;

	public void setReplyDAO(ReplyDAO replyDAO) {
		this.replyDAO = replyDAO;
	}

	public void setSession(SqlSession session) {
		this.session = session;
	}


	@Override
	public int selectReplySeqNextValue() throws SQLException {
		return replyDAO.selectReplySeqNextValue(session);
	}

	@Override
	public List<ReplyVO> selectReplyList(int bno, SearchCriteria cri) throws SQLException {
		return replyDAO.selectReplyList(session, bno, cri);
	}

	@Override
	public int countReply(int bno) throws SQLException {
		return replyDAO.countReply(session, bno);
	}

	@Override
	public void insertReply(ReplyVO reply) throws SQLException {
		replyDAO.insertReply(session, reply);
	}

	@Override
	public void updateReply(ReplyVO reply) throws SQLException {
		replyDAO.updateReply(session, reply);
	}

	@Override
	public void deleteReply(int rno) throws SQLException {
		replyDAO.deleteReply(session, rno);
	}

}
