package board.controller;

import java.util.ArrayList;
import java.util.List;

import board.service.BoardServiceImpl;
import board.service.IBoardService;
import board.view.BoardViewImpl;
import board.view.IBoardView;
import board.vo.BoardScene;
import board.vo.BoardVO;

public class BoardController {
	
	private IBoardService boardService;
	
	private BoardScene scene;
	
	private IBoardView boardView;
	
	BoardController(){
		boardService = BoardServiceImpl.getInstance();
		boardView = BoardViewImpl.getInstance();
		scene = BoardScene.BOARD_LIST;
	}
	
	public static void main(String[] args) {
		new BoardController().start();
	}

	private void start() {
		
		List<BoardVO> searchBoard = new ArrayList<BoardVO>();
		
		while(true) {
			int input = 0;
			String boardNo = "";
			String boardTitle = "";
			String boardContent = "";
			String boardWriter = "";
			boolean flag = true;
			switch(scene) {
			case BOARD_LIST:
				boardView.printBoardList(boardService.getAllBoard());
				input = boardView.getInput(scene);
				switch(input) {
				case 1:
					boardNo = boardView.getBoardNo();
					flag = boardService.chkBoard(boardNo);
					if(flag) {
						boardService.setCurrentBoard(boardNo);
					}
					break;
				case 2:
					boardTitle = boardView.getBoardTitle();
					boardContent = boardView.getBoardContent();
					boardWriter = boardView.getBoardWriter();
					boardNo = boardService.insertBoard(boardTitle, boardContent, boardWriter);
					boardService.setCurrentBoard(boardNo);
					break;
				case 3:
					boardTitle = boardView.getBoardTitle();
					boardContent = boardView.getBoardContent();
					boardWriter = boardView.getBoardWriter();
					searchBoard = boardService.getSearchBoard(boardTitle, boardContent, boardWriter);
					break;
				case 4:
					break;
				}
				break;
			case BOARD_DETAIL:
				boardView.printBoard(boardService.getCurrentBoard());
				input = boardView.getInput(scene);
				switch(input) {
				case 1:
					boardNo = boardService.getCurrentBoardNo();
					boardTitle = boardView.getBoardTitle();
					boardContent = boardView.getBoardContent();
					boardService.updateBoard(boardTitle, boardContent);
					boardService.setCurrentBoard(boardNo);
					break;
				case 2:
					flag = boardView.confirmDelete();
					if(flag) {
						boardService.deleteBoard();
						boardService.exitCurrentBoard();
					}
					break;
				case 3:
					break;
				}
				break;
			case SEARCHED_LIST:
				boardView.printBoardList(searchBoard);
				input = boardView.getInput(scene);
				switch(input) {
				case 1:
					boardNo = boardView.getBoardNo();
					flag = boardService.chkBoard(boardNo);
					if(flag) {
						boardService.setCurrentBoard(boardNo);
					}
					break;
				case 2:
					boardTitle = boardView.getBoardTitle();
					boardContent = boardView.getBoardContent();
					boardWriter = boardView.getBoardWriter();
					searchBoard = boardService.getSearchBoard(boardTitle, boardContent, boardWriter);
					break;
				case 3:
					break;
				}
				break;
			case EXIT:
				boardView.printExit();
				System.exit(0);
				break;
			}
			scene = boardView.getNextScene(scene, input, flag);
		}
	}
	
	
}
