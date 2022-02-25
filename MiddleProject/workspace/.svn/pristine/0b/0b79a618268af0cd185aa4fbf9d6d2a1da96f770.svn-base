package kr.or.ddit.certification.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.certification.vo.CertificationVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class CertDaoImpl implements ICertDao{
	
	private String nameSpace = "certification.";
	private SqlMapClient smc;
	private static ICertDao dao;
	private CertDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static ICertDao getInstance() {
		if(dao == null) {
			dao = new CertDaoImpl();
		}
		return dao;
	}


	@Override
	public List<CertificationVO> selectCertList() throws SQLException {
		List<CertificationVO> list = null;
		list = (List<CertificationVO>) smc.queryForList(nameSpace + "selectCertList");
		return list;
	}


}
