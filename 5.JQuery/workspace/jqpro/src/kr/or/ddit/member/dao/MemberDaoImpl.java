package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.ibatis.config.SqlMapClientFactory;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

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
	public String selectByMemId(String mem_id) throws SQLException {
		String memId = null;
		memId = (String)smc.queryForObject(nameSpace + "selectByMemId", mem_id);
		return memId;
	}

	@Override
	public List<ZipVO> selectZipCode(String add2) throws SQLException {
		List<ZipVO> list = null;
		list = (List<ZipVO>)smc.queryForList(nameSpace + "selectZipCode", add2);
		return list;
	}

	@Override
	public String insertMember(MemberVO mv) throws SQLException {
		String mem_id = null;
		mem_id = (String) smc.insert(nameSpace + "insertMember", mv);
		return mem_id;
	}


}
