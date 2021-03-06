package board.view;

import java.util.List;

import board.vo.BoardScene;
import board.vo.BoardVO;

public interface IBoardView {

	public void printBoardList(List<BoardVO> boadList);

	public int getInput(BoardScene scene);

	public int getBoardNo();

	public BoardScene getNextScene(BoardScene scene, int input, boolean flag);

	public String getBoardContent();

	public String getBoardWriter();
	
	public void printBoard(BoardVO board);

	public boolean confirmDelete();

	public String getBoardTitle();

	public void printExit();
}
