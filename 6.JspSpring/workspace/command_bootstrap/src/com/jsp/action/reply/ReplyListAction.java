package com.jsp.action.reply;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.action.Action;
import com.jsp.command.CriteriaCommand;
import com.jsp.command.SearchCriteria;
import com.jsp.controller.JSONResolver;
import com.jsp.controller.XSSHttpRequestParameterAdapter;
import com.jsp.service.ReplyService;

public class ReplyListAction implements Action{
	
	private ReplyService replyService;
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = null;
		
		try {
			CriteriaCommand criCMD = (CriteriaCommand)XSSHttpRequestParameterAdapter
					.execute(request, CriteriaCommand.class, true);
			SearchCriteria cri = criCMD.toSearchCriteria();
			
			int bno = Integer.parseInt(request.getParameter("bno"));
			Map<String, Object> dataMap = replyService.getReplyList(bno, cri);
			
			JSONResolver.view(response, dataMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
		}
		return url;
	}

	

}
