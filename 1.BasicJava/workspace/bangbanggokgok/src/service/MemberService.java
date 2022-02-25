package service;

import java.util.Map;

public class MemberService {
	public static Map<String, Object> currentMember = null;
	
	public static int getLoginMemberNo(){
		if(currentMember == null){
			System.out.println("현재 로그인중이 아닙니다.");
			return -1;
		}
		return (int)currentMember.get("MEM_NO");
	}
	public static int getLoginMemberCode(){
		if(currentMember == null){
			System.out.println("현재 로그인중이 아닙니다.");
			return -1;
		}
		return (int)MemberService.currentMember.get("MEM_CODE");
	}
	
	public static void showLoginMemberName() {
		if(currentMember == null) {
			System.out.println("로그인멤버가 설정되지 않음");
		}else {
			System.out.println(currentMember.get("MEM_NM") + "님 환영합니다");
		}
	}
}
