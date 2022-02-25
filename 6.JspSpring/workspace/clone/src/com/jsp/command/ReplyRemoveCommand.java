package com.jsp.command;

public class ReplyRemoveCommand {

	private String rno;
	private String bno;
	private String page;
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}	
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	
/*	public ReplyVO toReplyVO() {
		
		ReplyVO reply = new ReplyVO();
		reply.setBno(Integer.parseInt(this.bno));
		reply.setRno(Integer.parseInt(this.rno));
		
		return reply;
	}
	
	public SearchCriteria toSearchCriteria() {
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(Integer.parseInt(this.page));
		
		return cri;
	}
*/

	public Integer getBnoInt() {
		return Integer.parseInt(this.bno);
	}
	public Integer getPageInt() {
		return Integer.parseInt(this.page);
	}
	public Integer getRnoInt() {
		return Integer.parseInt(this.rno);
	}
}
