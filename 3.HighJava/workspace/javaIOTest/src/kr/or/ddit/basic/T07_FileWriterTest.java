/*
 * 21/09/03 
 * author : Lee KwangHyo
 * FileWriter(문자기반 스트림) 테스트
 */

package kr.or.ddit.basic;

import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

public class T07_FileWriterTest {
    public static void main(String[] args) {
        // 사용자가 입력한 내용을 그대로 파일로 저장하기
        //
        // 콘솔(표준입력장치)과 연결된 입력용 문자기반 스트림 생성
        // InputStreamReader => 바이트 기반 스트림을 문자기반 스트림으로 
        //                      변환해주는 보조스트림이다.
    	//	보조스트림은 일반스트림을 보조하는 역할을 한다.
    	// 따라서 일반스트림 없이는 보조스트림은 존재할 수 없다(Daemon Thread 같은 존재)
    	// 그래서 보조스트림의 생성자에는 일반스트림을 파라미터로 받는다.
    	// 콘솔입력을 처리하기 위한 인풋스트림이 System.in이다.
    	// Try-with-resources!


        try(
        		InputStreamReader isr = new InputStreamReader(System.in);
        		FileWriter fw = new FileWriter("d:/D_Other/testChar.txt"); // 파일 출력용 문자기반 스트림
        		)
        
        {
        	
            // 파일 출력용 문자 스트림 객체 생성
//            fw = new FileWriter("d:/D_Other/testChar.txt");

            System.out.println("아무거나 입력하세요.");
            int c;

            // 콘솔에서 입력할 때 입력의 끝 표시는 Ctrl + Z 키를 누르면 된다.

            while((c = isr.read()) != -1){
                fw.write(c); // 콘솔에서 입력받은 값을 파일에 출력하기
            }

            System.out.println("작업 끝");

//            isr.close();
//            fw.close();
        }catch(IOException ex){
            ex.printStackTrace();
        }

    }

}
