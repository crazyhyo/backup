/*
 * 21/09/01 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

public class T19_WaitNotifyTest {
/*
 * wait() 메서드 => 동기화 영역에서 락을 풀고 Wait-Set영역(공유객체별 존재)
 *                  으로 이동시킨다.
 * notify() 메서드 또는 notifyAll()메서드 => Wait-set영역에 있는 스레드(들)을 깨워서 실행될 수 있도록 한다.
 * (notify()는 하나, notifyAll()메서드는 Wait-set에 있는 전부를 깨운다.)
 *
 * => wait()와 notify(), notifyAll()메서드는 동기화영역에서만 실행할 수 있고,
 *   Object 클래스에서 제공하는 메서드이다.
 */
    public static void main(String[] args) {
        WorkObject workObj = new WorkObject();

        Thread thA = new ThreadA(workObj);
        Thread thB = new ThreadB(workObj);
        Thread thC = new ThreadC(workObj);

        thA.start();
        thB.start();
        thC.start();
    }
}

// 공통으로 사용할 객체
class WorkObject{
    public synchronized void methodA(){
        System.out.println("methodA() 메서드 작업 중...");


        notify();
        try{
        	wait();
        }catch(InterruptedException ex){
            ex.printStackTrace();
        }
    }
    public synchronized void methodB(){
        System.out.println("methodB() 메서드 작업 중...");


        notify();
        try{
            wait();
        }catch(InterruptedException ex){
            ex.printStackTrace();
        }
    }
    public synchronized void methodC(){
        System.out.println("methodC() 메서드 작업 중...");


        notify();
        try{
            wait();
        }catch(InterruptedException ex){
            ex.printStackTrace();
        }
    }
}

// WorkObject의 methodA()메서드만 호출하는 스레드
class ThreadA extends Thread{
    private WorkObject workObj;

    public ThreadA(WorkObject workObj){
        this.workObj = workObj;
    }

    @Override
    public void run(){
        for(int i=1; i<=10; i++){
            workObj.methodA();
        }
        System.out.println("ThreadA 종료");
    }
}

//WorkObject의 methodB()메서드만 호출하는 스레드
class ThreadB extends Thread{
    private WorkObject workObj;

    public ThreadB(WorkObject workObj){
        this.workObj = workObj;
    }

    @Override
    public void run(){
        for(int i=1; i<=10; i++){
            workObj.methodB();
        }
        System.out.println("ThreadB 종료");
    }
}
//WorkObject의 methodC()메서드만 호출하는 스레드
class ThreadC extends Thread{
  private WorkObject workObj;

  public ThreadC(WorkObject workObj){
      this.workObj = workObj;
  }

  @Override
  public void run(){
      for(int i=1; i<=10; i++){
          workObj.methodC();
      }
      System.out.println("ThreadC 종료");
  }
}