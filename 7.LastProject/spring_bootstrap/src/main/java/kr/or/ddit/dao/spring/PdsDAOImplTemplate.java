package kr.or.ddit.dao.spring;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.jsp.command.SearchCriteria;
import com.jsp.dao.PdsDAO;
import com.jsp.dto.PdsVO;

public class PdsDAOImplTemplate implements PdsDAOBean{
	
	private PdsDAO pdsDAO;
	private SqlSession session;

	public void setPdsDAO(PdsDAO pdsDAO) {
		this.pdsDAO = pdsDAO;
	}

	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<PdsVO> selectSearchPdsList(SearchCriteria cri) throws SQLException {
		return pdsDAO.selectSearchPdsList(session, cri);
	}

	@Override
	public int selectSearchPdsListCount(SearchCriteria cri) throws SQLException {
		return pdsDAO.selectSearchPdsListCount(session, cri);
	}

	@Override
	public PdsVO selectPdsByPno(int pno) throws SQLException {
		return pdsDAO.selectPdsByPno(session, pno);
	}

	@Override
	public void insertPds(PdsVO pds) throws SQLException {
		pdsDAO.insertPds(session, pds);
	}

	@Override
	public void updatePds(PdsVO pds) throws SQLException {
		pdsDAO.updatePds(session, pds);
	}

	@Override
	public void deletePds(int pno) throws SQLException {
		pdsDAO.deletePds(session, pno);
	}

	@Override
	public void increaseViewCnt(int pno) throws SQLException {
		pdsDAO.increaseViewCnt(session, pno);
	}

	@Override
	public int selectPdsSeqNext() throws SQLException {
		return pdsDAO.selectPdsSeqNext(session);
	}

	@Override
	public PdsVO selectPdsByImage(String imageFile) throws SQLException {
		PdsVO pds = session.selectOne("Pds-Mapper.selectPdsByImage", imageFile);
		return pds;
	}

}
