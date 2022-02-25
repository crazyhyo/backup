package board.service;

import java.util.List;

import board.vo.BoardVO;

public interface IBoardService {

	public List<BoardVO> getAllBoard();

	public boolean chkCurrentBoard();

	public void setCurrentBoard(int boardNo);
	
	public void exitCurrentBoard();

	public BoardVO getCurrentBoard();

	public int getCurrentBoardNo();

	public void deleteBoard();

	public int insertBoard(BoardVO tempBoard);

	public List<BoardVO> getSearchBoard(BoardVO tempBoard);

	public void updateBoard(BoardVO tempBoard);

	boolean chkBoard(BoardVO tempBoard);
}
