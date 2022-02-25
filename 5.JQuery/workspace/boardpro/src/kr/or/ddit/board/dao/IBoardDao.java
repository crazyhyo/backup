package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;

public interface IBoardDao {

	// 전체리스트
	public List<BoardVO> selectAll() throws SQLException;
	// 페이지별 리스트
	public List<BoardVO> selectByPage(Map<String, Integer> map) throws SQLException;
	// 전체글 개수 가져오기
	public int getTotalCount() throws SQLException;
	// 글쓰기
	public int insertBoard(BoardVO vo) throws SQLException;
	
	// 글수정
	public int updateBoard(BoardVO vo) throws SQLException;
	// 글삭제
	public int deleteBoard(int num) throws SQLException;
	// 댓글쓰기
    public int insertReply(ReplyVO vo) throws SQLException;
	
    public int updateReply(ReplyVO vo) throws SQLException;
    // 댓글 리스트
    public List<ReplyVO> selectReply(int num) throws SQLException;
	// 댓글삭제
    public int deleteReply(int renum) throws SQLException;
	
	// 조회수 증가
    public int updateHit(int num) throws SQLException;
	
}
