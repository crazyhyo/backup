package board.dao;

import java.util.List;

import board.vo.BoardVO;

public interface IBoardDao {
	
	/**
	 * 게시글 번호를 입력받아 해당 게시글이 있는지 확인하는 메서드
	 * @param boardNo
	 * @return 게시글이 존재하면 true, 존재하지 않으면 false
	 */
	public boolean chkBoard(BoardVO bv);
	
	/**
	 * DB jdbc_board에 존재하는 게시글의 리스트를 반환하는 메서드 
	 * @return BoardVO 리스트
	 */
	public List<BoardVO> getAllBoard();
	
	/**
	 * 입력할 게시글을 받아 DB에 입력하는 메서드 
	 * @param bv
	 * @return 입력 성공 : 입력한 게시글의 게시글번호, 실패 : 0
	 */
	public int insertBoard(BoardVO bv);
	
	/**
	 * 입력할 게시글을 받아 DB에 수정하는 메서드 
	 * @param bv
	 * @return 수정 성공 : 1, 실패 : 0
	 */
	public int updateBoard(BoardVO bv);
	
	/**
	 * 게시글번호를 입력받아 해당 게시글을 삭제하는 메서드
	 * @param boardNo
	 * @return 삭제 성공 : 1, 실패 : 0
	 */
	public int deleteBoard(BoardVO bv);
	
	/**
	 * 제목, 내용, 작성자를 입력받아 해당하는 게시글을 검색하는 메서드
	 * 내용은 입력한 값을 포함하는 게시글을 찾도록 한다.
	 * 빈칸으로 입력된 조건은 조건검색을 수행하지 않는다.
	 * @param bv
	 * @return 검색에 맞는 BoardVO 리스트
	 */
	public List<BoardVO> getSearchBoard(BoardVO bv);

	public BoardVO selectBoard(int boardNo);

}
