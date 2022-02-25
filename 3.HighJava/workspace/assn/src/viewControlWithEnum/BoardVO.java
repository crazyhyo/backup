package viewControlWithEnum;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class BoardVO {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private Date boardDate;
	private SimpleDateFormat sdf;
	private String boardContent;

	public BoardVO() {}
	public BoardVO(Map<String, Object> board) {
		super();
		this.boardNo = (int) board.get("BOARD_NO");
		this.boardTitle = (String) board.get("BOARD_TITLE");
		this.boardWriter = (String) board.get("BOARD_WRITER");
		this.boardDate = (Date) board.get("BOARD_DATE");
		this.boardContent = (String) board.get("CONTENT");
		this.sdf = new SimpleDateFormat("yyyy-MM-dd");
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
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	
	public void printBoard() {
		System.out.printf("%4d|%30s|%15s|", boardNo, boardTitle, boardWriter);
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
