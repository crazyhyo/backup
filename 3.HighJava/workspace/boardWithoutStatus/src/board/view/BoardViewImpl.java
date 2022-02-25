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
	public int inputBoardNo() {
		System.out.print("게시글 번호를 입력해주세요>");
		return Integer.parseInt(sc.nextLine());
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

	@Override
	public void inputInsert(BoardVO tempBoard) {
		System.out.print("제목을 입력해주세요>");
		tempBoard.setBoardTitle(sc.nextLine());
		System.out.print("내용을 입력해주세요>");
		tempBoard.setBoardContent(sc.nextLine());
		System.out.print("작성자를 입력해주세요>");
		tempBoard.setBoardWriter(sc.nextLine());
	}

	@Override
	public void inputUpdate(BoardVO tempBoard) {
		System.out.print("제목을 입력해주세요>");
		tempBoard.setBoardTitle(sc.nextLine());
		System.out.print("내용을 입력해주세요>");
		tempBoard.setBoardContent(sc.nextLine());
	}

	@Override
	public void inputSearch(BoardVO tempBoard) {
		System.out.print("검색할 제목을 입력해주세요>");
		tempBoard.setBoardTitle(sc.nextLine());
		System.out.print("검색할 내용을 입력해주세요>");
		tempBoard.setBoardContent(sc.nextLine());
		System.out.print("검색할 작성자를 입력해주세요>");
		tempBoard.setBoardWriter(sc.nextLine());
	}

}
