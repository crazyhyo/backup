package kr.or.ddit.cmm.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.cmm.vo.AtchFileVO;

public interface IAtchFileDao {
	
	
	/**
	 * 첨부파일 저장		
	 * @param atchFileVO
	 * @return
	 * @throws SQLException
	 */
	public int insertAtchFile(AtchFileVO atchFileVO) throws SQLException;

	/**
	 * 첨부파일 세부정보 저장
	 * @param atchFileVO
	 * @return
	 * @throws SQLException
	 */
	public int insertAtchFileDetail(AtchFileVO atchFileVO) throws SQLException;
	
	/**
	 * 첨부파일 목록 조회하기
	 * @param atchFileVO
	 * @return 첨부파일 목록
	 * @throws SQLException
	 */
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO) throws SQLException;
	
	/**
	 * 첨부파일 세부정보 조회하기
	 * @param atchFileVO
	 * @return
	 * @throws SQLException
	 */
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO) throws SQLException;
}
