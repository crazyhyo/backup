package kr.or.ddit.jdbcBoard.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.jdbcBoard.util.SqlMapClientFactory;
import kr.or.ddit.jdbcBoard.vo.JdbcBoardVO;

public class JdbcBoardDaoImpl implements IJdbcBoardDao{

	private SqlMapClient smc;
	
	private static IJdbcBoardDao jdbcBoardDao;
	
	private String namespace = "jdbcBoard.";
	
	private JdbcBoardDaoImpl() {
		smc = SqlMapClientFactory.getInstance();
	}
	
	public static IJdbcBoardDao getInstance() {
		if(jdbcBoardDao == null) {
			jdbcBoardDao = new JdbcBoardDaoImpl();
		}
		
		return jdbcBoardDao;
	}
	
//	@Override
//	public int insertBoard(JdbcBoardVO boardVO) {
//		int cnt = 0;
//		
//		try {
//			Object obj = smc.insert(namespace + "insertBoard", boardVO);
//			
//			cnt = obj == null ? 1 : 0;  
//		} catch (SQLException ex) {
//			ex.printStackTrace();
//		}
//		return cnt;
//	}

	@Override
	public boolean chkBoard(int board_no) {
		boolean flag = false;
    int cnt = 0;
		
		try {
			cnt = (int)smc.queryForObject(namespace + "chkBoard", board_no);
      flag = cnt != 0;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return flag;
	}

	@Override
	public JdbcBoardVO selectBoard(int board_no) {
    
    JdbcBoardVO board = null;

    try{
      board = (JdbcBoardVO) smc.queryForObject(namespace + "selectBoard", board_no);

    } catch (SQLException ex) {
      ex.printStackTrace();
    }
		return board;
	}

	@Override
	public List<JdbcBoardVO> selectAllBoard() {
    
    List<JdbcBoardVO> boardList = null;

    try{

      boardList = (List<JdbcBoardVO>) smc.queryForList(namespace + "selectAllBoard");

    } catch (SQLException ex) {
      ex.printStackTrace();
    }
		return boardList;
	}

//	@Override
//	public int updateBoard(JdbcBoardVO boardVO) {
//
//    int cnt = 0;
//
//    try{
//
//      cnt = smc.update(namespace + "updateBoard", boardVO);
//
//    } catch (SQLException ex) {
//      ex.printStackTrace();
//    }
//		return cnt;
//	}

	@Override
	public int deleteBoard(int board_no) {

    int cnt = 0;

    try{

      cnt = smc.delete(namespace + "deleteBoard", board_no);

    } catch (SQLException ex) {
      ex.printStackTrace();
    }
		return cnt;
	}

	@Override
	public List<JdbcBoardVO> searchBoard(JdbcBoardVO boardVO) {

    List<JdbcBoardVO> boardList = null;

    try{

      boardList = (List<JdbcBoardVO>) smc.queryForList(namespace + "selectBoard", boardVO);

    } catch (SQLException ex) {
      ex.printStackTrace();
    }
		return boardList;
	}

}
