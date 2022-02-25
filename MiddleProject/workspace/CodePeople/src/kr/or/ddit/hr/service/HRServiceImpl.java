package kr.or.ddit.hr.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.cmm.vo.HRPagingVO;
import kr.or.ddit.hr.dao.IHRDao;
import kr.or.ddit.hr.dao.HRDaoImpl;
import kr.or.ddit.hr.vo.HRCardVO;
import kr.or.ddit.hr.vo.HRSearchVO;
import kr.or.ddit.hr.vo.HRVO;

public class HRServiceImpl implements IHRService{

	private IHRDao dao;
	private static IHRService service;
	
	private HRServiceImpl() {
		dao = HRDaoImpl.getInstance();
	}

	public static IHRService getInstance() {
		if(service == null) {
			service = new HRServiceImpl();
		}
		return service;
	}
	@Override
	public int getTotalHRCount() {
		int cnt = 0;
		try {
			cnt = dao.getTotalHRCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	@Override
	public List<HRVO> hrPagingList(HRPagingVO hrPagingVO) {
		List<HRVO> list = null;
		try {
			list = dao.hrPagingList(hrPagingVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}	
	
	@Override
	public List<HRCardVO> hrCardPagingList(HRPagingVO hrPagingVO) {
		List<HRCardVO> list = null;
		try {
			list = dao.hrCardPagingList(hrPagingVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<HRCardVO> hrCardPagingSearchList(HRSearchVO hrSearchVO) {
		List<HRCardVO> list = null;
		try {
			list = dao.hrCardPagingSearchList(hrSearchVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int getTotalCardSearchCount(HRSearchVO hrSearchVO) {
		int cnt = 0;
		try {
			cnt = dao.getTotalCardSearchCount(hrSearchVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
