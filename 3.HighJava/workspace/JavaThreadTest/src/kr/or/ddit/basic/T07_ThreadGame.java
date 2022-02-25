/*
 * 21/08/30 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import javax.swing.JOptionPane;

public class T07_ThreadGame {
    static boolean inputCheck = false;
    static int input = 0;
    static int computer = (int) (Math.random() * 3 + 1);

    public static void main(String[] args) {


        new InputThread().start();
        new CountDown2().start();
    } 

}

class InputThread extends Thread{
    @Override
    public void run(){
        String str = JOptionPane
            .showInputDialog("가위, 바위, 보를 입력하세요(가위 : 1, 바위 : 2, 보 : 3");
        // 입력이 완료되면 inputCheck변수를 true로 변경한다.
        T07_ThreadGame.inputCheck = true;
        T07_ThreadGame.input = Integer.parseInt(str);

        String com = "";
        String my = "";
        if(T07_ThreadGame.computer == 1){
           com = "가위"; 
        }else if(T07_ThreadGame.computer == 2){
            com = "바위";
        }else if(T07_ThreadGame.computer == 3){
            com = "보";
        }
        if(T07_ThreadGame.input == 1){
           my = "가위"; 
        }else if(T07_ThreadGame.input == 2){
            my = "바위";
        }else if(T07_ThreadGame.input == 3){
            my = "보";
        }
        
        int result = (T07_ThreadGame.computer - T07_ThreadGame.input) % 3;
        
        System.out.println("===결과==="); 
        System.out.println("컴퓨터 : " + com); 
        System.out.println("당신 : " + my); 
        System.out.print("결과 : "); 
        if(result % 3 == 1){
            System.out.println("컴퓨터가 이겼습니다."); 
        }else if(result % 3 == 2) {
            System.out.println("당신이 이겼습니다."); 
        }else if(result % 3 == 0)
            System.out.println("비겼습니다."); 
        }

    }
class CountDown2 extends Thread {
    @Override
    public void run(){
        for(int i=5; i>=1; i--){
            // 입력이 완료되었는지 여부를 검사하고 입력이 완료되면
            // run()메서드를 종료시킨다. 즉, 현재스레드를 종료시킨다.
            if(T07_ThreadGame.inputCheck == true) {
                return; // run메서드가 종료되면 스레드도 종료된다.
            }
            System.out.println(i); 
            try{
                Thread.sleep(1000);
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }
        // 5초가 경과되었는데도 입력이 없으면 프로그램을 종료한다.
        System.out.println("5초가 지났습니다. 프로그램을 종료합니다."); 
//        System.exit(0); // 프로그램을 종료시키는 명령
        return;
    }

}
