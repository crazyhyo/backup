package com.jsp.action.reply;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.action.Action;
import com.jsp.command.CriteriaCommand;
import com.jsp.command.PageMaker;
import com.jsp.command.ReplyRemoveCommand;
import com.jsp.command.SearchCriteria;
import com.jsp.controller.HttpRequestParameterAdapter;
import com.jsp.dto.ReplyVO;
import com.jsp.service.ReplyService;

public class ReplyRemoveAction implements Action{

	private ReplyService replyService;
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = null;
		
		
		try {
		ReplyRemoveCommand removeCMD = (ReplyRemoveCommand)HttpRequestParameterAdapter.execute(request, ReplyRemoveCommand.class);
		
		replyService.removeReply(removeCMD.getRnoInt());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(new SearchCriteria());
		pageMaker.setTotalCount(replyService.getReplyListCount(removeCMD.getBnoInt()));
		
//		int page = Math.min(pageMaker.getRealEndPage(), removeCMD.getPageInt());
		int realEndPage = pageMaker.getRealEndPage();
		int page = removeCMD.getPageInt();
		if(page > realEndPage) {
			page = realEndPage;
		}
		PrintWriter out = response.getWriter();
		
		out.print(page);
		out.close();
		} catch(Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			url = null;
		}
		
/*		
		try {
			
			ReplyRemoveCommand replyCMD = (ReplyRemoveCommand)HttpRequestParameterAdapter.execute(request, ReplyRemoveCommand.class);
			
			ReplyVO reply = replyCMD.toReplyVO();
			SearchCriteria cri = replyCMD.toSearchCriteria();
			
//			System.out.println("input page : " + cri.getPage());
			
			replyService.removeReply(reply.getRno());
			
			PageMaker pageMaker = new PageMaker();
			
//			cri.setPage(2);
//			cri.setPerPageNum(14);
//			
//			System.out.println(cri);
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(replyService.getReplyListCount(reply.getBno()));
			
//			System.out.println("total reply count in this board : " + replyService.getReplyListCount(reply.getBno()));
//			
//			System.out.println(pageMaker);
			
			PrintWriter out = response.getWriter();
			
			int returnPage = cri.getPage();
			
			returnPage = returnPage > pageMaker.getRealEndPage() ? pageMaker.getRealEndPage() : returnPage;
			
//			System.out.println("calculated returnPage is : " + returnPage);
			
			out.print(returnPage);
			
		} catch(Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
*/		
		return url;
	}

	
	
}
