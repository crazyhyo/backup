package com.jsp.action.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.josephoconnell.html.HTMLInputFilter;
import com.jsp.action.Action;
import com.jsp.controller.HttpRequestParameterAdapter;
import com.jsp.controller.XSSHttpRequestParameterAdapter;
import com.jsp.dto.NoticeVO;
import com.jsp.service.NoticeService;

public class NoticeRegistAction implements Action{

	private NoticeService noticeService;
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "/notice/regist_success";
		
		try {
			// XSSResolver.parseXSS(request);
			
			NoticeVO notice = (NoticeVO)XSSHttpRequestParameterAdapter.execute(request, NoticeVO.class, true);
			
			//notice.setTitle(HTMLInputFilter.htmlSpecialChars(notice.getTitle()));
			
			System.out.println(notice.getContent() + "11111111111111");
			
			notice.setContent(request.getParameter("content"));
			
			System.out.println(notice.getContent() + "222222222222222");
			
			noticeService.regist(notice);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
			//	url = "/notice/regist_fail";  이 방법은 동기방식에서만 사용하자!!!!!!!!!!!!!!!!!!! 비동기에선 절대 사용하지 말것
		}
		
		return url;
	}

}
