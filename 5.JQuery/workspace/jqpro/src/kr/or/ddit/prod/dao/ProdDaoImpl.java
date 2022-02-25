package kr.or.ddit.prod.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.ibatis.config.SqlMapClientFactory;
import kr.or.ddit.prod.vo.ProdVO;
import sun.security.jca.GetInstance;

public class ProdDaoImpl implements IProdDao{
	
	private SqlMapClient smc;
	
	private static IProdDao prodDao;
	
	private ProdDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IProdDao getInstance() {
		if(prodDao == null) {
			prodDao = new ProdDaoImpl();
		}
		return prodDao;
	}
	
	@Override
	public List<ProdVO> selectProdByLGU(String prod_lgu) {
		
		List<ProdVO> prodList = null;
				
		try {
			prodList = (List<ProdVO>)smc.queryForList("prod.selectProdByLGU", prod_lgu);
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		
		return prodList;
	}

	@Override
	public ProdVO selectProdById(String prod_id) {
		ProdVO prod = null;
		
		try {
			prod = (ProdVO) smc.queryForObject("prod.selectProdById", prod_id);
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return prod;
	}
	
}
