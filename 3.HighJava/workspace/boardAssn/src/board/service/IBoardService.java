package board.service;

import java.util.List;

import board.vo.BoardVO;

public interface IBoardService {

	public List<BoardVO> getAllBoard();

	public boolean chkBoard(int boardNo);
	
	public boolean chkCurrentBoard();

	public void setCurrentBoard(int boardNo);
	
	public void exitCurrentBoard();

	public int insertBoard(String boardTitle, String boardContent, String boardWriter);

	public List<BoardVO> getSearchBoard(String boardTitle, String boardContent, String boardWriter);

	public BoardVO getCurrentBoard();

	public int getCurrentBoardNo();

	public void updateBoard(String boardTitle, String boardContent);

	public void deleteBoard();
}
