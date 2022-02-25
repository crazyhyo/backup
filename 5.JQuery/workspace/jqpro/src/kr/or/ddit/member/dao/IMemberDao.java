package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberDao {
	
	// transaction 단위로 수행되기 위하여 dao에서는 throw로 처리한다.
	public String selectByMemId(String mem_id) throws SQLException;
	
	public List<ZipVO> selectZipCode(String add2) throws SQLException;
	
	public String insertMember(MemberVO mv) throws SQLException;
}
