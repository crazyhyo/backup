package kr.or.ddit.cmm.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.cmm.vo.AtchFileVO;

public interface IAtchFileService {

	/**
	 * 첨부파일 목록 조회하기
	 * @param atchFileVO
	 * @return 첨부파일 목록
	 * @throws SQLException
	 */
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO);
	
	/**
	 * 첨부파일 세부정보 조회하기
	 * @param atchFileVO
	 * @return
	 * @throws SQLException
	 */
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO);
	
	/**
	 * 첨부파일 목록을 저장하기 위한 메서드
	 * @param fileItemMap
	 * @return
	 */
	public AtchFileVO saveAtchFileList(Map<String, FileItem[]> fileItemMap) throws Exception;
	
}
