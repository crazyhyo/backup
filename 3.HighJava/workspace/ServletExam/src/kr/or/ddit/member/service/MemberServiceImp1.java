package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.cmm.vo.PagingVO;
import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImp1;
import kr.or.ddit.member.vo.MemberVO;

public class MemberServiceImp1 implements IMemberService{

	private IMemberDao memDao;
    private static IMemberService memService;
    
    private MemberServiceImp1() {
        memDao = MemberDaoImp1.getInstance();
    }
    public static IMemberService getInstance(){
        if(memService == null){
            memService = new MemberServiceImp1();
        }
        return memService;
    }
    // 사용할 DAO의 객체변수를 선언한다.

	@Override
	public int registerMember(MemberVO mv) {
        
        int cnt = memDao.insertMember(mv);

        // 회원등록 관련 로그 남김

        // 관리자에게 메일 발송..

		return cnt;
	}

	@Override
	public boolean chkMember(String memId) {
		
		return memDao.chkMember(memId);
	}

  @Override
  public MemberVO getMember(String memId){
    return memDao.getMember(memId);
  }

	@Override
	public List<MemberVO> getAllMemberList(PagingVO pagingVO) {
		return memDao.getAllMemberList(pagingVO);
	}
	
	@Override
	public int getTotalCnt() {
		return memDao.getTotalCnt();
	}

	@Override
	public int updateMember(MemberVO mv) {
		return memDao.updateMember(mv);
	}

	@Override
	public int deleteMember(String memId) {
		return memDao.deleteMember(memId);
	}
	@Override
	public List<MemberVO> getSearchMember(MemberVO mv) {
		return memDao.getSearchMember(mv);
	}

}
