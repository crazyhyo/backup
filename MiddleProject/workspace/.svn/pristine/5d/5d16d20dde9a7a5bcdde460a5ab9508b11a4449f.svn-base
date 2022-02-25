package kr.or.ddit.progLang.service;

import java.util.List;

import kr.or.ddit.progLang.dao.IProgLangDao;
import kr.or.ddit.progLang.dao.ProgLangDaoImpl;
import kr.or.ddit.progLang.vo.ProgLangVO;

public class ProgLangServiceImpl implements IProgLangService{

	private IProgLangDao dao;
	private static IProgLangService service;
	
	private ProgLangServiceImpl() {
		dao = ProgLangDaoImpl.getInstance();
	}
	public static IProgLangService getInstance() {
		if(service == null) {
			service = new ProgLangServiceImpl();
		}
		return service;
	}	

	@Override
	public List<ProgLangVO> selectProgLangList() {
		List<ProgLangVO> list = null;
		try {
			list = dao.selectProgLangList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
