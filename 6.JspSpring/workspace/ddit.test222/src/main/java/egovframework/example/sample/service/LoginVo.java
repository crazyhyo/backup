package egovframework.example.sample.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class LoginVo implements Serializable{

	// [{key:value},{key:value}] 데이터를 char단위로 한글자씩 2진수로 바꾸고 index를 부여한다. 데이터의 부호비트를 넣어준다.
	// VO는 항상 serializable을 해주자. 항상 데이터가 깨지지 않도록 하는 작업
	
	@Override
	public String toString() {
		return "LoginVo [id=" + id + ", name=" + name + ", age=" + age + ", isLogin=" + isLogin + "]";
	}
	private String id;
	private String name;
	private String age;
	private boolean isLogin;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public boolean isLogin() {
		return isLogin;
	}
	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
	}
}
