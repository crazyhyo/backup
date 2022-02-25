package kr.or.ddit.jdbcBoard.service;

import java.util.List;

import kr.or.ddit.jdbcBoard.dao.IJdbcBoardDao;
import kr.or.ddit.jdbcBoard.dao.JdbcBoardDaoImpl;
import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

public class JdbcBoardServiceImpl implements IJdbcBoardService{

  private IJdbcBoardDao jdbcBoardDao;

  private static IJdbcBoardService jdbcBoardService;

  private JdbcBoardServiceImpl(){
    jdbcBoardDao = JdbcBoardDaoImpl.getInstance();
  }

  public static IJdbcBoardService getInstance(){
    if(jdbcBoardService == null){
      jdbcBoardService = new JdbcBoardServiceImpl();
    }
    return jdbcBoardService;
  }

//	@Override
//	public int insertBoard(JdbcBoardVO boardVO) {
//		return jdbcBoardDao.insertBoard(boardVO);
//	}

	@Override
	public boolean chkBoard(int board_no) {
		return jdbcBoardDao.chkBoard(board_no);
	}

	@Override
	public JdbcBoardVO selectBoard(int board_no) {
		return jdbcBoardDao.selectBoard(board_no);
	}

	@Override
	public List<JdbcBoardVO> selectAllBoard() {
		return jdbcBoardDao.selectAllBoard();
	}

//	@Override
//	public int updateBoard(JdbcBoardVO boardVO) {
//		return jdbcBoardDao.updateBoard(boardVO);
//	}

	@Override
	public int deleteBoard(int board_no) {
		return jdbcBoardDao.deleteBoard(board_no);
	}

	@Override
	public List<JdbcBoardVO> searchBoard(JdbcBoardVO boardVO) {
		return jdbcBoardDao.searchBoard(boardVO);
	}

}
