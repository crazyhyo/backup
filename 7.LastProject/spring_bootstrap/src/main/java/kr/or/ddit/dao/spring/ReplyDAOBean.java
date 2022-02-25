package kr.or.ddit.dao.spring;

import java.sql.SQLException;
import java.util.List;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.ReplyVO;

public interface ReplyDAOBean {
	
	public int selectReplySeqNextValue() throws SQLException;

	public List<ReplyVO> selectReplyList(int bno, SearchCriteria cri) throws SQLException;

	public int countReply(int bno) throws SQLException;

	public void insertReply(ReplyVO reply) throws SQLException;

	public void updateReply(ReplyVO reply) throws SQLException;

	public void deleteReply(int rno) throws SQLException;

}
