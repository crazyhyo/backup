/*
 * 21/08/31 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

public class T13_ThreadStopTest {
    /*
     * Thread의stop()메서드를 호출하면 스레드가 바로 멈춘다.
     * 이때 사용하던 자원을 정리하지 못하고 프로그램이 종료되어서 
     * 나중에 실행되는 프로그램에 영향을 줄 수 있다.
     * 그래서 현재는 stop()메서드는 비추천으로 되어있다.
     */
    public static void main(String[] args) {
        //ThreadStopEx1 th = new ThreadStopEx1();
        //th.start();
//
        //try{
            //Thread.sleep(1000);
        //}catch(InterruptedException ex){
            //ex.printStackTrace();
        //}
        //th.setStop(true);
        // th.stop();
        ThreadStopEx2 th2 = new ThreadStopEx2();
        th2.start();
        try{
            Thread.sleep(1000);
            
        }catch(InterruptedException ex){ 
            ex.printStackTrace();
        }
        th2.interrupt();
    }

}

class ThreadStopEx1 extends Thread{
    private boolean stop;

    public void setStop(boolean stop){
        this.stop = stop;
    }

    @Override
    public void run(){
        while(!stop){
            System.out.println("스레드 처리 중...");
        }

        System.out.println("자원 정리 중...");
        System.out.println("실행 종료.");
    }
}

// interrupt() 이용하여 스레드를 멈추게 하는 방법
class ThreadStopEx2 extends Thread{
    @Override
    public void run(){
        // 방법1 : sleep() 메서드나 join()메서드 등을 사용할 때 interrupt()
        //         메서드를 호출하면 interruptedException이 발생한다.
        /*try{
            while(true){
                System.out.println("스레드 처리 중....");
                Thread.sleep(1);
            }
        }catch(InterruptedException ex){ }
        System.out.println("자원 정리 중...");
        System.out.println("실행 종료.");*/

        while(true){
            System.out.println("스레드 처리 중....");
            // 검사방법1 : 스레드의 인스턴스 객체용 메서드를 이용하는 방법
            if(isInterrupted()){
                System.out.println("인스턴스용 isInterrupted() : "
                		+ isInterrupted());
                break;
            }
            // 검사방법2 : 스레드의 정적 메서드를 이용하는 방법
//            if(Thread.interrupted()) {
//            	System.out.println("정적 메서드 Thread.interrupted() : "
//                        + Thread.interrupted());
                // Thread.interrupted()메서드는 interrupt된 첫번째만 true를 반환하고
                // 초기화하기 때문에 그 이후에는 다시 기본인 false를 반환한다.
            //      인스턴스용 메서드는 아님
//            	break;
//            }
        }
        System.out.println("자원 정리 중...");
        System.out.println("실행 종료.");
    }
}
