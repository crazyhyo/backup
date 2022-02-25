package com.jsp.command;

import java.util.Date;

import com.jsp.dto.BoardVO;

public class BoardModifyCommand {
	
	private String bno;
	private String title;
	private String content;
	private String writer;
	
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public BoardVO toBoardVO() {
		
		BoardVO board = new BoardVO();
		
		board.setBno(Integer.parseInt(this.bno));
		board.setContent(this.content);
		board.setTitle(this.title);
		board.setWriter(this.writer);
		board.setUpdatedate(new Date());
		
		return board;
	}
}
