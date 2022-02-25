package kr.or.ddit.assn;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class BoardVO {
	private String boardNo;
	private String boardTitle;
	private String boardWriter;
	private Date boardDate;
	private SimpleDateFormat sdf;
	private String boardContent;

	public BoardVO() {}
	public BoardVO(Map<String, Object> board) {
		super();
		this.boardNo = (String) board.get("BOARD_NO");
		this.boardTitle = (String) board.get("BOARD_TITLE");
		this.boardWriter = (String) board.get("BOARD_WRITER");
		this.boardDate = (Date) board.get("BOARD_DATE");
		this.boardContent = (String) board.get("BOARD_CONTENT");
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardNo() {
		return boardNo;
	}
	
	public void printBoard() {
		System.out.printf("%4s|%30s|%15s|", boardNo, boardTitle, boardWriter);
		System.out.println(sdf.format(boardDate));
		System.out.println("-----------------------------------------------------------------");
	}
}
