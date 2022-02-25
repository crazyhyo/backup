package kr.or.ddit.exception;

public class NotANumberException extends Exception{
	
	public NotANumberException() {
		super("알맞은 숫자 형식이 아닙니다.");
	}

}
