package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberServiceImpl implements IMemberService{

	private static IMemberService memberService;
	
	private IMemberDao memberDao;
	
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
	public String selectByMemId(String mem_id){
		String id = null;
		try {
			id = memberDao.selectByMemId(mem_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}

	@Override
	public List<ZipVO> selectZipCode(String add2) {
		List<ZipVO> list = null;
		try {
			list = memberDao.selectZipCode(add2);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public String insertMember(MemberVO mv) {
		String mem_id = null;
		try {
			mem_id = memberDao.insertMember(mv);
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
		return mem_id;
	}

}
