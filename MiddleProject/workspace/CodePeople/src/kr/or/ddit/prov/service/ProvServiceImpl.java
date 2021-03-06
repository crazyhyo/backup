package kr.or.ddit.prov.service;

import java.util.List;

import kr.or.ddit.prov.dao.IProvDao;
import kr.or.ddit.prov.dao.ProvDaoImpl;
import kr.or.ddit.prov.vo.CityVO;
import kr.or.ddit.prov.vo.ProvVO;

public class ProvServiceImpl implements IProvService{

	private IProvDao dao;
	private static IProvService service;
	
	private ProvServiceImpl() {
		dao = ProvDaoImpl.getInstance();
	}
	public static IProvService getInstance() {
		if(service == null) {
			service = new ProvServiceImpl();
		}
		return service;
	}	

	@Override
	public List<CityVO> selectCityList() {
		List<CityVO> list = null;
		try {
			list = dao.selectCityList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<ProvVO> selectProvList(int city_code_no) {
		List<ProvVO> list = null;
		try {
			list = dao.selectProvList(city_code_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
