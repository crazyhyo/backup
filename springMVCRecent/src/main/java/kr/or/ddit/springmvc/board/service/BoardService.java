package kr.or.ddit.springmvc.board.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.springmvc.board.dao.AttachFileMapper;
import kr.or.ddit.springmvc.board.dao.BoardMapper;
import kr.or.ddit.springmvc.board.vo.AttachFileVO;
import kr.or.ddit.springmvc.board.vo.BoardVO;

@Service("boardService")
public class BoardService {
	private static final Logger LOGGER = LoggerFactory.getLogger(BoardService.class);
	
	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;
	
	@Resource(name="attachFileMapper")
	private AttachFileMapper attachFileMapper;

	// 등록
	public void create(BoardVO vo) throws Exception {
		boardMapper.create(vo);
		
		processFileUpload(vo);
	}	

	/* 수정 */
	public int update(BoardVO vo) throws Exception {
		int cnt = boardMapper.update(vo);
		processFileUpload(vo);
		return cnt;
	}

	public int delete(BoardVO vo) throws Exception {
		return boardMapper.delete(vo);
	}

	public BoardVO retrieve(BoardVO vo) throws Exception {
		BoardVO retrieveBoardVO = boardMapper.retrieve(vo);
		if(retrieveBoardVO != null){
			retrieveBoardVO.setAttachFileVOList(
					attachFileMapper.retrieveList(retrieveBoardVO));
		}
		return retrieveBoardVO;
	}

	public List<BoardVO> retrieveList(BoardVO vo) throws Exception {
		return boardMapper.retrieveList(vo);
	}

	public List<BoardVO> retrievePagingList(BoardVO vo) throws Exception {
		return boardMapper.retrievePagingList(vo);
	}

	public int retrievePagingListCnt(BoardVO vo) throws Exception {
		return boardMapper.retrievePagingListCnt(vo);
	}
	
	private void processFileUpload(BoardVO vo) throws IOException, FileNotFoundException, Exception {
		MultipartFile file = vo.getFile();
		if(file != null){
			String path=AttachFileVO.UPLOAD_ROOT_PATH;
			
			String fileSaveName = UUID.randomUUID().toString();
			String fileSrcName = file.getOriginalFilename();
			
			LOGGER.debug("fileSaveName : "+fileSaveName);
			LOGGER.debug("fileSrcName : "+fileSrcName);
			
			File filePath = new File(path);
			if(!filePath.exists()){
				filePath.mkdirs();
			}
			
			File tempFile = new File(path+fileSaveName);
			IOUtils.write(file.getBytes(), new FileOutputStream(tempFile));
			
			AttachFileVO attachFileVO = new AttachFileVO();
			attachFileVO.setBoardSn(vo.getBoardSn());
			attachFileVO.setFilePath(path);
			attachFileVO.setFileSaveName(fileSaveName);
			attachFileVO.setFileSrcName(fileSrcName);
			
			attachFileMapper.create(attachFileVO);
		}
	}
}
