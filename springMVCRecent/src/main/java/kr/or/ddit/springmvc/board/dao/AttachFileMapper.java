package kr.or.ddit.springmvc.board.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.springmvc.board.vo.AttachFileVO;
import kr.or.ddit.springmvc.board.vo.BoardVO;

@Mapper("attachFileMapper")
public interface AttachFileMapper {
	void create(AttachFileVO attachFileVO) throws Exception;
	
	List<AttachFileVO> retrieveList(BoardVO boardVO) throws Exception;
	
	AttachFileVO retrieve(AttachFileVO attachFileVO) throws Exception;
}
