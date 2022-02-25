package kr.or.ddit.member.service;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;

public class MemberServiceImpl implements IMemberService{

	private IMemberDao memberDao;
	
	private static IMemberService memberService;
	
	private MemberServiceImpl() {
		memberDao = MemberDaoImpl.getInstance();
	}
	
	public static IMemberService getInstance() {
		if(memberService == null) {
			memberService = new MemberServiceImpl();
		}
		return memberService;
	}
	
	
}
