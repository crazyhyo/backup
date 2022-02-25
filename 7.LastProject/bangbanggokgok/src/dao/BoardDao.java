/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	BoardDao.java
 * Revision			:	0.2
 * Date				:	2021.08.15
 * Author			:	Lee KwangHyo
 * 
 */

/*
 * public static BoardDao getInstance() : O
 * public Map<String, Object> selectBoard(int type) : On Test
 * public double getAvgRating() : On Test
 * public List<Map<String, Object>> currentLodgeBoardList(int type) : On Test
 * public int insertBoard(int type) : On Test
 * public int deleteBoard(int type) : On Test
 * public int updateBoard(int type) : On Test
 */

/*
 * 게시글 수정 순서가 제대로 되도록 수정
 */

package dao;

import java.util.List;
import java.util.Map;
import java.util.Scanner;

import service.BoardService;
import service.LodgeService;
import service.MemberService;
import util.JDBCUtil;
import util.ScanUtil;

public class BoardDao {
	
	private BoardDao(){}
	
	private static BoardDao instance = null;
	
	public static BoardDao getInstance(){
		if(instance == null){
			instance = new BoardDao();
		}
		return instance;
	}
	
	private static JDBCUtil jdbc = JDBCUtil.getInstance();
	
	public Map<String, Object> selectBoard(int type){	//type이 1이면 리뷰게시판, 2이면 공지사항게시판
		Map<String, Object> map = null;
		
		System.out.print("조회하실 게시글을 선택해주세요>");
		int input = ScanUtil.nextInt();
		
		String sql = "select bod_no, b.mem_nm, a.bod_reg_date, a.bod_title, a.bod_content, a.bod_rating"
				+ "		from lodge_board a, member b"
				+ "	   where a.mem_no = b.mem_no"
				+ "			 and bod_no = " + input
				+ "          and lod_no = " + LodgeService.getLodgeNo()
				+ "			 and bod_code = " + type;
		
		map = jdbc.selectOne(sql);
		
		if(map == null){
			System.out.println("없는 게시글입니다.");
		}else{
			System.out.println("게시글을 찾았습니다.");
		}
		
		return map;
		
	}
	
	public List<Map<String, Object>> currentLodgeBoardList(int type){	//type이 1이면 리뷰게시판, 2이면 공지사항게시판
		if(LodgeService.currentLodge == null){
			System.out.println("현재 선택중인 숙소가 없습니다.");
			return null;
		}

		List<Map<String, Object>> list = null;
		
		if(type == 1){	//리뷰게시판
			//수정함
			String sql = "select ravg from v_lodge_list where lod_no = " + LodgeService.getLodgeNo();
			
			double rating = (double)((int)jdbc.selectOne(sql).get("RAVG"));		// 선택한 숙소의 평균평점
			
			System.out.println(LodgeService.getLodgeName() + "의 리뷰게시판입니다.");
			
			System.out.println("평균평점 : " + String.format("%.2f", Math.max(rating, 0)));
			// 선택한 숙소에 평점을 준 게시글이 없다면 평균평점을 0으로 출력
			
			sql = "select a.bod_no, a.bod_title, b.mem_nm, a.bod_rating, a.bod_reg_date"
					+ "		from lodge_board a, member b"
					+ "	   where a.mem_no = b.mem_no"
					+ "			 and a.lod_no = " + LodgeService.getLodgeNo()
					+ "       	 and a.bod_code = 1"
					+ "			 and a.bod_active = 1"
					+ "    order by 1 desc";
			
			// 선택한 숙소의 리뷰게시글을 글번호를 기준으로 내림차순으로 선택 
			
			
			list = jdbc.selectList(sql);
			
			if(list == null){
				System.out.println("리뷰게시판의 게시글이 없습니다.");
			}
			
		}else if(type == 2){	//공지사항게시판
			
			System.out.println(LodgeService.getLodgeName() + "의 공지사항게시판입니다.");
			
			String sql = "select bod_no, bod_title, '관리자', bod_reg_date"
					+ "		from lodge_board"
					+ "	   where lod_no = " + LodgeService.getLodgeNo()
					+ "       	 and bod_code = 2"
					+ "			 and bod_active = 1"
					+ "    order by 1 desc";
			
			list = jdbc.selectList(sql);
			
			if(list == null){
				System.out.println("공지사항게시판의 게시글이 없습니다.");
			}
		}
		
		return list;
	}
	
	public Map<String, Object> insertBoard(int type){	//type이 1이면 리뷰게시판, 2이면 공지사항게시판
		int result = 0;
		
		if(MemberService.currentMember == null){
			System.out.println("글 작성 권한이 없습니다. 로그인해주세요.");
			return null;
		}
		if(LodgeService.currentLodge == null){
			System.out.println("현재 선택중인 숙소가 없습니다.");
			return null;
		}
		
		int memNo = MemberService.getMemNo();
		int lodgeNo = LodgeService.getLodgeNo();
		
		int memCode = MemberService.getMemNo();
		int boardCode = type;
		
		if(memCode != boardCode){
			System.out.println("글 작성권한이 없습니다.");
			if(memCode == 1 && boardCode == 2){
				System.out.println("공지사항은 숙박시설주만 작성할 수 있습니다.");
			}else if(memCode == 2 && boardCode == 1){
				System.out.println("리뷰는 일반 회원만 작성할 수 있습니다."); 
			}
			return null;
		}
		String sql = "";

		
		System.out.print("제목을 입력해주세요>");
		String title = ScanUtil.nextLine();
		System.out.print("내용을 입력해주세요>");
		String content = ScanUtil.nextLine();
		double rating = 0;
		
		
		if(type == 1){	// 리뷰게시글 등록
			while(true){
				System.out.print("평점을 입력해주세요(0~5점)>");
				Scanner sc = new Scanner(System.in);
				rating = Double.parseDouble(sc.nextLine());
				if(rating >= 0 && rating <= 5){
					break;
				}else{
					System.out.println("0~5 사이의 평점을 입력해주세요");
				}
			}
			
			sql = "insert into lodge_board(bod_no, lod_no, mem_no, bod_title, bod_content,"
					+ " bod_reg_date, bod_rating, bod_code, bod_active)"
					+ " values((select nvl(max(bod_no) + 1,1) from lodge_board where lod_no = "
					+ lodgeNo + "and bod_code = 1)"
							+ ", " + lodgeNo + ", " + memNo + ", '" + title + "', '"
					+ content + "', sysdate, " + rating + ", 1, 1)";
			
			result = jdbc.update(sql);
			
			if(result == 1){
				System.out.println("게시글 등록에 성공하였습니다.");
				sql = "SELECT *"
						+ "    FROM LODGE_BOARD"
						+ "    WHERE BOD_NO = (SELECT NVL(MAX(BOD_NO), 0) FROM LODGE_BOARD)"
						+ "          AND LOD_NO = " + LodgeService.getLodgeNo()
						+ "          AND BOD_CODE = 1";
				
				return jdbc.selectOne(sql);
				
			}
			
		}else if(type == 2){	// 공지사항게시글 등록
			sql = "select * from ownership where mem_no = " + memNo + " and lod_no = " + lodgeNo;
			if(jdbc.selectOne(sql) == null) {
				System.out.println("공지사항 작성은 해당 시설주만 가능합니다.");
				return null;
			}
			
			sql = "insert into lodge_board(bod_no, lod_no, mem_no, bod_title, bod_content,"
					+ " bod_reg_date, bod_code, bod_active)"
					+ " values((select nvl(max(bod_no) + 1,1) from lodge_board where lod_no = "
					+ lodgeNo + "and bod_code = 2)"
					+ ", " + lodgeNo + ", " + memNo + ", '" + title + "', '"
					+ content + "', sysdate, 2, 1)";
			
			result = jdbc.update(sql);
			
			if(result == 1){
				System.out.println("게시글 등록에 성공하였습니다.");
				sql = "SELECT *"
						+ "    FROM LODGE_BOARD"
						+ "    WHERE BOD_NO = (SELECT NVL(MAX(BOD_NO), 0) FROM LODGE_BOARD)"
						+ "          AND LOD_NO = " + LodgeService.getLodgeNo()
						+ "          AND BOD_CODE = 2";
				
				return jdbc.selectOne(sql);
			}
		}
		
		return null;
		
	}
	
	public int deleteBoard(int type){	//type이 1이면 리뷰게시판, 2이면 공지사항게시판)

		int result = 0;
		
		if(MemberService.currentMember == null){
			System.out.println("글 삭제 권한이 없습니다. 로그인해주세요.");
			return 0;
		}
		if(LodgeService.currentLodge == null){
			System.out.println("현재 선택중인 숙소가 없습니다.");
			return 0;
		}
		
		
		int memNo = MemberService.getMemNo();
		int lodgeNo = LodgeService.getLodgeNo();
		int boardNo = BoardService.getBoardNo();
		String sql = "";
		
		if(memNo != BoardService.getCurrentBoardMemNo()){
			System.out.println("게시글을 작성한 회원만 삭제할 수 있습니다.");
			return 0;
		}
		
		
		while(true){
			System.out.println("정말 삭제하시겠습니까?(y/n)");
			String input = ScanUtil.nextLine();
			if(input.equals("y") || input.equals("Y")){
				break;
			}else if(input.equals("n") || input.equals("N")){
				return 0;
			}else{
				System.out.println("잘못 입력하셨습니다.");
			}
		}
		
		if(type == 1){
			sql = "update lodge_board set bod_active = 0 "
					+ "where bod_no = "	+ boardNo 
					+ "      and lod_no = " + lodgeNo 
					+ "		 and bod_code = 1";
			
			result = jdbc.update(sql);
			
			if(result == 0){
				System.out.println("게시글을 찾을 수 없습니다.");
			}else{
				System.out.println("게시글 삭제 완료");
			}
		}else if(type == 2){
			
			sql = "select * from ownership where mem_no = " + memNo + " and lod_no = " + lodgeNo;
			if(jdbc.selectOne(sql) == null) {
				System.out.println("공지사항 삭제는 해당 시설주만 가능합니다.");
				return 0;
			}
			sql = "update lodge_board set bod_active = 0 "
					+ "where bod_no = "	+ boardNo 
					+ "      and lod_no = " + lodgeNo 
					+ "		 and bod_code = 2";
			
			result = jdbc.update(sql);
			
			if(result == 0){
				System.out.println("게시글을 찾을 수 없습니다.");
			}else{
				System.out.println("게시글 삭제 완료");
			}
			
		}
		return result;
	}
	
	public int updateBoard(int type){
		int result = 0;
		
		if(MemberService.currentMember == null){
			System.out.println("글 수정 권한이 없습니다. 로그인해주세요.");
			return 0;
		}
		if(LodgeService.currentLodge == null){
			System.out.println("현재 선택중인 숙소가 없습니다.");
			return 0;
		}
		
		int memNo = MemberService.getMemNo();
		int lodgeNo = LodgeService.getLodgeNo();
		int boardNo = BoardService.getBoardNo();
		String sql = "";
		
		if(memNo != BoardService.getCurrentBoardMemNo()){
			System.out.println("게시글을 작성한 회원만 수정할 수 있습니다.");
			return 0;
		}

		if(type == 1){
			System.out.print("제목을 입력해주세요>");
			String title = ScanUtil.nextLine();
			System.out.print("내용을 입력해주세요>");
			String content = ScanUtil.nextLine();
			double rating = 0;
			while(true){
				System.out.print("평점을 입력해주세요(0~5점)>");
				Scanner sc = new Scanner(System.in);
				rating = Double.parseDouble(sc.nextLine());
				if(rating >= 0 && rating <= 5){
					break;
				}else{
					System.out.println("0~5 사이의 평점을 입력해주세요");
				}
				
			}
			
			sql = "update lodge_board"
					+ "      set bod_title = '" + title + "', bod_content = '" + content + "', bod_rating = " + rating
					+ "	   where bod_no = "	+ boardNo 
					+ "      and lod_no = " + lodgeNo 
					+ "		 and bod_code = 1";
			
			result = jdbc.update(sql);
			
			if(result == 0){
				System.out.println("게시글을 찾을 수 없습니다.");
			}else{
				System.out.println("게시글 수정 완료");
			}

		}else if(type == 2){
			sql = "select * from ownership where mem_no = " + memNo + " and lod_no = " + lodgeNo;
			if(jdbc.selectOne(sql) == null) {
				System.out.println("공지사항 수정은 해당 시설주만 가능합니다.");
				return 0;
			}
			System.out.print("제목을 입력해주세요>");
			String title = ScanUtil.nextLine();
			System.out.print("내용을 입력해주세요>");
			String content = ScanUtil.nextLine();
			
			sql = "update lodge_board"
					+ "      set bod_title = '" + title + "', bod_content = '" + content
					+ "'   where bod_no = "	+ boardNo 
					+ "      and lod_no = " + lodgeNo 
					+ "		 and bod_code = 2";
			
			result = jdbc.update(sql);
			
			if(result == 0){
				System.out.println("게시글을 찾을 수 없습니다.");
			}else{
				System.out.println("게시글 수정 완료");
			}
		}
		
		return result;
	}

	public static Map<String, Object> getCurrentBoard(int type) {
		if(type == 1){
			String sql = "select a.bod_no, b.mem_nm, a.bod_title, a.bod_content, a.bod_rating, a.bod_reg_date"
					+ "     from lodge_board a, member b"
					+ "    where a.bod_no = " + BoardService.getBoardNo()
					+ "			 and a.lod_no = " + LodgeService.getLodgeNo()
					+ " 		 and a.bod_code = 1";
			return jdbc.selectOne(sql); 
		}else if(type == 2){
			String sql = "select a.bod_no, b.mem_nm, a.bod_title, a.bod_content, a.bod_rating, a.bod_reg_date"
					+ "     from lodge_board a, member b"
					+ "    where a.bod_no = " + BoardService.getBoardNo()
					+ "			 and a.lod_no = " + LodgeService.getLodgeNo()
					+ " 		 and a.bod_code = 2";
			return jdbc.selectOne(sql); 
		}
		return null;
	}
	
	public static Map<String, Object> searchBoard(int bodNo, int type){
		String sql = "select * "
				+ "		from lodge_board "
				+ "	   where bod_no = " + bodNo
				+ " 	     and lod_no = " + LodgeService.getLodgeNo()
				+ "          and bod_code = " + type;
		return jdbc.selectOne(sql);
	}
}
