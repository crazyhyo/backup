package kr.or.ddit.company.service;

import java.util.List;

import kr.or.ddit.cmm.vo.CompanyPagingVO;
import kr.or.ddit.company.vo.CompanyVO;

public interface ICompanyService {
	
	public int getTotalCompanyCount();
	
	public List<CompanyVO> companyPagingList(CompanyPagingVO companyPagingVO);
}
