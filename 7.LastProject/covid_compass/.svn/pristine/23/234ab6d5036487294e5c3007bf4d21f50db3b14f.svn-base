package com.spring.compass.service;

import com.spring.compass.dao.LtctDAO;
import com.spring.compass.vo.LtctVO;

public class LtctServiceImplLKH extends LtctServiceImpl implements LtctServiceLKH{
	
	private LtctDAO ltctDAO;
	public void setLtctDAO(LtctDAO ltctDAO) {
		this.ltctDAO = ltctDAO;
	}
	
	@Override
	public LtctVO getLtctByLtctNo(String ltctNo) throws Exception {

		LtctVO ltct = ltctDAO.selectLtctByLtctNo(ltctNo);
		return ltct;
	}

}
