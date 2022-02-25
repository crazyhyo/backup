package board.service;

import java.util.List;

import board.dao.BoardDaoImpl;
import board.dao.IBoardDao;
import board.vo.BoardVO;

public class BoardServiceImpl implements IBoardService{
	
	private static BoardServiceImpl instance = null;
	
	private IBoardDao boardDao;
	
	private BoardVO currentBoard;
	
	private BoardServiceImpl() {
		boardDao = BoardDaoImpl.getInstance();
		currentBoard = new BoardVO();
	}
	
	public static BoardServiceImpl getInstance() {
		if(instance == null) {
			instance = new BoardServiceImpl();
		}
		return instance;
	}

	@Override
	public List<BoardVO> getAllBoard() {
		return boardDao.getAllBoard();
	}

	@Override
	public boolean chkBoard(BoardVO tempBoard) {
		return boardDao.chkBoard(tempBoard);
	}

	@Override
	public boolean chkCurrentBoard() {
		return currentBoard != null ? true : false;  
	}

	@Override
	public void setCurrentBoard(int boardNo) {
		currentBoard = new BoardVO();
		currentBoard = boardDao.selectBoard(boardNo);
	}

	@Override
	public void exitCurrentBoard() {
		currentBoard = null;
	}

	@Override
	public BoardVO getCurrentBoard() {
		return currentBoard;
	}
	
	@Override
	public int getCurrentBoardNo() {
		return currentBoard.getBoardNo();
	}

	@Override
	public void deleteBoard() {
		boardDao.deleteBoard(getCurrentBoard());
	}

	@Override
	public int insertBoard(BoardVO tempBoard) {
		return boardDao.insertBoard(tempBoard);
	}

	@Override
	public List<BoardVO> getSearchBoard(BoardVO tempBoard) {
		return boardDao.getSearchBoard(tempBoard);
	}

	@Override
	public void updateBoard(BoardVO tempBoard) {
		tempBoard.setBoardNo(getCurrentBoardNo());
		boardDao.updateBoard(tempBoard);
	}

}
