package kr.or.ddit.prod.service;

import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.ibatis.config.SqlMapClientFactory;
import kr.or.ddit.prod.dao.IProdDao;
import kr.or.ddit.prod.dao.ProdDaoImpl;
import kr.or.ddit.prod.vo.ProdVO;

public class ProdServiceImpl implements IProdService{
	
	
	private IProdDao prodDao;
	private static IProdService prodService;
	
	private ProdServiceImpl() {
		prodDao = ProdDaoImpl.getInstance();
	}
	
	public static IProdService getInstance() {
		if(prodService == null) {
			prodService = new ProdServiceImpl();
		}
		return prodService;
	}
	
	@Override
	public List<ProdVO> selectProdByLGU(String prod_lgu) {
		return prodDao.selectProdByLGU(prod_lgu);
	}

	@Override
	public ProdVO selectProdById(String prod_id) {
		return prodDao.selectProdById(prod_id);
	}

}
