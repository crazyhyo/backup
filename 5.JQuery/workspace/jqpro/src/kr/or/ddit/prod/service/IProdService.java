package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.prod.vo.ProdVO;

public interface IProdService {
	
	public List<ProdVO> selectProdByLGU(String prod_lgu);
	
	public ProdVO selectProdById(String prod_id);
}
