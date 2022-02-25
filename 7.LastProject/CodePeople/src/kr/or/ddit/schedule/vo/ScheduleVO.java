package kr.or.ddit.schedule.vo;

public class ScheduleVO {
	private Integer calTag;
	private String calTagColor;
	private String scheSdate;
	private String scheEdate;
	private String scheCont;
	private Integer scheNo;
	public Integer getCalTag() {
		return calTag;
	}
	public void setCalTag(Integer calTag) {
		this.calTag = calTag;
	}
	public String getCalTagColor() {
		return calTagColor;
	}
	public void setCalTagColor(String calTagColor) {
		this.calTagColor = calTagColor;
	}
	public String getScheSdate() {
		return scheSdate;
	}
	public void setScheSdate(String scheSdate) {
		this.scheSdate = scheSdate;
	}
	public String getScheEdate() {
		return scheEdate;
	}
	public void setScheEdate(String scheEdate) {
		this.scheEdate = scheEdate;
	}
	public String getScheCont() {
		return scheCont;
	}
	public void setScheCont(String scheCont) {
		this.scheCont = scheCont;
	}
	public Integer getScheNo() {
		return scheNo;
	}
	public void setScheNo(Integer scheNo) {
		this.scheNo = scheNo;
	}
}
