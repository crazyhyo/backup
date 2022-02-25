package kr.or.ddit.certification.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.certification.vo.CertificationVO;

public interface ICertDao {
	public List<CertificationVO> selectCertList() throws SQLException;
}
