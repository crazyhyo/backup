package kr.or.ddit.hr.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.cmm.vo.HRPagingVO;
import kr.or.ddit.hr.vo.HRCardVO;
import kr.or.ddit.hr.vo.HRSearchVO;
import kr.or.ddit.hr.vo.HRVO;

public interface IHRService {
	

	public int getTotalHRCount();
	
	public List<HRVO> hrPagingList(HRPagingVO hrPagingVO);

	public List<HRCardVO> hrCardPagingList(HRPagingVO hrPagingVO); 
	
	public List<HRCardVO> hrCardPagingSearchList(HRSearchVO hrSearchVO);
	
	public int getTotalCardSearchCount(HRSearchVO hrSearchVO);
}
