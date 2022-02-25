package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.util.SqlMapClientFactory;

public class MemberDaoImpl implements IMemberDao{
	
	private String nameSpace = "member.";
	private SqlMapClient smc;
	private static IMemberDao memberDao;
	
	private MemberDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IMemberDao getInstance() {
		if(memberDao == null) {
			memberDao = new MemberDaoImpl();
		}
		return memberDao;
	}

	@Override
	public MemberDTO getMember(String id) throws SQLException {
		MemberDTO memberDTO = null;
		memberDTO = (MemberDTO)smc.queryForObject(nameSpace + "getMember", id);
		return memberDTO;
	}

	@Override
	public List<MemberDTO> getMemberList() throws SQLException {
		List<MemberDTO> list = null;
		list = (List<MemberDTO>)smc.queryForList(nameSpace + "getMemberList");
		return list;
	}

	@Override
	public int registerMember(MemberDTO memberDTO) throws SQLException {
		int cnt = 0;
		Object obj = null;
		obj = smc.insert(nameSpace + "registerMember", memberDTO);
		cnt = obj == null ? 1 : 0;
		return cnt;
	}

	@Override
	public int updateMember(MemberDTO memberDTO) throws SQLException {
		int cnt = 0;
		cnt = smc.update(nameSpace + "updateMember", memberDTO);
		return cnt;
	}

	@Override
	public int deleteMember(String id) throws SQLException {
		int cnt = 0;
		cnt = smc.delete(nameSpace + "deleteMember", id);
		return cnt;
	}

	@Override
	public List<MemberDTO> searchMember(MemberDTO memberDTO) throws SQLException {
		List<MemberDTO> list = null;
		list = (List<MemberDTO>)smc.queryForList(nameSpace + "searchMember", memberDTO);
		return list;
	}
	
}
