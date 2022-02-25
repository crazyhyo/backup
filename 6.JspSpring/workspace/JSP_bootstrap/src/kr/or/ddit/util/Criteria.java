package kr.or.ddit.util;

import kr.or.ddit.exception.NotANumberException;

public class Criteria {

	private int page = 1;
	private int perPageNum = 10;
	
	private int startRowNum = 0;

	public Criteria () {}
	public Criteria (int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
		calcStartRowNum();
	}
	public Criteria (String page, String perPageNum) throws NotANumberException{
		
		try {
			this.page = Integer.parseInt(page);
			this.perPageNum = Integer.parseInt(perPageNum);
			calcStartRowNum();
		}catch(NumberFormatException e) {
			throw new NotANumberException();
		}
		
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
		}else {
			this.page = page;
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public int getStartRowNum() {
		return startRowNum;
	}
	
	private void calcStartRowNum() {
		this.startRowNum = (page - 1) * perPageNum;
	}
}
