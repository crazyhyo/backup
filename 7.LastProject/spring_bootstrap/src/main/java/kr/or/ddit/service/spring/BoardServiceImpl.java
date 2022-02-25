package kr.or.ddit.service.spring;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jsp.command.PageMaker;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.BoardVO;
import com.jsp.dto.ReplyVO;
import com.jsp.service.BoardService;

import kr.or.ddit.dao.spring.BoardDAOBean;
import kr.or.ddit.dao.spring.ReplyDAOBean;

public class BoardServiceImpl implements BoardService{

	private BoardDAOBean boardDAOBean;
	private ReplyDAOBean replyDAOBean;
	public void setBoardDAOBean(BoardDAOBean boardDAOBean) {
		this.boardDAOBean = boardDAOBean;
	}
	public void setReplyDAOBean(ReplyDAOBean replyDAOBean) {
		this.replyDAOBean = replyDAOBean;
	}
	
	@Override
	public BoardVO getBoard(int bno) throws SQLException {
		boardDAOBean.increaseViewCnt(bno);
		return boardDAOBean.selectBoardByBno(bno);
	}

	@Override
	public BoardVO getBoardForModify(int bno) throws SQLException {
		return boardDAOBean.selectBoardByBno(bno);
	}

	@Override
	public Map<String, Object> getBoardList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<BoardVO> boardList = boardDAOBean.selectSearchBoardList(cri);
		
		PageMaker pageMaker = new PageMaker();
		
		for(BoardVO board : boardList) {
			board.setReplycnt(replyDAOBean.countReply(board.getBno()));
		}
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardDAOBean.selectSearchBoardListCount(cri));
		
		dataMap.put("boardList", boardList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void modify(BoardVO board) throws SQLException {
		boardDAOBean.updateBoard(board);
	}

	@Override
	public void regist(BoardVO board) throws SQLException {
		int bno = boardDAOBean.selectBoardSeqNext();
		board.setBno(bno);
		boardDAOBean.insertBoard(board);
	}

	@Override
	public void remove(int bno) throws SQLException {
		boardDAOBean.deleteBoard(bno);
/*		SearchCriteria cri = new SearchCriteria();
		List<ReplyVO> replyList = replyDAOBean.selectReplyList(bno, cri);
		for(ReplyVO reply : replyList) {
			replyDAOBean.deleteReply(reply.getRno());
		}*/
	}

}
