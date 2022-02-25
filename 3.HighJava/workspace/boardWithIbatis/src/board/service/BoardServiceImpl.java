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
	public boolean chkBoard(String boardNo) {
		return boardDao.chkBoard(boardNo);
	}

	@Override
	public boolean chkCurrentBoard() {
		return currentBoard != null ? true : false;  
	}

	@Override
	public void setCurrentBoard(String boardNo) {
		currentBoard = new BoardVO();
		currentBoard = boardDao.selectBoard(boardNo);
		
	}

	@Override
	public void exitCurrentBoard() {
		currentBoard = null;
	}

	@Override
	public String insertBoard(String boardTitle, String boardContent, String boardWriter) {
		BoardVO tempBoard = new BoardVO();
		tempBoard.setBoardTitle(boardTitle);
		tempBoard.setBoardContent(boardContent);
		tempBoard.setBoardWriter(boardWriter);
		return boardDao.insertBoard(tempBoard);
	}

	@Override
	public List<BoardVO> getSearchBoard(String boardTitle, String boardContent, String boardWriter) {
		BoardVO tempBoard = new BoardVO();
		tempBoard.setBoardTitle(boardTitle);
		tempBoard.setBoardContent(boardContent);
		tempBoard.setBoardWriter(boardWriter);
		return boardDao.getSearchBoard(tempBoard);
	}
	
	@Override
	public BoardVO getCurrentBoard() {
		return currentBoard;
	}
	
	@Override
	public String getCurrentBoardNo() {
		return currentBoard.getBoardNo();
	}

	@Override
	public void updateBoard(String boardTitle, String boardContent) {
		BoardVO tempBoard = new BoardVO();
		tempBoard.setBoardTitle(boardTitle);
		tempBoard.setBoardContent(boardContent);
		tempBoard.setBoardNo(getCurrentBoardNo());
		boardDao.updateBoard(tempBoard);
	}

	@Override
	public void deleteBoard() {
		boardDao.deleteBoard(getCurrentBoardNo());
	}

}
