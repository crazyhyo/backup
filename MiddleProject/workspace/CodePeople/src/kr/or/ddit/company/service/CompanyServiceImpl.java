package kr.or.ddit.company.service;

import java.util.List;

import kr.or.ddit.company.dao.ICompanyDao;
import kr.or.ddit.cmm.vo.CompanyPagingVO;
import kr.or.ddit.company.dao.CompanyDaoImpl;
import kr.or.ddit.company.vo.CompanyVO;

public class CompanyServiceImpl implements ICompanyService{

	private ICompanyDao dao;
	private static ICompanyService service;
	
	private CompanyServiceImpl() {
		dao = CompanyDaoImpl.getInstance();
	}
	public static ICompanyService getInstance() {
		if(service == null) {
			service = new CompanyServiceImpl();
		}
		return service;
	}
	@Override
	public int getTotalCompanyCount() {
		int cnt = 0;
		try {
			cnt = dao.getTotalCompanyCount();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public List<CompanyVO> companyPagingList(CompanyPagingVO companyPagingVO) {
		List<CompanyVO> list = null;
		try {
			list = dao.companyPagingList(companyPagingVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}	

}
