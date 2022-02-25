package kr.or.ddit.service.spring;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jsp.command.PageMaker;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.MemberVO;
import com.jsp.dto.ReplyVO;
import com.jsp.service.ReplyService;

import kr.or.ddit.dao.spring.MemberDAOBean;
import kr.or.ddit.dao.spring.ReplyDAOBean;

public class ReplyServiceImpl implements ReplyService{


	/*private SqlSessionFactory sqlSessionFactory;
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}
	private ReplyDAO replyDAO;
	public void setReplyDAO(ReplyDAO replyDAO) {
		this.replyDAO = replyDAO;
	}
	
	private MemberDAO memberDAO;
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	
	@Override
	public Map<String, Object> getReplyList(int bno, SearchCriteria cri) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			List<ReplyVO> replyList = replyDAO.selectReplyList(session, bno, cri);
			
			if(replyList != null) for(ReplyVO reply : replyList) {
				MemberVO member = memberDAO.selectMemberById(session, reply.getReplyer());
				reply.setPicture(member.getPicture());
			}
			
			
			int count = replyDAO.countReply(session,bno);
	
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(count);
	
			dataMap.put("replyList", replyList);
			dataMap.put("pageMaker", pageMaker);
	
			return dataMap;
		} finally {
			session.close();
		}
		
	}
	

	@Override
	public int getReplyListCount(int bno) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			int count = replyDAO.countReply(session, bno);
			return count;
		} finally {
			session.close();
		}
	}

	@Override
	public void registReply(ReplyVO reply) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			int rno = replyDAO.selectReplySeqNextValue(session);
			reply.setRno(rno);

			replyDAO.insertReply(session,reply);
		} finally {
			session.close();
		}
		
	}

	@Override
	public void modifyReply(ReplyVO reply) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		try {

			replyDAO.updateReply(session,reply);
		} finally {
			session.close();
		}		
	}

	@Override
	public void removeReply(int rno) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		try {

			replyDAO.deleteReply(session,rno);
		} finally {
			session.close();
		}
		
	}*/
	
	private ReplyDAOBean replyDAOBean;
	public void setReplyDAOBean(ReplyDAOBean replyDAOBean) {
		this.replyDAOBean = replyDAOBean;
	}
	private MemberDAOBean memberDAOBean;
	public void setMemberDAOBean(MemberDAOBean memberDAOBean) {
		this.memberDAOBean = memberDAOBean;
	}
	
	@Override
	public Map<String, Object> getReplyList(int bno, SearchCriteria cri) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ReplyVO> replyList = replyDAOBean.selectReplyList(bno, cri);
		if(replyList != null) for(ReplyVO reply : replyList) {
			MemberVO writer = memberDAOBean.selectMemberById(reply.getReplyer());
			reply.setPicture(writer.getPicture());
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(replyDAOBean.countReply(bno));
		dataMap.put("replyList", replyList);
		dataMap.put("pageMaker", pageMaker);
		return dataMap;
	}
	@Override
	public int getReplyListCount(int bno) throws SQLException {
		return replyDAOBean.countReply(bno);
	}
	@Override
	public void modifyReply(ReplyVO reply) throws SQLException {
		replyDAOBean.updateReply(reply);
	}
	@Override
	public void registReply(ReplyVO reply) throws SQLException {
		int rno = replyDAOBean.selectReplySeqNextValue();
		reply.setRno(rno);
		replyDAOBean.insertReply(reply);
	}
	@Override
	public void removeReply(int rno) throws SQLException {
		replyDAOBean.deleteReply(rno);
	}

	

}
