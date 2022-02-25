package viewControlWithEnum;

import java.util.Arrays;
import java.util.List;

public enum View {	//	뷰를 담은 enum, 각각은 자신의 화면에서 출력하는 선택지와 연결화면을 ViewChoice의 형태로 담고 있다. 
	BOARD_LIST(Arrays.asList(ViewChoices.LOOK_UP, ViewChoices.REGISTER, ViewChoices.SEARCH, ViewChoices.END)),
	BOARD_DETAIL(Arrays.asList(ViewChoices.CHANGE, ViewChoices.DELETE)),
	SEARCHED_LIST(Arrays.asList(ViewChoices.LOOK_UP, ViewChoices.SEARCH)),
	EXIT(null);
	
	List<ViewChoices> choices;
	
	public int printChoices() {		//	선택지를 출력하는 메서드
		System.out.println(this.name());	//	현재화면의 이름 출력
		String str = "";
		for(int i = 0; i < choices.size(); i++) {
			str += (i+1) + "." + choices.get(i).getChoiceName() + "\t";
		}
		str += (choices.size() + 1) + ".돌아가기\t";
			System.out.println(str);
		return choices.size() + 1;
	}
	
	private ViewChoices getSelectedView(int input) {
		return choices.get(input - 1);
	}
	
	public View select(int input, int back) {
		if(input == back) {
			return Controller.back();		//	돌아가기 실행(Stack으로 구현)
		}else if(input <= back && input >= 1){		// 주어진 선택지 내에서 선택한다면
			/*
			View temp = View.valueOf(		//	선택지가 가리키는 뷰를 temp로 저장함[ 선택지가 가리키는 뷰의 이름을 구해서 View.valueOf메서드로 접근해 구할 계획 ]
					choices					//	현재 화면이 가지고 있는 선택지들 중에서
					.get(input-1)			//	입력한 화면에 해당하도록 인덱싱(ViewChoices에 접근)
					.getConnectedView());	// 	접근한 ViewChoices의 연결화면 이름을 가져와 View.valueOf로 화면을 연결시킨다.
			*/
			View temp = View.valueOf(getSelectedView(input).getConnectedView());
			Controller.push(temp);			//	viewStack에 넣고
			return temp;					//	리턴함
		}else {		// 선택지를 벗어난다면 화면을 이동하지 않음
			System.out.println("선택지 중에서 결정해주세요");
			return this;
		}
	}
	View(List<ViewChoices> choices){	//	생성자
		this.choices = choices;
	}
}