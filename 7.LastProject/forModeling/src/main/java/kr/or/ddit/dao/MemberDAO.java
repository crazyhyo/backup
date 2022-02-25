package kr.or.ddit.dao;

import java.sql.SQLException;

public interface MemberDAO {
	
	public int selectMberGenSeqNext() throws SQLException;
}
