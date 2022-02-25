package kr.or.ddit.cmm.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.cmm.vo.AtchFileVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class AtchFileDaoImpl implements IAtchFileDao{
	
	private static IAtchFileDao dao;
	private SqlMapClient smc;

	private AtchFileDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IAtchFileDao getInstance() {
		if(dao == null) {
			dao = new AtchFileDaoImpl();
		}
		return dao;
	}

	@Override
	public int insertAtchFile(AtchFileVO atchFileVO) throws SQLException {
		int cnt = 0;
		Object obj =smc.insert("atch_file.insertAtchFile", atchFileVO); 
		cnt = obj == null ? 1 : 0;
		return cnt;
	}

	@Override
	public int insertAtchFileDetail(AtchFileVO atchFileVO) throws SQLException {
		int cnt = 0;
		Object obj =smc.insert("atch_file.insertAtchFileDetail", atchFileVO); 
		cnt = obj == null ? 1 : 0;
		return cnt;
	}

	@Override
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO) throws SQLException {
		List<AtchFileVO> list = null;
		list = (List<AtchFileVO>)smc.queryForList("atch_file.getAtchFileList", atchFileVO);
		return list;
	}

	@Override
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO) throws SQLException {
		AtchFileVO fileVO = null;
		fileVO = (AtchFileVO)smc.queryForObject("atch_file.getAtchFileDetail", atchFileVO);
		return fileVO;
	}

}
