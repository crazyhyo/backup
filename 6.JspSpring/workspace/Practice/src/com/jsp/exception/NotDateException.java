package com.jsp.exception;

public class NotDateException extends Exception{

	public NotDateException() {
		super("알맞은 날자형식이 아닙니다.");
	}
}
