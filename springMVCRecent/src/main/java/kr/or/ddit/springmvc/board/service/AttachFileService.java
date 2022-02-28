package kr.or.ddit.springmvc.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.springmvc.board.dao.AttachFileMapper;
import kr.or.ddit.springmvc.board.vo.AttachFileVO;
import kr.or.ddit.springmvc.board.vo.BoardVO;

@Service("attachFileService")
public class AttachFileService {
	@Resource(name="attachFileMapper")
	private AttachFileMapper attachFileMapper;
	
	public void create(AttachFileVO attachFileVO) throws Exception{
		attachFileMapper.create(attachFileVO);
	}
	
	public List<AttachFileVO> retrieveList(BoardVO boardVO) throws Exception{
		return attachFileMapper.retrieveList(boardVO);
	}
	
	public AttachFileVO retrieve(AttachFileVO attachFileVO) throws Exception{
		return attachFileMapper.retrieve(attachFileVO);
	}
}
