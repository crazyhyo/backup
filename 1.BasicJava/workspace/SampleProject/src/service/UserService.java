package service;

import java.util.HashMap;
import java.util.Map;
import controller.Controller;
import util.ScanUtil;
import util.View;
import dao.UserDao;

public class UserService {

	//싱글톤 패턴
	private UserService(){}
	private static UserService instance;
	public static UserService getInstance(){
		if(instance == null){
			instance = new UserService();
		}
		return instance;
	}
	
	private UserDao userDao = UserDao.getInstance();
	
	public int join(){
		System.out.println("========================회원가입========================");
		System.out.print("아이디>");
		String userId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String password = ScanUtil.nextLine();
		System.out.print("이름>");
		String userName = ScanUtil.nextLine();
		//아이디 중복 확인 생략
		
		//비밀번호 확인 생략
		//유효성 검사(정규표현식) 생략
		
		Map<String, Object> param = new HashMap<>();
		param.put("USER_ID", userId);
		param.put("PASSWORD", password);
		param.put("USER_NAME", userName);
		
		int result = userDao.insertUser(param);
		
		if(0 < result){
			System.out.println("회원가입 성공");
		}else{
			System.out.println("회원가입 실패");
		}
		
		return View.HOME;
		
	}

	public int login() {
		System.out.println("========================로 그 인========================");
		System.out.print("아이디>");
		String userId = ScanUtil.nextLine();
		System.out.print("비밀번호>");
		String password = ScanUtil.nextLine();
		
		Map<String, Object> user = userDao.selectUser(userId, password);
		
		if(user == null){
			System.out.println("아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
		}else{
			System.out.println("로그인 성공");
			//웹개발에서는 세션이라는 공간에 로그인한 유저의 정보를 저장해둠
			Controller.loginUser = user;
			return View.BOARD_LIST;
		}
		
		return View.HOME;
	}
	
	
}
