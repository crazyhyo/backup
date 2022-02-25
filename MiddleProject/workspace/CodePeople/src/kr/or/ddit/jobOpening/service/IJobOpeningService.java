package kr.or.ddit.jobOpening.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.cmm.vo.JobOpeningPagingVO;
import kr.or.ddit.jobOpening.vo.JobOpeningVO;

public interface IJobOpeningService {
	
	public int getTotalJobOpeningCount();
	
	public List<JobOpeningVO> jobOpeningPagingList(JobOpeningPagingVO jobOpeningPagingVO);

	public List<Map<String, Object>> jobOpeningCardList(JobOpeningPagingVO jobOpeningPagingVO);
	
	public List<Map<String, Object>> jobOpeningCardSearchList(HashMap jobOpeningSearchVO);
	
	public int getTotalJobOpeningSearchCount(HashMap jobOpeningSearchVO);
}
