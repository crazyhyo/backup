/*
 * 21/09/01 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;
@FunctionalInterface
public interface T02_LambdaTestInterface1 {
    // 반환값이 없고 매개변수도 없는 추상메서드 선언
    public void test();
}
@FunctionalInterface
interface T02_LambdaTestInterface2 {
    // 반환값이 없고 매개변수는 있는 추상메서드 선언
    public void test(int a);
}
@FunctionalInterface
interface T02_LambdaTestInterface3 {
    // 반환값이 있고 매개변수도 있는 추상메서드 선언
    public int test2(int a, int b);
//    public void test(int a);
}
