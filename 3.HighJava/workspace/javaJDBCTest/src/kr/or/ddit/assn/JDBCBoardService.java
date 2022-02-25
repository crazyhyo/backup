package kr.or.ddit.assn;

import java.util.ArrayList;
import java.util.List;

public class JDBCBoardService {
	
	private JDBCBoardService() {
		boardVO = new BoardVO();
		boardList = new ArrayList<BoardVO>();
	}
	
	public BoardVO boardVO;
	
	public List<BoardVO> boardList;
	
	public String getBoardNo() { return boardVO.getBoardNo(); }
}
