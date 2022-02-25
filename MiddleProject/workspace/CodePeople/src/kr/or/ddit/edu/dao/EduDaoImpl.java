package kr.or.ddit.edu.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.edu.vo.EduVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class EduDaoImpl implements IEduDao{
	
	private String nameSpace = "edu.";
	private SqlMapClient smc;
	private static IEduDao dao;
	private EduDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IEduDao getInstance() {
		if(dao == null) {
			dao = new EduDaoImpl();
		}
		return dao;
	}


	@Override
	public List<EduVO> selectEduCodeList() throws SQLException {
		List<EduVO> list = null;
		list = (List<EduVO>) smc.queryForList(nameSpace + "selectEduCodeList");
		return list;
	}


}
