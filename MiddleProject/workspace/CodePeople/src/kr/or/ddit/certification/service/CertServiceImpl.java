package kr.or.ddit.certification.service;

import java.util.List;

import kr.or.ddit.certification.dao.ICertDao;
import kr.or.ddit.certification.dao.CertDaoImpl;
import kr.or.ddit.certification.vo.CertificationVO;

public class CertServiceImpl implements ICertService{

	private ICertDao dao;
	private static ICertService service;
	
	private CertServiceImpl() {
		dao = CertDaoImpl.getInstance();
	}
	public static ICertService getInstance() {
		if(service == null) {
			service = new CertServiceImpl();
		}
		return service;
	}	

	@Override
	public List<CertificationVO> selectCertList() {
		List<CertificationVO> list = null;
		try {
			list = dao.selectCertList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
