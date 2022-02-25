package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class TulipsCopy {
	public static void main(String[] args) {
		try(
				FileInputStream fis = new FileInputStream("d:/D_Other/Tulips.jpg");
				FileOutputStream fos = new FileOutputStream("d:/D_Other/복사본_Tulips.jpg")){
			
			int c;
			while((c=fis.read()) != -1) {
				fos.write(c);
			}
			System.out.println("작업완료");
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
}
