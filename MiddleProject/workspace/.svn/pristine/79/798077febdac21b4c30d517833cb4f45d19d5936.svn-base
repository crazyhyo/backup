package kr.or.ddit.jobOpening.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.cmm.vo.JobOpeningPagingVO;
import kr.or.ddit.jobOpening.vo.JobOpeningVO;

public interface IJobOpeningDao {

	
	public int getTotalJobOpeningCount() throws SQLException;
	
	public List<JobOpeningVO> jobOpeningPagingList(JobOpeningPagingVO jobOpeningPagingVO) throws SQLException;
	
	public List<Map<String, Object>> jobOpeningCardList(JobOpeningPagingVO jobOpeningPagingVO) throws SQLException;
	
	public List<Map<String, Object>> jobOpeningCardSearchList(HashMap jobOpeningSearchVO) throws SQLException;
	
	public int getTotalJobOpeningSearchCount(HashMap jobOpeningSearchVO) throws SQLException;
}
