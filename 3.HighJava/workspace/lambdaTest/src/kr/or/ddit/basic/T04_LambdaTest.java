/*
 * 21/09/02 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class T04_LambdaTest {
    public static void main(String[] args) {
        List<String> list = Arrays.asList("홍길동", "이순신", "변학도");
        list.forEach(name -> System.out.println(name));
    }

}
