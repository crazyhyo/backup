/*
 * 21/08/30 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

public class T09_ThreadDaemonTest {
    public static void main(String[] args) {

        AutoSaveThread autoSave = new AutoSaveThread();

        // 데몬스레드로 설정하기 ( start()메서드 호출하기 전에 설정한다.)
        autoSave.setDaemon(true);
        autoSave.start();

        try{
            for(int i=1; i <=20; i++){
                System.out.println("작업" + i);

                Thread.sleep(1000);
            }
        }catch(InterruptedException ex){
            ex.printStackTrace();
        }

        System.out.println("메인 스레드 종료");
 
    } 

}

class AutoSaveThread extends Thread{
    public void save(){
        System.out.println("작업 내용을 저장합니다..."); 
    }
    /**
     *  데이터 저장 기능
     */
    @Override
    public void run(){
        while(true){
            try{
                Thread.sleep(3000);
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
            save(); // 저장기능 호출
        }
    }

}
