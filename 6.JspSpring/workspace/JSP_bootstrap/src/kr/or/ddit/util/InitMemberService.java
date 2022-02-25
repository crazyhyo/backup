package kr.or.ddit.util;

import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

public class InitMemberService {
	
	public static IMemberService initMemberService() {
		
		System.out.println("initMemberService 메서드 실행됨");
		IMemberService memberService = MemberServiceImpl.getInstance();
		SqlSessionFactory factory = SingletonOracleMyBatisSqlSessionFactory.getInstance();
		IMemberDao memberDao = MemberDaoImpl.getInstance();
		((MemberServiceImpl)memberService).setMemberDao(memberDao);
		((MemberServiceImpl)memberService).setSqlSessionFactory(factory);
		return memberService;
	}
}
