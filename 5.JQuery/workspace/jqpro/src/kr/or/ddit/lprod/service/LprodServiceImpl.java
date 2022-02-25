package kr.or.ddit.lprod.service;

import java.util.List;

import kr.or.ddit.lprod.dao.ILprodDao;
import kr.or.ddit.lprod.dao.LprodDaoImpl;
import kr.or.ddit.lprod.vo.LprodVO;

public class LprodServiceImpl implements ILprodService{

	private ILprodDao lprodDao;
	private static LprodServiceImpl lprodService;
	
	private LprodServiceImpl() {
		lprodDao = LprodDaoImpl.getInstance();
	}
	
	public static ILprodService getInstance() {
		if(lprodService == null) {
			lprodService = new LprodServiceImpl();
		}
		return lprodService;
	}
	
	@Override
	public List<LprodVO> selectAllLItem() {
		return lprodDao.selectAllLItem();
	}

}
