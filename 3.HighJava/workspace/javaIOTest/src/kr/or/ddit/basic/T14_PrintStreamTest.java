/*
 * 21/09/06 
 * author : Lee KwangHyo
 * 프린터 기능 제공 보조 스트림 예제
 */

package kr.or.ddit.basic;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.PrintWriter;

public class T14_PrintStreamTest {
    public static void main(String[] args) {

        try(
                FileOutputStream fos = new FileOutputStream("d:/D_Other/print.txt");
                FileOutputStream fos2 = new FileOutputStream("d:/D_Other/print2.txt");
                // printStream은 모든 자료형을 출력할 수 있는 기능을 제고앟는
                // OutputStream의 서브클래스이다.
                PrintStream out = new PrintStream(fos);
                //PrintWriter pw = new PrintWriter(fos2);
                PrintWriter pw = new PrintWriter(
                    new OutputStreamWriter(fos2, "utf8"));
           ){
            out.print("안녕하세요. PrintStream입니다.\n");
            out.println("안녕하세요. PrintStream입니다2.\n");
            out.println("안녕하세요. PrintStream입니다3.\n");
            out.println(out); // 객체 출력
            out.println(3.14);
            out.println(true);

            out.close();

            // PrintWriter가 PrintStream보다 다양한 문자를 처리하는데 적합하다.
            // 둘다 기본적으로 autoflush 기능이 꺼져있음.
            // 향상된 기능의 PrintWriter가 추가되었지만PrintStream은 계속
            // 사용되고있음
            pw.print("안녕하세요. PrintStream입니다.\n");
            pw.println("안녕하세요. PrintStream입니다2.\n");
            pw.println("안녕하세요. PrintStream입니다3.\n");
            pw.println(pw); // 객체 출력
            pw.println(3.14);
            pw.println(true);

            pw.close();

           }catch(IOException ex){
               ex.printStackTrace();
           }
    }

}
