package viewControlWithEnum;

import java.util.Arrays;
import java.util.List;

public enum View {	//	뷰를 담은 enum, 각각은 자신의 화면에서 출력하는 선택지와 연결화면을 ViewChoice의 형태로 담고 있다. 
	BOARD_LIST(Arrays.asList(ViewChoices.LOOK_UP, ViewChoices.ADD, ViewChoices.END)),
	BOARD_DETAIL(Arrays.asList(ViewChoices.UPDATE, ViewChoices.DELETE)),
	EXIT(null);
	
	List<ViewChoices> choices;
	
	public int printChoices() {		//	선택지를 출력하는 메서드
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