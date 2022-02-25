package service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import controller.Controller;
import util.ScanUtil;
import util.View;
import dao.BoardDao;


public class BoardService {
	//싱글톤 패턴
	private BoardService(){}
	private static BoardService instance;
	public static BoardService getInstance(){
		if(instance == null){
			instance = new BoardService();
		}
		return instance;
	}
	
	private BoardDao boardDao = BoardDao.getInstance();
	public static Map<String, Object> currentBoard = null;
	SimpleDateFormat sdf= new SimpleDateFormat("MM.dd");
	
	public int boardList(){
		List<Map<String, Object>> BoardList = boardDao.selectBoardList();
		
		System.out.println("======================================================");
		System.out.println("번호\t제목\t작성자\t작성일");
		System.out.println("------------------------------------------------------");
		for(Map<String, Object> board : BoardList){
			System.out.println(board.get("BOARD_NO") + "\t"
					+ board.get("TITLE") + "\t"
					+ board.get("USER_NAME") + "\t"
					+ sdf.format(board.get("REG_DATE")));
		}
		System.out.println("======================================================");
		System.out.println("1.조회\t2.등록\t0.로그아웃");
		System.out.print("입력>");
		
		int input = ScanUtil.nextInt();
		
		Map<String, Object> board = null;
		
		switch(input){
		case 1: //조회
			board = boardDao.searchBoard();
			if (board == null){
				System.out.println("해당 게시글이 존재하지 않습니다.");
				return View.BOARD_LIST;
			}else{
				currentBoard = board;
				return View.BOARD_DETAIL;
			}
		case 2: //등록
			board = boardDao.addBoard();
			if(board == null){
				System.out.println("게시글 등록 실패");
			}else{
				currentBoard = board;
				return View.BOARD_DETAIL;
			}
			break;
		case 0: //로그아웃
			Controller.loginUser = null;
			return View.HOME;
		}
		return View.BOARD_LIST;
	}

	public int boardDetail() {
		
		System.out.println("======================================================");
		System.out.println("번호\t: " + currentBoard.get("BOARD_NO"));
		System.out.println("작성자\t: " + currentBoard.get("USER_NAME"));
		System.out.println("작성일\t: " + sdf.format(currentBoard.get("REG_DATE")));
		System.out.println("제목\t: " + currentBoard.get("TITLE"));
		System.out.println("내용\t: " + currentBoard.get("CONTENT"));
		System.out.println("======================================================");
		System.out.println("1.수정\t2.삭제\t0.목록");
		System.out.print("입력>");
		
		int input = ScanUtil.nextInt();
		Map<String, Object> board = null;
		
		switch(input){
		case 1: //수정
			board = boardDao.updateBoard();
			if(board != null){
				currentBoard = board;
				System.out.println("수정이 완료되었습니다.");
			}else{
				System.out.println("수정에 실패했습니다.");
			}
			return View.BOARD_DETAIL;
		case 2: //삭제
			if(boardDao.deleteBoard() > 0){
				System.out.println("삭제가 완료되었습니다.");
				currentBoard = null;
				return View.BOARD_LIST;
			}else{
				System.out.println("삭제에 실패했습니다.");
				return View.BOARD_DETAIL;
			}
		case 0: //목록
			currentBoard = null;
			return View.BOARD_LIST;
		}
		return View.BOARD_LIST;
	}
	
	public static int getBoardNo(){
		return (int)currentBoard.get("BOARD_NO"); 
	}
	
}
