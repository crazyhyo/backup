package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberDTO;

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

	@Override
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO = null;
		try {
			memberDTO = memberDao.getMember(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberDTO;
	}

	@Override
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> list = null;
		try {
			list = memberDao.getMemberList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int registerMember(MemberDTO memberDTO) {
		int cnt = 0;
		try {
			cnt = memberDao.registerMember(memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateMember(MemberDTO memberDTO) {
		int cnt = 0;
		try {
			cnt = memberDao.updateMember(memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteMember(String id) {
		int cnt = 0;
		try {
			cnt = memberDao.deleteMember(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public List<MemberDTO> searchMember(MemberDTO memberDTO) {
		List<MemberDTO> list = null;
		try {
			list = memberDao.searchMember(memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
