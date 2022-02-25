package board.vo;

import java.util.Arrays;
import java.util.List;

public enum BoardScene {
	BOARD_LIST(Arrays.asList(new BoardChoiceVO("조회","BOARD_DETAIL"), new BoardChoiceVO("등록","BOARD_DETAIL")
			,new BoardChoiceVO("검색", "SEARCHED_LIST"), new BoardChoiceVO("종료", "EXIT"))),
	BOARD_DETAIL(Arrays.asList(new BoardChoiceVO("수정","BOARD_DETAIL"), new BoardChoiceVO("삭제","BOARD_LIST")
			,new BoardChoiceVO("목록", "BOARD_LIST"))),
	SEARCHED_LIST(Arrays.asList(new BoardChoiceVO("조회","BOARD_DETAIL"), new BoardChoiceVO("검색", "SEARCHED_LIST")
			,new BoardChoiceVO("목록", "BOARD_LIST"))),
	EXIT(null);
	
	List<BoardChoiceVO> choiceList;
	
	private BoardScene(List<BoardChoiceVO> choiceList) {
		this.choiceList = choiceList;
	}
	
	public int printChoices() {		//	선택지를 출력하는 메서드
		String str = "";
		for(int i = 0; i < choiceList.size(); i++) {
			str += (i+1) + "." + choiceList.get(i).getChoiceName() + "\t";
		}
		System.out.println(str);
		return choiceList.size();
	}
	
	public BoardScene select(int input) {
			return BoardScene.valueOf(choiceList.get(input - 1).getConnectedView());
	}

}
