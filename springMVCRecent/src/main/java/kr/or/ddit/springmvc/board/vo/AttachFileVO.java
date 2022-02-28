package kr.or.ddit.springmvc.board.vo;

public class AttachFileVO extends BoardVO{
	public static final String UPLOAD_ROOT_PATH = "c:/springmvc/upload/";
	
	private String sequenceNo;
	private String filePath;
	private String fileSaveName;
	private String fileSrcName;
	
	public String getSequenceNo() {
		return sequenceNo;
	}
	public void setSequenceNo(String sequenceNo) {
		this.sequenceNo = sequenceNo;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileSaveName() {
		return fileSaveName;
	}
	public void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
	}
	public String getFileSrcName() {
		return fileSrcName;
	}
	public void setFileSrcName(String fileSrcName) {
		this.fileSrcName = fileSrcName;
	}
	
	
}
