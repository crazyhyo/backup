package kr.or.ddit.buyer.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.buyer.vo.BuyerVO;
import kr.or.ddit.ibatis.config.SqlMapClientFactory;

public class BuyerDaoImpl implements IBuyerDao{
	
	private SqlMapClient client;
	
	private static IBuyerDao dao;
	
	private BuyerDaoImpl() {
		client = SqlMapClientFactory.getInstance();
	}
	
	public static IBuyerDao getInstance() {
		if(dao == null) {
			dao = new BuyerDaoImpl();
		}
		
		return dao;
	}
	
	
	@Override
	public List<BuyerVO> selectBuyerName() {
		List buyerList = null;
		try {
			buyerList = (List<BuyerVO>) client.queryForList("buyer.selectBuyerName");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return buyerList;
	}

	@Override
	public BuyerVO selectBuyerDetail(String buyer_id) {
		BuyerVO buyer = null;
		try {
			buyer = (BuyerVO) client.queryForObject("buyer.selectBuyerDetail", buyer_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return buyer;
	}

}
