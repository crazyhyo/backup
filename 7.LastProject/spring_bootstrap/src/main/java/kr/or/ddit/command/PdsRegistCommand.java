package kr.or.ddit.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.jsp.dto.PdsVO;

public class PdsRegistCommand {

	
	// JSP단에서 enc-type이  <<multipart-formdata>>인 경우는 spring에서 단수든 복수든
	// 해당 변수를 List타입으로 받을 수 있다.
	// title로 여러개가 와도 List<String>으로, 하나가 와도 List<String>으로 받을 수 있다는 얘기임
	// 그렇지 않은 경우는 배열로 받을 수 있다.
	
	private String title;
	private String content;
	private String writer;
	private List<MultipartFile> uploadFile;
	
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
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}

	public PdsVO toPdsVO() {
		PdsVO pds = new PdsVO();
		pds.setTitle(this.title);
		pds.setContent(this.content);
		pds.setWriter(this.writer);
		
		return pds;
	}
}
