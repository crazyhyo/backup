package board.view;

import java.util.List;
import java.util.Scanner;

import board.vo.BoardScene;
import board.vo.BoardVO;

public class BoardViewImpl implements IBoardView{
	
	private static BoardViewImpl instance;
	
	private BoardViewImpl() { }
	
	public static BoardViewImpl getInstance() {
		if(instance == null) {
			instance = new BoardViewImpl();
		}
		return instance;
	}
	
	private Scanner sc = new Scanner(System.in);
	
	@Override
	public void printBoardList(List<BoardVO> boadList) {
		
		for(BoardVO board : boadList) {
			board.printBoard();
		}
	}

	@Override
	public int getInput(BoardScene scene) {
		int size = scene.printChoices();
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
	}
	@Override
	public BoardScene getNextScene(BoardScene scene, int input, boolean flag) {
		return flag ? scene.select(input) : scene;
	}
	
	@Override
	public String getBoardNo() {
		System.out.print("게시글 번호를 입력해주세요>");
		return sc.nextLine();
	}

	@Override
	public String getBoardTitle() {
		System.out.print("제목을 입력해주세요>");
		return sc.nextLine();
	}

	@Override
	public String getBoardContent() {
		System.out.print("내용을 입력해주세요>");
		return sc.nextLine();
	}

	@Override
	public String getBoardWriter() {
		System.out.print("작성자를 입력해주세요>");
		return sc.nextLine();
	}

	@Override
	public void printBoard(BoardVO board) {
		board.printBoardDetail();
	}

	@Override
	public boolean confirmDelete() {
		System.out.println("정말로 삭제하시겠습니까?(y/n)");
		String input = sc.nextLine();
		if(input.equals("y") || input.equals("Y")){
			return true;
		}else {
			return false;
		}
	}

	@Override
	public void printExit() {
		System.out.println("프로그램을 종료합니다.");
	}

}
