/*
 * 21/09/06 
 * author : Lee KwangHyo
 * 성능향상을 위한 보조 스트림 예제
 * (문자기반의 Bufferd스트림 사용예제)
 */

package kr.or.ddit.basic;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class T12_BufferedIOTest {
    public static void main(String[] args) throws IOException {

        // 이클립스에서 만든 자바 프로그램이 실행되는 기본 위치는
        // 해당 '프로그램 폴더'가 기본위치가 된다.
        /*try(
        FileReader fr = 
            new FileReader("src/kr/or/ddit/basic/T11_BufferedIOTest.java");
           ){
                int c;
                while((c = fr.read()) != -1){
                    System.out.print((char)c);
                }
                fr.close();
           }catch(IOException ex){
               ex.printStackTrace();
            } */
    	FileReader fr = 
                new FileReader("src/kr/or/ddit/basic/T11_BufferedIOTest.java");
        BufferedReader br = new BufferedReader(fr);

        String temp = "";
        for(int i = 1; (temp = br.readLine()) != null; i++){
            System.out.printf("%4d : %s\n", i, temp);
        }
        br.close();
    }

}
