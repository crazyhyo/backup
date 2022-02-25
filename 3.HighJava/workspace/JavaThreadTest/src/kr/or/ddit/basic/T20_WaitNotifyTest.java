/*
 * 21/09/01 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

public class T20_WaitNotifyTest {
    public static void main(String[] args) {
        DataBox dataBox = new DataBox();

        ProducerThread pth = new ProducerThread(dataBox);
        ConsumerThread cth = new ConsumerThread(dataBox);

        pth.start();
        cth.start();

    }

}

// 데이터를 공통으로 사용하는 클래스
class DataBox{
    private String data;

    // data가 null이 아닐 때 data값을 반환하는 메서드
    public synchronized String getData(){
        if(data == null){
            try{
            	System.out.println("===getData wating===");
                wait();
                System.out.println("===getData 깨어났음===");
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }

        String returnData = data;
        System.out.println("읽어온 데이터 : " + returnData);
        data = null;
        System.out.println(Thread.currentThread().getName()
                + " notify() 호출");
        notify();

        return returnData;
    }
    public synchronized void setData(String data){
        if(this.data != null){
            try{
            	System.out.println("===setData wating===");
                wait();
                System.out.println("===setData 깨어났음===");
            }catch(InterruptedException ex){
                ex.printStackTrace();
            }
        }
        this.data = data;
        System.out.println("세팅한 데이터 : " + this.data);
        System.out.println(Thread.currentThread().getName()
                + " notify() 호출");
        notify();
    }
}

// 데이터를 세팅만 하는 스레드
class ProducerThread extends Thread{
    private DataBox dataBox;

    public ProducerThread(DataBox dataBox){
        super("ProducerThread");
        this.dataBox = dataBox;
    }

    @Override
    public void run(){
        for(int i=1; i<=10; i++){
            String data = "data-" + i;
            System.out.println("dataBox.setData(" + data + ") 호출");

            dataBox.setData(data);
        }
    }

}

// 데이터를 읽어만 오는 스레드
class ConsumerThread extends Thread{
    private DataBox dataBox;

    public ConsumerThread(DataBox dataBox){
        super("ConsumerThread");
        this.dataBox = dataBox;
    }

    @Override
    public void run(){
        for(int i=1; i<=10; i++){
            String data = dataBox.getData(); 
            System.out.println("dataBox.getData() 호출");
        }	
    }
}
