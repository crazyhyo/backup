package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.member.vo.MemberDTO;
import kr.or.ddit.member.vo.PagingVO;
import kr.or.ddit.util.Criteria;
import kr.or.ddit.util.SearchCriteria;
import kr.or.ddit.util.SqlMapClientFactory;

public class MemberDaoImpl implements IMemberDao{

	private String nameSpace = "Member-Mapper.";
	private static IMemberDao memberDao;
	
	private MemberDaoImpl() {}
	
	public static IMemberDao getInstance() {
		if(memberDao == null) {
			System.out.println("최초 dao객체 생성 및 반환");
			memberDao = new MemberDaoImpl();
			return memberDao;
		}else {
			System.out.println("기존 dao객체 반환");
			return memberDao;
		}
	}

	@Override
	public MemberDTO getMember(String id, SqlSession session) throws Exception {
		return session.selectOne(nameSpace + "getMember", id);
	}

	@Override
	public int registerMember(MemberDTO memberDTO, SqlSession session) throws Exception {
		return session.insert(nameSpace + "registerMember", memberDTO);
	}

	@Override
	public int updateMember(MemberDTO memberDTO, SqlSession session) throws Exception {
		return session.update(nameSpace + "updateMember", memberDTO);
	}

	@Override
	public int deleteMember(String id, SqlSession session) throws Exception {
		return session.delete(nameSpace + "deleteMember", id);
	}

	@Override
	public int idCheck(String id, SqlSession session) throws Exception {
		return session.selectOne(nameSpace + "idCheck", id);
	}

	@Override
	public List<MemberDTO> searchMemberList(PagingVO pagingVO, SqlSession session) throws Exception {
		return session.selectList(nameSpace + "searchMemberList", pagingVO);
	}

	@Override
	public int getSearchCount(PagingVO pagingVO, SqlSession session) throws Exception {
		return session.selectOne(nameSpace + "getSearchCount", pagingVO);
	}

	@Override
	public int getMemberListCount(SqlSession session, SearchCriteria cri) throws Exception {
		int listCount = session.selectOne(nameSpace + "getMemberListCount", cri);
		return listCount;
	}

	@Override
	public List<MemberDTO> getMemberListPage(SqlSession session, SearchCriteria cri) throws Exception {
		
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<MemberDTO> memberList = session.selectList(nameSpace + "getMemberListPage", cri, rowBounds);
		return memberList;
	}

	
}
