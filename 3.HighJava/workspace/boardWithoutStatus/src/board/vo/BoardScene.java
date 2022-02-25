package board.vo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import board.service.BoardServiceImpl;
import board.service.IBoardService;
import board.view.BoardViewImpl;
import board.view.IBoardView;

public enum BoardScene {
	BOARD_LIST(Arrays.asList(new LOOK(), new INSERT(), new SEARCH(), new EXIT())){
		@Override
		protected void printUntilInput(){
			boardView.printBoardList(boardService.getAllBoard());
		}
	},
	BOARD_DETAIL(Arrays.asList(new UPDATE(), new DELETE(), new LIST())){
		@Override
		protected void printUntilInput(){
			boardView.printBoard(boardService.getCurrentBoard());
		}
	},
	SEARCHED_LIST(Arrays.asList(new LOOK(), new SEARCH(), new LIST())){
		@Override
		protected void printUntilInput(){
			List<BoardVO> searchBoard = new ArrayList<BoardVO>();
			BoardVO tempBoard = new BoardVO();
			boardView.inputSearch(tempBoard);
			searchBoard = boardService.getSearchBoard(tempBoard);
			boardView.printBoardList(searchBoard);
		}
	},
	EXIT(null){
		@Override
		protected void printUntilInput(){
			System.out.println("종료!!!!!!");
			System.exit(0);
		}
	};
	
	private List<BoardChoiceVO> choiceList;
	protected IBoardView boardView = BoardViewImpl.getInstance();
	protected IBoardService boardService = BoardServiceImpl.getInstance();

	
	public BoardScene act() {

		int input = 0;
		BoardVO tempBoard = new BoardVO();
		boolean flag = true;
		BoardChoiceVO target = null;
		
		printUntilInput();
		input = getInput();
		target = choiceList.get(input - 1);
		flag = target.afterInput(tempBoard);
		
		return flag ? select(input) : this;
	}
	
	abstract protected void printUntilInput();
	
	protected int getInput() {

		Scanner sc = new Scanner(System.in);
		int size = printChoices();
		int input = 0;
		while(true) {
			input = Integer.parseInt(sc.nextLine());
			if(input > size || input < 1) {
				System.out.println("잘못 입력하셨습니다.");
				continue;
			}else {
				break;
			}
		}
		return input;
	
	};
	
	private BoardScene(List<BoardChoiceVO> choiceList) {
		this.choiceList = choiceList;
	}
	
	private int printChoices() {		//	선택지를 출력하는 메서드
		
		if(choiceList == null) {
			System.out.println("종료합니다.");
			System.exit(0);
			return 0;
		}
		
		String str = "";
		for(int i = 0; i < choiceList.size(); i++) {
			str += (i+1) + "." + choiceList.get(i).getChoiceName() + "\t";
		}
		System.out.println(str);
		return choiceList.size();
	}
	
	private BoardScene select(int input) {
			return BoardScene.valueOf(choiceList.get(input - 1).getConnectedView());
	}

}
