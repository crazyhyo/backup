package com.jsp.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.jsp.exception.NotDateException;
import com.jsp.exception.NotNumberException;

public class MemberVO {
	private String id; // 아이디
	private String pwd; // 패스워드
	private String name = "---"; // 이름
	private String phone; // 전화번호
	private String email; //이메일
	private String picture; //사진파일 경로/파일명
	private Date regDate;
	private String authority;
	private int enabled;
	private String register;
	private String address;
	public MemberVO() {}
	
	public MemberVO(String id, String pwd) {
		super();
		this.id = id;
		this.pwd = pwd;
	}
	
	
	
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", picture=" + picture + ", regDate=" + regDate + ", authority=" + authority + ", enabled=" + enabled
				+ ", register=" + register + ", address=" + address + "]";
	}

	public MemberVO(HttpServletRequest request) throws NotNumberException, NotDateException{
		this.id 		= request.getParameter("id");
		this.pwd 		= request.getParameter("pwd");
		this.name 		= request.getParameter("name");
		this.email 		= request.getParameter("email")		== null ? ""			: request.getParameter("email");
		this.picture 	= request.getParameter("picture") 	== null ? "noImage.jpg" : request.getParameter("picture");
		this.authority 	= request.getParameter("authority") == null ? "ROLE_USER" 	: request.getParameter("authority");
		this.register 	= request.getParameter("register") 	== null ? "mimi" 		: request.getParameter("register");
		this.address 	= request.getParameter("address") 	== null ? "" 			: request.getParameter("address");
		
		if(request.getParameter("phone") == null) {
			this.phone = "01012345678";
		}else {
			String[] phones = request.getParameterValues("phone");
			this.phone = phones[0] + phones[1] + phones[2];
		}
		
		try {
			this.enabled 	= request.getParameter("address") == null ? 1 : Integer.parseInt(request.getParameter("enabled"));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(request.getParameter("address") == null) {
				this.regDate = new Date();
			}else {
				this.regDate = sdf.parse(request.getParameter("date"));
			}
		} catch(NumberFormatException e) {
			throw new NotNumberException();
		} catch(ParseException e) {
			throw new NotDateException();
		}
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
