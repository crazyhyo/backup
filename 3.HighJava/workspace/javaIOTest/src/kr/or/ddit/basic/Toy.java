/*
 * 21/09/03 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class Toy {
    public static void main(String[] args) {
        try(
                FileInputStream fis = new FileInputStream("d:/D_Other/test2.txt");
                FileOutputStream fos = new FileOutputStream("d:/D_other/toy.txt");
                InputStreamReader isr = new InputStreamReader(fis, "utf-8");
                OutputStreamWriter osw = new OutputStreamWriter(fos, "utf-8");
        ){

        int c;
        while((c = isr.read()) != -1){
            osw.write(c);
        }
        System.out.println("작업완료");

        }catch(IOException ex){
            ex.printStackTrace();
        }
    }

}
