package j_collection;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import play.ScanUtil;

public class Board {

	public static void main(String[] args) {
		/*
		 * ArrayList와 HashMap을 사용해 게시판 테이블을 만들고,
		 * 조회, 등록, 수정, 삭제가 가능한 게시판을 만들어주세요
		 * 
		 * 게시판 테이블 컬럼 : 번호(PK), 제목, 내용, 작성자, 작성일
		 * 
		 * 화면 2개
		 * 목록->상세화면, 등록
		 * 상세화면->수정, 삭제(목록으로 돌아가며 삭제됨)
		 */
		ArrayList<HashMap<String, Object>> boardTable = new ArrayList<HashMap<String, Object>>();
		
		while(true){
			System.out.println("------------------------------------------------");
			System.out.println("번호\t제목\t작성자\t작성일");
			System.out.println("------------------------------------------------");
			for(int i = boardTable.size() - 1; i >= 0;  i--){
				HashMap<String,Object> board = boardTable.get(i);
				System.out.println(board.get("NO")
						+ "\t" + board.get("TITLE")
						+ "\t" + board.get("USER")
						+ "\t" + board.get("REG_DATE"));
			}
			System.out.println("------------------------------------------------");
			System.out.println("1.조회\t2.등록\t0.종료");
			System.out.println("번호입력>");
			int input = ScanUtil.nextInt();
			
			switch(input){
			case 1:	//조회
				read(boardTable);
				break;
			case 2:	//등록
				insert(boardTable);
				break;
			case 0:	//종료
				System.out.println("프로그램이 종료되었습니다.");
				System.exit(0);
				break;
			}
		}
		
	}
	
	static void insert(ArrayList<HashMap<String, Object>> boardTable){
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		System.out.print("이름>");
		String user = ScanUtil.nextLine();
		
		//채번방법  1. sequence 2. max값 찾아서 + 1하기
		int maxNo = 0;
		for(int i = 0; i < boardTable.size(); i++){
			int no = (Integer)boardTable.get(i).get("NO");
			if(maxNo < no){
				maxNo = no;
			}
		}
		
		HashMap<String, Object> temp = new HashMap<String, Object>();
		temp.put("NO", maxNo + 1);
		temp.put("TITLE", title);
		temp.put("CONTENT", content);
		temp.put("USER", user);
		temp.put("REG_DATE", new Date());
		
		boardTable.add(temp);
		System.out.println("게시글 등록이 완료되었습니다.");
	}
	
	static void read(ArrayList<HashMap<String, Object>> boardTable){
		System.out.print("조회할 게시글 번호 입력>");
		int no = ScanUtil.nextInt();
		
		HashMap<String, Object> board = null;
		for(int i = 0; i < boardTable.size(); i++){
			if((Integer)boardTable.get(i).get("NO") == no){
				board = boardTable.get(i);
				break;
			}
		}
		System.out.println("------------------------------------------------");
		System.out.println("번호\t: " + board.get("NO"));
		System.out.println("작성자\t: " + board.get("USER"));
		System.out.println("작성일\t: " + board.get("REG_DATE"));
		System.out.println("제목\t: " + board.get("TITLE"));
		System.out.println("내용\t: " + board.get("CONTENT"));
		System.out.println("------------------------------------------------");
		System.out.println("1.수정\t2.삭제\t0.목록");
		System.out.print("번호입력");
		int input = ScanUtil.nextInt();
		
		switch(input){
		case 1:	//수정
			update(board);
			break;
		case 2:	//삭제
			delete(boardTable, board);
			break;
		}
	}
	
	static void update(HashMap<String, Object> board){
		System.out.print("제목>");
		String title = ScanUtil.nextLine();
		System.out.print("내용>");
		String content = ScanUtil.nextLine();
		
		board.put("TITLE", title);
		board.put("CONTENT", content);
		
		System.out.println("수정이 완료되었습니다.");
	}
	static void delete(ArrayList<HashMap<String, Object>> boardTable
			, HashMap<String, Object>board){
		for(int i = 0; i < boardTable.size(); i++){
			if(boardTable.get(i).get("NO") == board.get("NO")){
				boardTable.remove(i);
				System.out.println("삭제가 완료되었습니다.");
				break;
			}
		}
		System.out.println("수정이 완료되었습니다.");
	}
	
}
