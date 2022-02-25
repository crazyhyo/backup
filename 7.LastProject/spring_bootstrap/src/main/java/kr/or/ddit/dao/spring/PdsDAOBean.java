package kr.or.ddit.dao.spring;

import java.sql.SQLException;
import java.util.List;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.PdsVO;

public interface PdsDAOBean {
	public List<PdsVO> selectSearchPdsList(SearchCriteria cri) throws SQLException;

	public int selectSearchPdsListCount(SearchCriteria cri) throws SQLException;

	public PdsVO selectPdsByPno(int pno) throws SQLException;
	
	public PdsVO selectPdsByImage(String imageFile) throws SQLException;

	public void insertPds(PdsVO pds) throws SQLException;

	public void updatePds(PdsVO pds) throws SQLException;

	public void deletePds(int pno) throws SQLException;

	public void increaseViewCnt(int pno) throws SQLException;

	public int selectPdsSeqNext() throws SQLException;

}
