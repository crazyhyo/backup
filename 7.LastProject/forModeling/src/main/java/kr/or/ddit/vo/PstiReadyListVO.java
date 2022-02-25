package kr.or.ddit.vo;

import java.util.Date;

public class PstiReadyListVO {
	public String getManageInnb() {
		return manageInnb;
	}
	public void setManageInnb(String manageInnb) {
		this.manageInnb = manageInnb;
	}
	public String getPstiInnb() {
		return pstiInnb;
	}
	public void setPstiInnb(String pstiInnb) {
		this.pstiInnb = pstiInnb;
	}
	public String getSttusCode() {
		return sttusCode;
	}
	public void setSttusCode(String sttusCode) {
		this.sttusCode = sttusCode;
	}
	public String getPstiNm() {
		return pstiNm;
	}
	public void setPstiNm(String pstiNm) {
		this.pstiNm = pstiNm;
	}
	public Date getWrtYmd() {
		return wrtYmd;
	}
	public void setWrtYmd(Date wrtYmd) {
		this.wrtYmd = wrtYmd;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	private String pstiInnb = "PSTI";
	private String sttusCode = "";
	private String manageInnb = "";
	private String pstiNm = "";
	private Date wrtYmd = new Date();
	private int age = 0;
	private Date birthDate = new Date();
	private String telNo = "";
}
