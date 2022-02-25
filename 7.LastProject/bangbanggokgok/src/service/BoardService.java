/*
 * public static int getCurrentBoardMemNo() : O
 * public static int getBoardNo() : O
 * public static int boardDetail() : X
 * public static int noticeBoardDetail() : X
 * public static int noticeBoardList() : X
 * public static int reviewBoardDetail() : O
 * public static int reviewBoardList() : X
 * 
 * Lee KwangHyo
 */

package service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.BoardDao;
import dao.LodgeDao;

public class BoardService {
	
	
	public static Map<String, Object> currentBoard = null;
	private static BoardDao boardDao = BoardDao.getInstance();
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public static int getCurrentBoardMemNo(){
		if(currentBoard == null){
			System.out.println("조회중인 게시글이 없습니다.");
			return -1;
		}else{
			//System.out.println(currentBoard);
			return (int)currentBoard.get("MEM_NO");
		}
	}

	public static int getBoardNo() {
		if(currentBoard == null){
			System.out.println("조회중인 게시글이 없습니다.");
			return -1;
		}else{
			return (int)currentBoard.get("BOD_NO");
		}
	}

	public static int noticeBoardDetail() {
		showCurrentBoard(2);
		
		System.out.println("1.수정\t2.삭제\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1: boardDao.updateBoard(2); return View.NOTICE_BOARD_DETAIL;
		case 2: 
			if(boardDao.deleteBoard(2) == 0) {
				return View.NOTICE_BOARD_DETAIL;
			}else {
				return View.NOTICE_BOARD_LIST;
			}
		case 0: return View.NOTICE_BOARD_LIST;
		}
		return 0;
	}
	public static int reviewBoardDetail() {
		showCurrentBoard(1);
		
		System.out.println("1.수정\t2.삭제\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1: boardDao.updateBoard(1); return View.REVIEW_BOARD_DETAIL;
		case 2: 
			if(boardDao.deleteBoard(1) == 0) {
				return View.REVIEW_BOARD_DETAIL;
			}else {
				return View.REVIEW_BOARD_LIST;
			}
		case 0: return View.REVIEW_BOARD_LIST;
		}
		return 0;
	}
	
	
	private static void showCurrentBoard(int type) {
		if(currentBoard == null){
			System.out.println("현재 선택된 게시글이 없습니다.");
			ScanUtil.stop(1000);
		}else{
			if(type == 2) {
				Map<String, Object> boardDetail = BoardDao.getCurrentBoard(type);
				
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
				System.out.println("게시글번호\t:\t" + boardDetail.get("BOD_NO"));
				System.out.println("작성자\t:\t관리자");
				System.out.println("작성일\t:\t" + sdf.format(boardDetail.get("BOD_REG_DATE")));
				System.out.println("제목\t:\t" + boardDetail.get("BOD_TITLE"));
				System.out.println("내용\t:\t" + boardDetail.get("BOD_CONTENT"));
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			}else if(type == 1) {
				Map<String, Object> boardDetail = BoardDao.getCurrentBoard(type);
				System.out.println(boardDetail);
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
				System.out.println("게시글번호\t:\t" + boardDetail.get("BOD_NO"));
				System.out.println("작성자\t:\t" + boardDetail.get("MEM_NM"));
				System.out.println("작성일\t:\t" + sdf.format(boardDetail.get("BOD_REG_DATE")));
				System.out.println("제목\t:\t" + boardDetail.get("BOD_TITLE"));
				System.out.println("평점\t:\t" + boardDetail.get("BOD_RATING"));
				System.out.println("내용\t:\t" + boardDetail.get("BOD_CONTENT"));
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			}
		}
	}

	public static int noticeBoardList() {
		List<Map<String, Object>> list = null;
		list = boardDao.currentLodgeBoardList(2);
		for(Map<String, Object> walk : list){
			System.out.println("게시글번호\t:" + "\t\t" + walk.get("BOD_NO"));
			System.out.println("제목\t:" + "\t\t" + walk.get("BOD_TITLE"));
			System.out.println("작성자\t:\t\t관리자");
			System.out.println("작성일\t:" + "\t\t" + sdf.format(walk.get("BOD_REG_DATE")));
			System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		}
		
		Map<String, Object> tmpBoard = null;
		
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1:	
			tmpBoard = boardDao.selectBoard(2);
			if(tmpBoard == null){
				return View.NOTICE_BOARD_LIST;
				}else{
					currentBoard = BoardDao.searchBoard((int)tmpBoard.get("BOD_NO"), 2);
				}
			return View.NOTICE_BOARD_DETAIL;
		case 2:	
			tmpBoard = boardDao.insertBoard(2);
			if(tmpBoard == null){
				return View.NOTICE_BOARD_LIST;
			}else{
				currentBoard = tmpBoard;
			}
			return View.NOTICE_BOARD_DETAIL;
		case 0: 
			if(MemberService.currentMember == null){
				return View.ROOM_LIST;
			} else if((int)MemberService.currentMember.get("MEM_CODE") == 2){
				return View.BOARD_MANAGE;
			} else if ((int)MemberService.currentMember.get("MEM_CODE") == 1){
				return View.ROOM_LIST;
			}
		}
		return 0;
	}
	public static int reviewBoardList() {
		List<Map<String, Object>> list = null;
		list = boardDao.currentLodgeBoardList(1);
		
		for(Map<String, Object> walk : list){
			System.out.println("게시글번호\t:" + "\t\t" + walk.get("BOD_NO"));
			System.out.println("제목\t:" + "\t\t" + walk.get("BOD_TITLE"));
			System.out.println("작성자\t:" + "\t\t" + walk.get("MEM_NM"));
			System.out.println("평점\t:" + "\t\t" + walk.get("BOD_RATING"));
			System.out.println("작성일\t:" + "\t\t" + sdf.format(walk.get("BOD_REG_DATE")));
			System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		}
		
		Map<String, Object> tmpBoard = null;
		
		System.out.println("1.조회\t2.등록\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1:	
			tmpBoard = boardDao.selectBoard(1);
			if(tmpBoard == null){
				return View.REVIEW_BOARD_LIST;
			}else{
				currentBoard = BoardDao.searchBoard((int)tmpBoard.get("BOD_NO"), 1);
			}
			return View.REVIEW_BOARD_DETAIL;
		case 2:	
			tmpBoard = boardDao.insertBoard(1);
			if(tmpBoard == null){
				return View.REVIEW_BOARD_LIST;
			}else{
				currentBoard = tmpBoard;
//				System.out.println(currentBoard);
			}
			return View.REVIEW_BOARD_DETAIL;
		case 0: 
			if(MemberService.currentMember == null){
				return View.ROOM_LIST;
			} else if((int)MemberService.currentMember.get("MEM_CODE") == 2){
				return View.BOARD_MANAGE;
			} else if ((int)MemberService.currentMember.get("MEM_CODE") == 1){
				return View.ROOM_LIST;
			}
		}
		return 0;
	}
}
