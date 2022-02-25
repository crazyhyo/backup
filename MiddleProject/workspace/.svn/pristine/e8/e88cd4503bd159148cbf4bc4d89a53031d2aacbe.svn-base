package kr.or.ddit.member.dao;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.util.SqlMapClientFactory;

public class MemberDaoImpl implements IMemberDao{
	
	SqlMapClient smc;
	
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
	
	
	
}
