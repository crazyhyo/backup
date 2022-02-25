package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberService {

	// 서비스에서는 여러 dao의 mapper를 사용하여 하나의 트랜젝션을 구성하고 모두 완료된 경우가 아니면 모두 try-catch로 처리한다.
	public String selectByMemId(String mem_id);
	
	public List<ZipVO> selectZipCode(String add2);
	
	public String insertMember(MemberVO mv);
}
