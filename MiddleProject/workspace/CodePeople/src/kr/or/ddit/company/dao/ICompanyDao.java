package kr.or.ddit.company.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.cmm.vo.CompanyPagingVO;
import kr.or.ddit.company.vo.CompanyVO;

public interface ICompanyDao {
	
	public int getTotalCompanyCount() throws SQLException;
	
	public List<CompanyVO> companyPagingList(CompanyPagingVO companyPagingVO) throws SQLException;
}
