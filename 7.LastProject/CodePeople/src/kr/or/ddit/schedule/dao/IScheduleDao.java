package kr.or.ddit.schedule.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.schedule.vo.ScheduleVO;


public interface IScheduleDao {
	
	public List<ScheduleVO> joScheduleList() throws SQLException;
}
