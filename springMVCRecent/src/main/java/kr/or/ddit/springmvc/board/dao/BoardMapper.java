package kr.or.ddit.springmvc.board.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.springmvc.board.vo.BoardVO;

@Mapper("boardMapper")
public interface BoardMapper {
	//등록
	void create(BoardVO vo) throws Exception;
	/* 수정 */
	int update(BoardVO vo) throws Exception;
	
	int delete(BoardVO vo) throws Exception;
	
	BoardVO retrieve(BoardVO vo) throws Exception;
	/**
	 * 목록 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<BoardVO> retrieveList(BoardVO vo) throws Exception;
	
	List<BoardVO> retrievePagingList(BoardVO vo) throws Exception;
	
	int retrievePagingListCnt(BoardVO vo) throws Exception;
}
