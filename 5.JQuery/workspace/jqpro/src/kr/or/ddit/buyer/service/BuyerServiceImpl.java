package kr.or.ddit.buyer.service;

import java.util.List;

import kr.or.ddit.buyer.dao.BuyerDaoImpl;
import kr.or.ddit.buyer.dao.IBuyerDao;
import kr.or.ddit.buyer.vo.BuyerVO;

public class BuyerServiceImpl implements IBuyerService{
	
	private IBuyerDao buyerDao;
	
	private static IBuyerService buyerService;
	
	private BuyerServiceImpl() {
		buyerDao = BuyerDaoImpl.getInstance();
	}
	
	public static IBuyerService getInstance() {
		if(buyerService == null) {
			buyerService = new BuyerServiceImpl();
		}
		return buyerService;
	}
	
	@Override
	public List<BuyerVO> selectBuyerName() {
		return buyerDao.selectBuyerName();
	}

	@Override
	public BuyerVO selectBuyerDetail(String buyer_id) {
		return buyerDao.selectBuyerDetail(buyer_id);
	}

}
