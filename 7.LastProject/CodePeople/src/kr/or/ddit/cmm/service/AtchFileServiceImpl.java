package kr.or.ddit.cmm.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

import kr.or.ddit.cmm.dao.AtchFileDaoImpl;
import kr.or.ddit.cmm.dao.IAtchFileDao;
import kr.or.ddit.cmm.vo.AtchFileVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class AtchFileServiceImpl implements IAtchFileService{
	
	private static Logger logger = Logger.getLogger(AtchFileServiceImpl.class);	// 로거 생성
	private IAtchFileDao fileDao;
	private static IAtchFileService fileService;
	
	private AtchFileServiceImpl() {
		fileDao = AtchFileDaoImpl.getInstance();
	}
	
	public static IAtchFileService getInstance() {
		if(fileService == null) {
			fileService = new AtchFileServiceImpl();
		}
		return fileService;
	}

	@Override
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO) {
		List<AtchFileVO> list = null;
		try {
			list = fileDao.getAtchFileList(atchFileVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO) {
		AtchFileVO fileVO = null;
		try {
			fileVO = fileDao.getAtchFileDetail(atchFileVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return fileVO;
	}

	@Override
	public AtchFileVO saveAtchFileList(Map<String, FileItem[]> fileItemMap) throws Exception {
		AtchFileVO atchFileVO = new AtchFileVO();
		int cnt = 0;
		
		try {
			cnt = fileDao.insertAtchFile(atchFileVO); // 기본 첨부파일 테이블 저장
			
			for(FileItem[] itemArr : fileItemMap.values()) {
				
				for(FileItem item : itemArr) {
					
					File uploadDir = new File(FileUploadRequestWrapper.UPLOAD_DIRECTORY);
					if(!uploadDir.exists()) {
						uploadDir.mkdir();
					}
					
					logger.info("item.getName() => " + item.getName());
					
					String originalFileName = item.getName();	// 원본 파일명
					Integer fileSize = (int) item.getSize();             // 파일크기
					String saveFileName = "";                   // 저장파일명
					File storeFile = null;                      // 저장파일객체
					String saveFilePath = "";					// 저장파일경로
					
					do {
						// 저장파일 생성하기
						saveFileName = UUID.randomUUID().toString().replace("-", "");
						saveFilePath = FileUploadRequestWrapper.UPLOAD_DIRECTORY
										+ File.separator + saveFileName;
						storeFile = new File(saveFilePath);

						
					}while(storeFile.exists()); // 저장파일이 중복되지 않을 때까지(UUID로 만든 파일명이
												// 중복되는 경우도 있음.) 이 경우에도 확실하게 중복없이 생성하기 위한
												// do while문
					
					// 확장자명 추출
					String fileExtension = 
							originalFileName.lastIndexOf(".") < 0 ?
							"" : originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
					
					item.write(storeFile); // 업로드 파일 저장
					
					atchFileVO.setStreFileNm(saveFileName);
					atchFileVO.setFileSize(fileSize);
					atchFileVO.setFileExtsn(fileExtension);
					atchFileVO.setOrignlFileNm(originalFileName);
					atchFileVO.setFileStrePath(saveFilePath);
					
					// 파일 상세정보 저장
					fileDao.insertAtchFileDetail(atchFileVO);

					item.delete(); // 임시 업로드 파일 삭제하기
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return atchFileVO;
	}



}
