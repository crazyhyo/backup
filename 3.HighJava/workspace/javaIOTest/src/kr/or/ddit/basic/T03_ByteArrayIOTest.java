/*
 * 21/09/02 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Arrays;

public class T03_ByteArrayIOTest {
    public static void main(String[] args) throws IOException {
        byte[] inSrc = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 13, -1, 15};
        byte[] outSrc = null;


        // arraycopy를 이용한 배열 복사하기
        outSrc = new byte[inSrc.length];
        System.arraycopy(inSrc, 0, outSrc, 0 , inSrc.length);

        System.out.println("arraycopy이용... outSrc => ");
        System.out.println(outSrc);
        // 스트림 선언 및 객체 생성
        ByteArrayInputStream bais = null; // 스트림 객체 선언
        bais = new ByteArrayInputStream(inSrc); // 객체 생성

        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        int data; // 읽어온 자료를 저장할 변수

        // read()메서드 => byte단위로 자료를 읽어와 int형으로 반환한다.
        //                 더 이상 읽어올 자료가 없으면 -1을 반환한다.
        // fileIO는 OS의 영역, os Call(system Call?)을 해서 이루어진다.
        System.out.println("읽기 시작");
        while((data = bais.read()) != -1){
            // 읽는 족족 data에 대입하고 그 값이 -1과 다르다면 반복문 실행
            baos.write(data); // 출력하기
            System.out.println(data);
        }
        System.out.println("읽기 종료");

        // 출력된 스트림 값들을 배열로 변환해서 반환하는 메서드
        outSrc = baos.toByteArray();

        System.out.println("inSrc => " + Arrays.toString(inSrc));
        System.out.println("outSrc => " + Arrays.toString(outSrc));

        // 스트림 객체 닫기
        // 스트림은 생성한 후에 닫는다.
        bais.close();
        baos.close();
    }

}
