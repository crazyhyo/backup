package kr.or.ddit.service.spring;

import java.sql.SQLException;

import com.jsp.dto.MemberVO;

import kr.or.ddit.dao.spring.ScheduledMemberDAOBean;

public class ScheduledMemberServiceForModifyImpl extends MemberServiceImpl implements ScheduledMemberServiceforModify{

	private ScheduledMemberDAOBean scheduledMemberDAO;
	public void setScheduledMemberDAOBean(ScheduledMemberDAOBean scheduledMemberDAO) {
		this.scheduledMemberDAO = scheduledMemberDAO;
	}

	@Override
	public MemberVO getMemberByPicture(String picture) throws SQLException {
		MemberVO member = null;
		member = scheduledMemberDAO.selectMemberByPicture(picture);
		return member;
	}

}
