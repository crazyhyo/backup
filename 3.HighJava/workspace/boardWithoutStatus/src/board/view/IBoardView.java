package board.view;

import java.util.List;

import board.vo.BoardScene;
import board.vo.BoardVO;

public interface IBoardView {

	public void printBoardList(List<BoardVO> boadList);

	public int inputBoardNo();

	public void printBoard(BoardVO board);

	public boolean confirmDelete();

	public void printExit();

	public void inputInsert(BoardVO tempBoard);

	public void inputUpdate(BoardVO tempBoard);

	public void inputSearch(BoardVO tempBoard);
}
