package kr.or.ddit.service.spring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jsp.command.Criteria;
import com.jsp.command.PageMaker;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.MemberVO;
import com.jsp.exception.InvalidPasswordException;
import com.jsp.exception.NotFoundIDException;
import com.jsp.service.MemberServiceForModify;

import kr.or.ddit.dao.spring.MemberDAOBean;

public class MemberServiceImpl implements MemberServiceForModify{
	
	private MemberDAOBean memberDAOBean;
	public void setMemberDAOBean(MemberDAOBean memberDAOBean) {
		this.memberDAOBean = memberDAOBean;
	}
	
	@Override
	public MemberVO getMember(String id) throws Exception {
		return memberDAOBean.selectMemberById(id);
	}
	@Override
	public List<MemberVO> getMemberList() throws Exception {
		return memberDAOBean.selectMemberList();
	}
	@Override
	public List<MemberVO> getMemberList(Criteria cri) throws Exception {
		return memberDAOBean.selectMemberList(cri);
	}
	@Override
	public Map<String, Object> getMemberListPage(Criteria cri) throws Exception {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<MemberVO> memberList = memberDAOBean.selectMemberList(cri);
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(memberDAOBean.selectMemberListCount((SearchCriteria)cri));
		
		dataMap.put("memberList", memberList);
		dataMap.put("pageMaker", pageMaker);
		return dataMap;
	}
	@Override
	public void regist(MemberVO member) throws Exception {
		memberDAOBean.insertMember(member);
	}
	@Override
	public void enabled(String id, int enabled) throws Exception {
		memberDAOBean.enabledMember(id, enabled);
	}
	@Override
	public void login(String id, String pwd) throws NotFoundIDException, InvalidPasswordException, Exception {
		
		MemberVO member = memberDAOBean.selectMemberById(id);
		if(member == null)	throw new NotFoundIDException();
		if(!member.getPwd().equals(pwd)) throw new InvalidPasswordException();
		
	}
	@Override
	public void modify(MemberVO member) throws Exception {
		memberDAOBean.updateMember(member);
	}
	@Override
	public void remove(String id) throws Exception {
		memberDAOBean.deleteMember(id);
	}

}
