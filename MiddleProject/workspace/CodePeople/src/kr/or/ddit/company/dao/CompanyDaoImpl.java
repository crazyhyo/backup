package kr.or.ddit.company.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.cmm.vo.CompanyPagingVO;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class CompanyDaoImpl implements ICompanyDao{
	
	private String nameSpace = "company.";
	private SqlMapClient smc;
	private static ICompanyDao dao;
	private CompanyDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static ICompanyDao getInstance() {
		if(dao == null) {
			dao = new CompanyDaoImpl();
		}
		return dao;
	}

	@Override
	public int getTotalCompanyCount() throws SQLException {
		int cnt = 0;
		cnt = (int)smc.queryForObject(nameSpace + "getTotalCompanyCount");
		return cnt;
	}

	@Override
	public List<CompanyVO> companyPagingList(CompanyPagingVO companyPagingVO) throws SQLException {
		List<CompanyVO> list = null;
		list = (List<CompanyVO>)smc.queryForList(nameSpace + "companyPagingList", companyPagingVO);
		return list;
	}



}
