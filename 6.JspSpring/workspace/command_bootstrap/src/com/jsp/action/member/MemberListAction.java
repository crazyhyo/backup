package com.jsp.action.member;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.action.Action;
import com.jsp.command.Criteria;
import com.jsp.command.SearchCriteria;
import com.jsp.exception.NotNumberException;
import com.jsp.service.MemberService;

public class MemberListAction implements Action {

	private MemberService memberService;
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String url = "/member/list";
		
		String pageParam = request.getParameter("page");
		String perPageNumParam = request.getParameter("perPageNum");
		String searchTypeParam = request.getParameter("searchType");
		String keywordParam = request.getParameter("keyword");
		
		try {
			
			Criteria cri=null; 
			if(pageParam !=null && perPageNumParam !=null) {
				cri = new SearchCriteria(pageParam,perPageNumParam,searchTypeParam,keywordParam);				
			}else {
				cri= new SearchCriteria();
			}
			
/*			List<MemberVO> memberList = //memberService.getMemberList();
										//memberService.getMemberList(cri);			
			request.setAttribute("memberList", memberList);*/
			
			Map<String,Object> dataMap = memberService.getMemberListPage(cri);
			request.setAttribute("dataMap", dataMap);
			
//			if(true) throw new IOException();
			
		}catch(NotNumberException e) {	// 생각해보니 내 잘못이 아니네, sendError bad request로 보내자(가장 좋은 방법)
			request.setAttribute("exception", e);
			url="/error/message";
		}catch(Exception e) {
			e.printStackTrace();
//			url = "/error/500";		절대 이 방법을 사용하지 마라. 200번 응답코드로 500에러페이지 보내는 건 속이는 것
			// throw e를 하는 순간 무조건 내가 잘못한 거임
			// 
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
		
		return url;
	}

}
