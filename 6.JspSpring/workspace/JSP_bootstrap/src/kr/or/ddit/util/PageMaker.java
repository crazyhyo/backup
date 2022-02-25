package kr.or.ddit.util;

public class PageMaker {

	private int totalCount;
	private int startPage = 1;
	private int endPage = 1;
	private int realEndPage;
	
	private int displayPageNum = 10;
	
	private boolean prev;
	private boolean next;
	
	Criteria cri = new Criteria();
	
	private void setData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		realEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		if(startPage <= 0) {
			startPage = 1;
		}
		if(endPage > realEndPage) {
			endPage = realEndPage;
		}
		if(endPage <= 1) {
			endPage = 1;
		}
		prev = startPage == 1 ? false : true;
		next = endPage >= realEndPage ? false : true;
	}
	
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		setData();
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getRealEndPage() {
		return realEndPage;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}
	
}
