package h_exception;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class Finally {

	public static void main(String[] args) {
		/*
		 * finally
		 * - 필요에 따라 try-catch 뒤에 finally를 추가할 수 있다.
		 * - finally는 예외의 발생여부와 상관없이 가장 마지막에 수행된다.
		 * 
		 * 자동 자원 반환(자바 1.7부터 사용가능)
		 * - try(변수 선언;변수 선언) {} catch(Exception e) {}
		 * - 사용 후 반환이 필요한 객체를 try의 () 안에서 선언하면 try 블럭 종료시 자동으로 반환된다. 자동으로 close된다.
		 */
		
		FileInputStream fis = null; //파일 읽기
		
		try {
			fis = new FileInputStream("d:/file.txt");
			//fileIO는 운영체제의 도움을 받아야 한다. 
			//운영체제의 도움을 받는 메소드는 반드시 사용후 close로 운영체제에게 빌려온 Stream을 반납해야 함
		} catch (FileNotFoundException e) {
			e.printStackTrace();
//		} catch (ArithmeticException e){
//			e.printStackTrace();
		} finally{
			try {
				fis.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//자동 자원 반환
		try(FileOutputStream fos = new FileOutputStream("d:/file.txt")) {
			String str = "asdfAsdfaSdfasDfasdFASdfAsDfAsdFaSDfaSdFasDFaSDFAsDFASdFASDfASDF";
			byte[] bytes = str.getBytes();
			
			for(int i = 0; i < bytes.length; i++){
				fos.write(bytes[i]);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
