package kr.or.ddit.progLang.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.progLang.vo.ProgLangVO;

public interface IProgLangDao {
	public List<ProgLangVO> selectProgLangList() throws SQLException;
}
