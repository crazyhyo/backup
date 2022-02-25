package kr.or.ddit.basic;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class T12_PropertiesTest {
    /*
     * Properties는 Map보다 축소된 기능의 객체라고 할 수 있다.
     * Map은 모든 형태의 객체데이터를 key와 value값으로 사용할 수 있지만
     * Properties는 key와 value값으로 String만 사용할 수 있다.
     *
     * Map은 put(), get()메서드를 이용하여 데이터를 입력하지만
     * Properties는 setProperty(), getProperty()메서드를 통해서 데이터를
     * 입출력한다.
     */

    public static void main(String[] args) throws IOException{
        Properties prop = new Properties();

        prop.setProperty("name", "홍길동");
        prop.setProperty("tel", "010-1234-5678");
        prop.setProperty("addr", "대전");

        String name = prop.getProperty("name");
        String tel = prop.getProperty("tel");
        
        System.out.println("이름 : " + name);
        System.out.println("전화 : " + tel);
        System.out.println("주소 : " + prop.getProperty("addr"));

        // 내용을 파일로 저장하기
        prop.store(
                new FileOutputStream(
                    "src/kr/or/ddit/basic/my.properties"),
                    "주석(COMMENT)입니다.");
        //주소지정시 root부터 시작하지 않고 바로 폴더명부터 시작하면
        //실제는 "./src/kr/or/ddit/basic/my.properties"으로 시작하며
        //.은 현재폴더인 프로젝트 CollectionTest를 의미한다.

    }
}
