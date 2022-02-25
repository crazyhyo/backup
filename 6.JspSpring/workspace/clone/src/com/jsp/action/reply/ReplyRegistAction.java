package com.jsp.action.reply;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.josephoconnell.html.HTMLInputFilter;
import com.jsp.action.Action;
import com.jsp.command.PageMaker;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.ReplyVO;
import com.jsp.service.ReplyService;

public class ReplyRegistAction implements Action{
	
	private ReplyService replyService;
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = null;
		
		
		ObjectMapper mapper = new ObjectMapper();
		ReplyVO reply = mapper.readValue(request.getReader(), ReplyVO.class);
		
		reply.setReplytext(HTMLInputFilter.htmlSpecialChars(reply.getReplytext()));
		
		int realEndPage = 1;
		
		try {
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(new SearchCriteria());
			pageMaker.setTotalCount(replyService.getReplyListCount(reply.getBno()));
			
			realEndPage = pageMaker.getRealEndPage();
			
			replyService.registReply(reply);
			
			PrintWriter out = response.getWriter();
			
			out.print(realEndPage);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
		}
		
		/*try {
			ObjectMapper mapper = new ObjectMapper();
			ReplyRegistCommand replyCMD = mapper.readValue(request.getReader(), ReplyRegistCommand.class);
			
			ReplyVO reply = replyCMD.toReplyVO();
			
			String replytext = reply.getReplytext();
			reply.setReplytext(HTMLInputFilter.htmlSpecialChars(replytext));
			
			replyService.registReply(reply);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
		}*/
		return url;
	}


}
