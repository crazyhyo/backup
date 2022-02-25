/*
 * 21/09/03 
 * author : Lee KwangHyo
 * 파일 출력 예제
 */

package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class T06_FileStreamTest {
    public static void main(String[] args) {
        // 파일에 출력하기
        FileOutputStream fos = null;

        try{
            //출력용 OutputStram객체 생성
            fos = new FileOutputStream("d:/D_Other/out.txt");
            for(char ch='a'; ch<='z'; ch++){
                fos.write(ch);
            }
            System.out.println("파일에 쓰기 작업 완료");

            // 쓰기 작업 완료 후 스트림 닫기
            fos.close();

            //=======================================================================
            //저장된 파일의 내용을 읽어와 화면에 출력하기
            FileInputStream fis = new FileInputStream("d:/D_Other/out.txt");
            int c;
            while((c = fis.read()) != -1){
                System.out.print((char)c);
            }
            // 한글이 깨져서 나옴 : java의 char은 2바이트, char단위로 file을 읽어야 함
            // -> 문자기반 stream의 필요성
            System.out.println();
            System.out.println("출력 끝...");

            fis.close();
        }catch(IOException ex){
            ex.printStackTrace();
        }/*finally{
            try{
            }catch(IOException ex){
                ex.printStackTrace();
            }
        }*/

    }

}
