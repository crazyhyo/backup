package service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import util.ScanUtil;
import util.View;
import dao.LodgeDao;
import dao.MemberDao;

/*
 * 메서드 설명 :
 * 1.show_non : 비회원 매인 홈페이지 창
 * 	1-1 login_screen) 로그인 화면 창
 * 		login) 로그인 창 - loginMember.get("MEM_CODE")에 따라서 1.일반회원 2.숙박업주 회원으로 구분
 * 		signUp) 회원 정보를 입력하고 input에서는 회원구분 코드를 입력받음
 * 		forget_pw) 미구현
 * 	1-2 setAdd1) 주소 '시'에 해당하는 메서드. setAdd2는 '구'에 해당됨
 * 	1-3 printResH) loginMember == null일 경우 mem_tel를 입력받아 휴대폰으로 예약이력 정보 조회
 * 				   valid_mem 메서드를 통해 해당 접근이 일반회원인지 아닌지를 판단하고 리턴해줌
 * 
 * 2.show_normal : 회원 메인 홈페이지 창
 * 	2-1 myPage) 마이페이지 창
 * 		printResH) 동일함
 * 		updateMyInfo) 내정보 수정창 입력값(mem_pw, mem_tel, mem_email)
 * 
 * 3.show_owner : 숙박업주 메인 창
 * 4.signUpForNon : 비회원 등록 
 */

public class MemberService {

	private MemberService() {
	}

	private static MemberService instance;
	private static LodgeDao lodgeDao = LodgeDao.getInstance();
	
	public static MemberService getInstance() {
		if (instance == null) {
			instance = new MemberService();
		}
		return instance;
	}

	private static MemberDao memberDao = MemberDao.getInstance();
	public static Map<String, Object> currentMember = null;
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	static Pattern p = null;
	static Matcher m = null;	
	
	

	public static int show_non() {
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println("<비회원>으로 입장하셨습니다.");
		System.out.println("안녕하세요? 방방곡곡 숙박 어플리케이션에 오신 걸 환영합니다.");
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.printf("%s\t%9s\t%s\t%s\n","1.로그인","2.지역설정","3.비회원 예약확인","0.종료");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.LOGIN_SCREEN;
		case 2:
			return View.SET_REGION;
		case 3:
			return View.RESERVATION_INFO_NON;
		case 0:
			System.out.println("시스템을 종료합니다.");
			System.exit(0);
			break;
		case 101: return View.TEST;
		}

		return View.HOME;
	}

	public static int show_normal() {
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println(currentMember.get("MEM_NM") + "님 환영합니다!\n");
		System.out.println("안녕하세요? 방방곡곡 숙박 어플리케이션에 오신 걸 환영합니다.");
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println("1.지역설정\t2.마이페이지\t100.로그아웃\t0.종료");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.SET_REGION;
		case 2:
			return View.MY_INFO;
		case 100:
			System.out.println("로그아웃되었습니다.");
			currentMember = null;
			return View.SHOW_NON;
		case 0:
			System.out.println("시스템을 종료합니다.");
			System.exit(0);
			break;
		}

		return View.SHOW_NORMAL;
	}

	public static int show_owner() {
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println(currentMember.get("MEM_NM") + "님 환영합니다.\n");
		System.out.println("안녕하세요? 방방곡곡 숙박 어플리케이션에 오신 걸 환영합니다.");
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println("1.지역설정\t2.마이페이지\t3.내 건물목록\t100.로그아웃\t0.종료");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.SET_REGION;
		case 2:
			return View.MY_INFO_OWNER;
		case 3:
			return View.MY_LODGE_LIST;
		case 100:
			System.out.println("로그아웃되었습니다.");
			currentMember = null;
			return View.SHOW_NON;
		case 0:
			System.out.println("시스템을 종료합니다.");
			System.exit(0);
			break;
		}

		return View.SHOW_OWNER;
	}
	
	public static int myInfoOwner() {
		printInfo();
		System.out.println("1.내정보수정\t2.회원탈퇴\t0.돌아가기");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.MY_INFO_UPDATE;
		case 2:
			return removeMem();
		case 0:
			return View.SHOW_OWNER;
		}
		return View.MY_INFO_OWNER;
	}

	public static int myLodgeList() {
		Map<String, Object> tmpLodge = null;
//		
		lodgeDao.showOwnList();
		System.out.println("1.관리건물 추가\t2.건물상세\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1:
			lodgeDao.addLodge();
			return View.MY_LODGE_LIST;
		case 2: 
//
			tmpLodge = lodgeDao.searchOwnerLodge();
			if (tmpLodge == null){
				System.out.println("해당 숙소가 존재하지 않습니다.");
				ScanUtil.stop(1000);
				return View.MY_LODGE_LIST;
			}else{
				LodgeService.currentLodge = tmpLodge;
				return View.LODGE_MANAGE;
			}
//
		case 0: return View.SHOW_OWNER;
		}
		return 0;
	}

	public static int myInfoNolmal() {
		printInfo();
		System.out.println("1.예약정보조회\t2.내정보수정\t3.장바구니 보기\t4.회원탈퇴\t0.돌아가기");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.RESERVATION_INFO;
		case 2:
			return View.MY_INFO_UPDATE;
		case 3:
			return View.CART_LIST;
		case 4:
			return removeMem();
		case 0:
			return View.SHOW_NORMAL;

		}
		return View.MY_INFO;
	}

	public static int removeMem() {
		
		System.out.println("정말로 회원탈퇴하시겠습니까? (Y/N)");
		int res = 0;
		String ans = ScanUtil.nextLine();

		if (ans.equals("Y") || ans.equals("y")) {
			System.out.println("기존비밀번호를 입력해주세요>");
			String pw = ScanUtil.nextLine();
			if(currentMember.get("MEM_PW").equals(pw)){
				res = memberDao.deleteMem();
				currentMember = null;
				System.out.println("회원탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
			}
			else{
				if((int)currentMember.get("MEM_CODE") == 1){
					return View.MY_INFO;
				} else if((int)currentMember.get("MEM_CODE") == 2){
					return View.MY_INFO_OWNER;
				}
			}
		} else if (ans.equals("N") || ans.equals("n")){
			res = 0;
		} else {
			System.out.println("잘못 입력하셨습니다. 다시 시도해주세요.");
		}
		
		if(res == 0 && (int)currentMember.get("MEM_CODE") == 1){
			return View.MY_INFO;
		} else if(res == 0 && (int)currentMember.get("MEM_CODE") == 2){
			return View.MY_INFO_OWNER;
		}
		return View.HOME;
	}


	public static int login_screen() {
		System.out.printf("%s\t%9s\t%s\t%s", "1.로그인","2.회원가입","3.비밀번호 찾기","0.뒤로가기\n");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.LOGIN;
		case 2:
			return View.JOIN;
		case 3:
			return forget_pw();
		case 0:
			break;
		}

		return View.HOME;
	}

	private static int forget_pw() {
		// 아이디를 입력받아서 비밀번호 찾기
		Map<String, Object> temp = new HashMap<>();

		System.out.println("아이디를 입력하세요.");
		String mem_id = ScanUtil.nextLine();
		System.out.println("이메일 주소를 입력하세요.");
		String mem_email = ScanUtil.nextLine();
		int res = View.LOGIN_SCREEN;
		
		temp = memberDao.searchPw(mem_id, mem_email);
		if(temp == null){
			System.out.println("계정이 존재하지 않습니다.");
			res = View.LOGIN_SCREEN;
		} else {
			System.out.println("찾은 비밀번호 : " + temp.get("MEM_PW"));
		}
		
		return res;
	}

	public static int logIn() {

		System.out.println("아이디 > ");
		String m_id = ScanUtil.nextLine();
		System.out.println("비밀번호 > ");
		String m_pw = ScanUtil.nextLine();

		// for문으로 해당 아이디 및 비밀번호가 존재하는지 확인
		Map<String, Object> member = memberDao.selectMem(m_id, m_pw);
		if (member == null || (int)member.get("MEM_ACTIVE") == 0) {
			System.out.println("해당 계정은 존재하지 않습니다.");
			System.out.println("다시 시도해주세요.");
			return View.LOGIN_SCREEN;
		} else {
			System.out.println("성공적으로 로그인되었습니다.");
			currentMember = member;
		}

		return View.HOME;
	}

	public static int join() {

		Map<String, Object> temp = new HashMap<>();
		int input = 0;

		System.out.println("일반 회원가입은 1번, 숙박업주 회원가입은 2번을 선택해주세요.");
		input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			System.out.println("일반회원으로 가입을 신청합니다.");
			break;
		case 2:
			System.out.println("숙박업주 회원으로 가입을 신청합니다.");
			break;
		default:
			System.out.println("조건에 맞지 않는 값을 입력하셨습니다.");
			System.out.println("다시 시도해주세요.");
			return View.LOGIN_SCREEN;
		}

		System.out.print("아이디(최소 4글자 이상 최대 12글자 이하) > ");
		temp.put("MEM_ID", validId(ScanUtil.nextLine()));
		if(temp.get("MEM_ID") == null){
			return View.LOGIN_SCREEN;
		}
		if (0 < memberDao.checkDoubleId(temp.get("MEM_ID"))) {
			System.out.println("중복된 아이디가 있습니다. 다시 시도해주세요.");
			return 0;
		}

		System.out.print("비밀번호(최소 4글자 이상 최대 12글자 이하) > ");
		temp.put("MEM_PW", validPw(ScanUtil.nextLine()));
		if(temp.get("MEM_PW") == null){
			return View.LOGIN_SCREEN;
		}

		System.out.print("이름 > ");
		temp.put("MEM_NM", ScanUtil.nextLine());

		System.out.print("전화번호 > ");
		temp.put("MEM_TEL",validTel(ScanUtil.nextLine()));
		if(temp.get("MEM_TEL") == null){
			return View.LOGIN_SCREEN;
		}

		System.out.print("이메일 >");
		temp.put("MEM_EMAIL", validEmail(ScanUtil.nextLine()));
		if(temp.get("MEM_EMAIL") == null){
			return View.LOGIN_SCREEN;
		}

		int res = memberDao.insertMem(temp, input);
		if (0 < res) {
			System.out.println("회원가입이 성공적으로 완료되었습니다.");
		} else {
			System.out.println("회원가입에 실패하셨습니다.");
		}

		return View.HOME;
	}

	public static int reservationInfo_non() {
		// 리스트로 넘어와서 해쉬맵으로 호출한다.
		Map<String, Object> temp = null;

		if (currentMember == null) {
			System.out.println("예약할 때 등록한 전화번호를 입력하세요.");
			String mem_tel = ScanUtil.nextLine();

			if (0 < memberDao.valid_mem(mem_tel)) {
				System.out.println("등록하신 전화번호는 회원전용 예약확인란에서 조회하십시오.");
				return View.SHOW_NON;
			}
			temp = memberDao.selectResH_Non(mem_tel);
			printResH(temp);

		} 

		return View.SHOW_NON;
	}

	public static int updateMyInfo() {
		System.out.println("기존비밀번호를 입력해주세요>");
		String pw = ScanUtil.nextLine();
		if(currentMember.get("MEM_PW").equals(pw)){
			
			try {
				System.out.println("수정할 비밀번호(최소 4글자 이상 최대 12글자 이하) > ");
				String mem_pw = validPw(ScanUtil.nextLine());
				if(mem_pw == null && (int)currentMember.get("MEM_CODE")!=2){
					return View.MY_INFO;
				} else if(mem_pw == null && (int)currentMember.get("MEM_CODE")==2){
					return View.MY_INFO_OWNER;
				}
				
				System.out.println("수정할 전화번호 > ");
				String mem_tel = validTel(ScanUtil.nextLine());
				if(mem_tel == null && (int)currentMember.get("MEM_CODE")!=2){
					return View.MY_INFO;
				} else if(mem_tel == null && (int)currentMember.get("MEM_CODE")==2){
					return View.MY_INFO_OWNER;
				}
				
				System.out.println("수정할 이메일 > ");
				String mem_email = validEmail(ScanUtil.nextLine());
				if(mem_email == null && (int)currentMember.get("MEM_CODE")!=2){
					return View.MY_INFO;
				} else if(mem_email == null && (int)currentMember.get("MEM_CODE")==2){
					return View.MY_INFO_OWNER;
				}
				
				if (memberDao.updateInfo(mem_pw, mem_tel, mem_email) != null) {
		            currentMember = memberDao.updateInfo(mem_pw, mem_tel, mem_email);
		            System.out.println("수정이 성공적으로 완료되었습니다.");
		         } else {
		            System.out.println("업데이트에 문제가 발생했습니다.\n다시 시도해주세요.");
		         }
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("수정할 수 없습니다.");
			if((int)currentMember.get("MEM_CODE") == 1){
				return View.MY_INFO;
			}else if((int)currentMember.get("MEM_CODE") == 2){
				return View.MY_INFO_OWNER;
			}
		}

		return View.HOME;
	}

	public static void showLoginMemberName() {
		if (currentMember == null) {
			System.out.println("로그인멤버가 설정되지 않음");
		} else {
			System.out.println(currentMember.get("MEM_NM") + "님 환영합니다");
		}
	}

	private static int printResH(Map<String, Object> temp) {

		if (temp == null) {
			System.out.println("입력하신 전화번호에는 예약정보가 존재하지 않습니다.");
			return View.SHOW_NON;
		}
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println("예약정보\n");
		System.out.println("예약번호 \t:\t" + temp.get("RESV_NO"));
		System.out.println("방번호 \t:\t" + temp.get("RO_NO") + "호실");
		System.out.println("입실일 \t:\t" + sdf.format(temp.get("RESV_SDATE")));
		System.out.println("퇴실일 \t:\t" + sdf.format(temp.get("RESV_EDATE")));
		System.out.println("결제일 \t:\t" + sdf.format(temp.get("ORD_DATE")));
		System.out.println("예약인원 \t:\t" + temp.get("RESV_CAP") + "명");
		System.out.println("총 가격 \t:\t" + temp.get("RESV_SUM"));
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");

		return 0;
	}
	
	public static String validId(String input){
		String str = null;
		String rex_id = "[a-zA-Z0-9*-_]{4,12}";
		p = null;
		m = null;
		
		//아이디일 경우
		p = Pattern.compile(rex_id);
		m = p.matcher(input);
		
		if(m.matches()){
			str = input;
		}else{
			System.out.println("최소 4글자 이상 12글자 이하의 알파뱃 대소문자와 숫자가 포함되어 있어야 합니다.");
			login_screen();
		}
		return str;
	}
	
	public static String validPw(String input){
		String str = null;
		String rex_id = "[a-zA-Z0-9*-_]{4,12}";
		p = null;
		m = null;
		
		//아이디일 경우
		p = Pattern.compile(rex_id);
		m = p.matcher(input);
		
		if(m.matches()){
			str = input;
		}else{
			System.out.println("최소 4글자 이상 12글자 이하의 알파뱃 대문자 또는 소문자와 숫자가 포함되어 있어야 합니다.");
		}
		return str;
	}
	
	public static String validTel(String input){
		String str = null;
		String rex_tel = "^0\\d{2}-\\d{3,4}-\\d{4}$";
		p = null;
		m = null;
		
		//아이디일 경우
		p = Pattern.compile(rex_tel);
		m = p.matcher(input);
		if(m.matches()){
			str = input;
		} else{
			System.out.println("\"000-000-000\" 또는 \"000-0000-0000\" 양식에 맞춰 입력되어야 합니다.");
		}
		
		return str;
	}
	
	public static String validEmail(String input){
		String str = null;
		String rex_email = "[a-z0-9_-]{3,20}@[a-zA-Z]+\\.(?i)(com|net|org|([a-z]{2}\\.kr))$";
		p = null;
		m = null;
		
		//아이디일 경우
		p = Pattern.compile(rex_email);
		m = p.matcher(input);
		if(m.matches()){
			str = input;
		}else{
			System.out.println("\"user.name@emailAddress.com\"의 알파뱃 대소문자로 시작해야 하며 숫자가 포함되어 있어야 합니다.");
		}
		
		return str;
	}
	
	public static void printInfo(){
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
		System.out.println("아이디\t:\t" + currentMember.get("MEM_ID"));
		System.out.println("이름\t:\t" + currentMember.get("MEM_NM"));
		System.out.println("전화번호\t:\t" + currentMember.get("MEM_TEL"));
		System.out.println("이메일주소\t:\t" + currentMember.get("MEM_EMAIL"));
		System.out.print("회원구분\t:\t");
		System.out.println((int)currentMember.get("MEM_CODE") == 1 ? "일반회원" : "숙박업주 회원");
		System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
	}

	public static int getMemNo() {

		return (currentMember != null) ? (int) currentMember.get("MEM_NO") : 0;
	}

}