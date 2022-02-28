package kr.or.ddit.springmvc.board.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.SampleDefaultVO;

public class BoardVO extends SampleDefaultVO {

	private String userPassword;
	private String writer;
	private String title;
	private String openYn;
	private String boardSn;
	private String contents;
	
	private String sequenceNo;

	// 첨부파일 추가
	private MultipartFile file;

	private List<AttachFileVO> attachFileVOList = new ArrayList<AttachFileVO>();
	

	public String getSequenceNo() {
		return sequenceNo;
	}

	public void setSequenceNo(String sequenceNo) {
		this.sequenceNo = sequenceNo;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public List<AttachFileVO> getAttachFileVOList() {
		return attachFileVOList;
	}

	public void setAttachFileVOList(List<AttachFileVO> attachFileVOList) {
		this.attachFileVOList = attachFileVOList;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWriter() {
		return writer;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}

	public String getOpenYn() {
		return openYn;
	}

	public String getOpenYnNm() {
		if (this.openYn != null) {
			if ("Y".equals(this.openYn)) {
				return "공개";
			} else {
				return "비공개";
			}
		}
		return "-";
	}

	public void setBoardSn(String boardSn) {
		this.boardSn = boardSn;
	}

	public String getBoardSn() {
		return boardSn;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getContents() {
		return contents;
	}
}
