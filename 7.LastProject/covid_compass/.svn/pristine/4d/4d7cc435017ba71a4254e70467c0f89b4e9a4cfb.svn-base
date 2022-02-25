package com.spring.compass.service;

import com.spring.compass.dao.PbhtDAO;
import com.spring.compass.vo.PbhtVO;

public class PbhtServiceImplLKH extends PbhtServiceImpl implements PbhtServiceLKH{

	private PbhtDAO pbhtDAO;
	public void setPbhtDAO(PbhtDAO pbhtDAO) {
		this.pbhtDAO = pbhtDAO;
	}
	@Override
	public PbhtVO getPbhtByPbhtNo(String pbhtNo) throws Exception {
		PbhtVO pbht = pbhtDAO.selectPbhtByPbhtNo(pbhtNo);
		return pbht;
	}

}
