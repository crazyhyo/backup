/*
 * 21/08/30 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;
/*
 * 멀티스레드를 활용한 카운트다운 처리 예제
 */

import javax.swing.JOptionPane;

public class T06_ThreadTest {
    // 입력여부 확인하기 위한 변수 선언
    // 모든 스레드에서 공통으로 사용할 변수
    public static boolean inputCheck = false;
    public static void main(String[] args) {

        DataInput input = new DataInput();
        input.start();
        CountDown count = new CountDown();
        count.start();


    } 

}

/**
 * 데이터를 입력받기 위한 스레드
 */
class DataInput extends Thread {
    @Override
    public void run(){
        String str = JOptionPane
            .showInputDialog("아무거나 입력하세요.");
        // 입력이 완료되면 inputCheck변수를 true로 변경한다.
        T06_ThreadTest.inputCheck = true;
        System.out.println("입력한 값은 " + str + "입니다."); 

    }

}

class CountDown extends Thread {
    @Override
    public void run(){
        for(int i=10; i>=1; i--){
            // 입력이 완료되었는지 여부를 검사하고 입력이 완료되면
            // run()메서드를 종료시킨다. 즉, 현재스레드를 종료시킨다.
            if(T06_ThreadTest.inputCheck == true) {
                return; // run메서드가 종료되면 스레드도 종료된다.
            }
            System.out.println(i); 
            try{
                Thread.sleep(1000);
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }
        // 10초가 경과되었는데도 입력이 없으면 프로그램을 종료한다.
        System.out.println("10초가 지났습니다. 프로그램을 종료합니다."); 
        System.exit(0); // 프로그램을 종료시키는 명령
    }

}
