/*
 * 21/09/16 
 * author : Lee KwangHyo
 */

package kr.or.ddit.tcp;

import java.net.Socket;

public class TcpChatClient {
    public static void main(String[] args) {
        try{
            Socket socket = new Socket("192.168.43.141", 7777);

            System.out.println("서버에 연결되었습니다.");
            System.out.println(socket);

            Sender sender = new Sender(socket);
            Receiver receiver = new Receiver(socket);

            sender.start();
            receiver.start();

        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
