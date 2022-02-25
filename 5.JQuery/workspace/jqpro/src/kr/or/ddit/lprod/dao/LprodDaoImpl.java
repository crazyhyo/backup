package kr.or.ddit.lprod.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.ibatis.config.SqlMapClientFactory;
import kr.or.ddit.lprod.vo.LprodVO;

public class LprodDaoImpl implements ILprodDao{
	
	private static LprodDaoImpl lprodDao;
	
	private SqlMapClient smc;
	
	private LprodDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static ILprodDao getInstance() {
		if(lprodDao == null) {
			lprodDao = new LprodDaoImpl();
		}
		return lprodDao;
	}
	
	@Override
	public List<LprodVO> selectAllLItem() {
		
		List<LprodVO> list = null;
		
		try {
			list = (List<LprodVO>)smc.queryForList("lprod.selectAllLItem");
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return list;
	}

}
