package h_exception;

import java.io.IOException;

public class ThrowException {

	public static void main(String[] args) {
		/*
		 * 메서드에 예외 선언하기
		 * - 메서드 호출시 발생할 수 잇는 예외를 선언해줄 수 있다.
		 * - void methods() throws IOException {}
		 * - 메서드의 구현부 끝에 throws 예약어와 클래스명으로 예외를 선언할 수 있다.
		 * - 예외를 선언하면 예외처리를 하지 않고 자신을 호출한 메서드로 예외처리를 넘겨준다.
		 */
		
		try {
			method();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//ctrl1을 실행했을 때 메서드에 surround with try-catch가 옵션이 있는 경우는
		//사용하려는 메서드에 throws 구문이 있는 경우이다.
	}

	private static void method() throws IOException {
		throw new IOException();
	}

}
