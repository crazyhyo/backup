package kr.or.ddit.util;

public class SearchCriteria extends Criteria{
	
	private String searchKey;
	private String searchWord;
	
	public SearchCriteria() {}
	
	public SearchCriteria(int page, int perPageNum, String searchKey, String searchWord) {
		super(page, perPageNum);
		this.searchKey = searchKey;
		this.searchWord = searchWord;
	}
	
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
