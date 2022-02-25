/*
 * 21/09/03 
 * author : Lee KwangHyo
 * 파일 읽기 예제
 */

package kr.or.ddit.basic;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class T05_FileStreamTest {
    public static void main(String[] args) {
        // FileInputStream객체를 이용한 파일 내용 읽기
        FileInputStream fis = null; // 변수선언

        try{
            // 객체 생성
            File file = new File("d:/D_Other/test2.txt");
            fis = new FileInputStream(file); // 생성

            int c; // 읽어온 데이터를 저장할 변수

            // 읽어온 값이 -1이면 파일의 끝까지 읽었다는 의미이다.
            while((c=fis.read()) != -1){
                // 읽어온 자료 출력하기
                System.out.print((char)c);
            }
            System.out.println();
        }catch(IOException ex){
            ex.printStackTrace();
        }finally{
            try{
                fis.close(); // 작업 완료 후 스트림 닫기
            }catch(IOException ex){
                ex.printStackTrace();
            }
        }
    }

}
