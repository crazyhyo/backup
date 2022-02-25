package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.cmm.vo.PagingVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.SqlMapClientFactory;

public class MemberDaoImp1 implements IMemberDao{
	
    private static IMemberDao memDao;
    private static SqlMapClient smc;
    private MemberDaoImp1() {
    	smc = SqlMapClientFactory.getInstance();
    }
    public static IMemberDao getInstance(){
        if(memDao == null){
            memDao = new MemberDaoImp1();
        }
        return memDao;
    }
    
  @Override
  public MemberVO getMember(String memId){
    MemberVO mv = null;
        try{
          mv = (MemberVO) smc.queryForObject("member.selectMember", memId);
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return mv;

  }
	@Override
	public int insertMember(MemberVO mv) {
        int cnt = 0;
        
        try{
            cnt = smc.update("member.insertMember", mv);
        }catch(SQLException e){
            e.printStackTrace();
        }
        
		return cnt;
	}

	@Override
	public boolean chkMember(String memId) {
		boolean chk = false;
    
        try{
               int cnt = (int)smc.queryForObject("member.chkMember", memId); 
               if(cnt > 0) {
            	   chk = true;
               }
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return chk;
	}

	@Override
	public List<MemberVO> getAllMemberList(PagingVO pagingVO) {
		
		List<MemberVO> memList = new ArrayList<MemberVO>();
		
		try{

            memList = (List<MemberVO>) smc.queryForList("member.selectAllMember", pagingVO);

        }catch(SQLException ex){
            ex.printStackTrace();
        }
		return memList;
	}
	
	@Override
	public int getTotalCnt() {
		int cnt = 0;
		try {
			cnt = (int)smc.queryForObject("member.selectTotalCnt");
		} catch(SQLException ex) {
			ex.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateMember(MemberVO mv) {
		int cnt = 0;
		try{
            cnt = smc.update("member.updateMember", mv);

        }catch(SQLException ex){
            ex.printStackTrace();
        }
		
		return cnt;
	}

	@Override
	public int deleteMember(String memId) {
		int cnt = 0;
		try{

            cnt = smc.delete("member.deleteMember", memId);

        }catch(SQLException ex){
            ex.printStackTrace();
        }
		return cnt;
	}

    @Override
    public List<MemberVO> getSearchMember(MemberVO mv) {

        List<MemberVO> memList = new ArrayList<>();

        try{
            memList = (List<MemberVO>) smc.queryForList("member.searchMember", mv);
        }catch(SQLException ex){
            ex.printStackTrace();
        }

        return memList;

    }

}
