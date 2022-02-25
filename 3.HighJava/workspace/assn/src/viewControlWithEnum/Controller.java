package viewControlWithEnum;

import java.util.Stack;

public class Controller {
	
	private static Stack<View> viewStack;		//	뷰를 관리하는 스택
	
	private static Controller instance = null;
	private static BoardService boardService;
	
	private Controller() {
		viewStack = new Stack<View>();
		boardService = BoardService.getInstance();
	}
	
	public static Controller getInstance() {	//	싱글턴 패턴
		if(instance == null) {
			instance = new Controller();
		}
		return instance;
	}
	
	public static View getCurrentView() {		//	현재의 뷰를 반환
		return viewStack.peek();
	}
	
	public static View back() {		//	stack을 이용한 돌아가기 구현
		viewStack.pop();			//	가장 위에 있는 뷰를 꺼내고
		if(viewStack.empty()) {		//	만약 모든 뷰가 꺼내어졌다면 종료한다.
			System.out.println("종료되었습니다");
			System.exit(0);
		}
		return getCurrentView();	//	이전화면을 리턴한다
	}
	public static void push(View view) {	//	stack을 이용한 화면 쌓기 구현
		if(getCurrentView() != view) {		//	현재화면과 같지 않을 때만 stack에 추가
			viewStack.push(view);
		}
	}
	public static int showCurrentChoices() {
		return getCurrentView().printChoices();
	}
	
	public static void main(String[] args) {
		new Controller().start();
	}
	public void start() {
		View view = View.BOARD_LIST;
		viewStack.push(view);		//	스택에 메인화면을 넣고 시작
		while(true) {	//	무한반복
				boardService.load();
				switch(view) {
				case BOARD_LIST: view = BoardService.boardList(); break;
				case BOARD_DETAIL: view = BoardService.boardDetail(); break;
				case EXIT: System.out.println("선택지를 통한 종료"); System.exit(0);
				}
			}
		}
}