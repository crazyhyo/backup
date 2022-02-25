package kr.or.ddit.progLang.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.progLang.vo.ProgLangVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class ProgLangDaoImpl implements IProgLangDao{
	
	private String nameSpace = "progLang.";
	
	private SqlMapClient smc;
	private static IProgLangDao dao;
	private ProgLangDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IProgLangDao getInstance() {
		if(dao == null) {
			dao = new ProgLangDaoImpl();
		}
		return dao;
	}


	@Override
	public List<ProgLangVO> selectProgLangList() throws SQLException {
		List<ProgLangVO> list = null;
		list = (List<ProgLangVO>) smc.queryForList(nameSpace + "selectProgLangList");
		return list;
	}


}
