/*
 * 21/09/03 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.IOException;

public class T08_FileReaderTest {
    public static void main(String[] args) {

        // 문자 기반의 스트림을 이용한 파일 내용 읽기
        try(
                // 문자단위의 입력을 담당하는Reader형 객체 생성
//                FileReader fr = new FileReader("d:/D_Other/testChar.txt");
                 FileInputStream fr = new FileInputStream("d:/D_Other/testChar.txt");
                // 바이트 단위로 읽기 때문에 한글이 깨져서 나온다
                ){
            int c;
            while((c=fr.read()) != -1){
                System.out.print((char)c);
            }
        }catch(IOException ex){
            ex.printStackTrace();
        }
    }

}
