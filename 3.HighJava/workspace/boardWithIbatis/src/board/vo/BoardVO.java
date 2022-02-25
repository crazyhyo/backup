package board.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardVO {
	private String boardNo;
	private String boardTitle;
	private String boardWriter;
	private Date boardDate;
	private SimpleDateFormat sdf;
	private String boardContent;

	public BoardVO() {
		this.boardDate = new Date();
		this.sdf = new SimpleDateFormat("yyyy-MM-dd");
	}
	public BoardVO(
			String boardNo, String boardTitle, String boardWriter
			, Date boardDate, String boardContent) 
	{
		super();
		this.boardDate = new Date();
		this.sdf = new SimpleDateFormat("yyyy-MM-dd");
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardWriter = boardWriter;
		this.boardDate = boardDate;
		this.boardContent = boardContent;
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
	public void printBoardDetail() {
		System.out.printf("%4d|%30s|%15s|", boardNo, boardTitle, boardWriter);
		System.out.println(sdf.format(boardDate));
		System.out.println("-----------------------------------------------------------------");
		System.out.println(boardContent);
		System.out.println("-----------------------------------------------------------------");
	}
	@Override
	public String toString() {
		return boardNo+"|"+boardTitle+"|"+boardWriter+"|"+boardDate+"|"+boardContent+"|";
	}
}
