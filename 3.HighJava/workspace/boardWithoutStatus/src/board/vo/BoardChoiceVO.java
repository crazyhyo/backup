package board.vo;

import board.service.BoardServiceImpl;
import board.service.IBoardService;
import board.view.BoardViewImpl;
import board.view.IBoardView;

abstract class BoardChoiceVO implements IBoardChoiceVO{
	protected String choiceName;
	protected String connectedView;
	protected IBoardView boardView = BoardViewImpl.getInstance();
	protected IBoardService boardService = BoardServiceImpl.getInstance();
	
	public BoardChoiceVO(String choiceName, String connectedView) {
		this.choiceName = choiceName;
		this.connectedView = connectedView;
	}
	
	public String getChoiceName() {		return choiceName;	}
	public String getConnectedView() {		return connectedView;	}
	
	
}

interface Ivalid{
	public boolean isVaild(BoardVO tempBoard);
}

interface Iconstruct{
	public BoardVO constructBoardVO(BoardVO tempBoard);
}

class LOOK extends BoardChoiceVO implements Ivalid, Iconstruct{
	LOOK(){		super("조회", "BOARD_DETAIL");	}
	
	@Override
	public BoardVO constructBoardVO(BoardVO tempBoard) {
		tempBoard.setBoardNo(boardView.inputBoardNo());
		return tempBoard;
	}

	@Override
	public boolean isVaild(BoardVO tempBoard) {
		
		return boardService.chkBoard(constructBoardVO(tempBoard));
	}

	@Override
	public boolean afterInput(BoardVO tempBoard) {
		boolean flag = isVaild(tempBoard);
		if(flag) {
			boardService.setCurrentBoard(tempBoard.getBoardNo());
		}
		return flag;
	}
}

class LIST extends BoardChoiceVO{
	LIST(){		super("목록", "BOARD_LIST");	}
	
	@Override
	public boolean afterInput(BoardVO tempBoard) {
		return true;
	}
}
class INSERT extends BoardChoiceVO implements Iconstruct{
	INSERT(){		super("등록", "BOARD_DETAIL");	}
	
	@Override
	public BoardVO constructBoardVO(BoardVO tempBoard) {
		boardView.inputInsert(tempBoard);
		return tempBoard;
	}

	@Override
	public boolean afterInput(BoardVO tempBoard) {
		int boardNo = boardService.insertBoard(constructBoardVO(tempBoard));
		boardService.setCurrentBoard(boardNo);
		return true;
	}
}
class SEARCH extends BoardChoiceVO{
	SEARCH(){		super("검색", "SEARCHED_LIST");	}
	
	@Override
	public boolean afterInput(BoardVO tempBoard) {
		return true;
	}
}
class EXIT extends BoardChoiceVO{
	EXIT(){		super("종료", "EXIT");	}

	@Override
	public boolean afterInput(BoardVO tempBoard) {
		return true;
	}
}
class UPDATE extends BoardChoiceVO implements Iconstruct{
	UPDATE(){		super("수정", "BOARD_DETAIL");	}
	
	@Override
	public BoardVO constructBoardVO(BoardVO tempBoard) {
		boardView.inputUpdate(tempBoard);
		return tempBoard;
	}

	@Override
	public boolean afterInput(BoardVO tempBoard) {
		boardService.updateBoard(constructBoardVO(tempBoard));
		boardService.setCurrentBoard(boardService.getCurrentBoardNo());
		return true;
	}
}
class DELETE extends BoardChoiceVO implements Ivalid{
	DELETE(){		super("삭제", "BOARD_LIST");	}
	
	@Override
	public boolean isVaild(BoardVO tempBoard) {
		return boardView.confirmDelete();
	}

	@Override
	public boolean afterInput(BoardVO tempBoard) {
		boolean flag = isVaild(tempBoard);
		if(flag) {
			boardService.deleteBoard();
		}
		return flag;
	}
}
