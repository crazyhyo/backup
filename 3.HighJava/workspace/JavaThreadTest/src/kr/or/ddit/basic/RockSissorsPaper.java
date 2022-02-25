/*
 * 21/08/30 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import javax.swing.JOptionPane;

public class RockSissorsPaper {
	
	public static boolean inputChk = false;
	public static int player = -1;
	
    public static void main(String[] args) {
    	
    	new RockSissorsPaper().start();
    	
    }

	private void start() {
		String[] types = {"가위", "바위", "보"};
        int com = (int) (Math.random() * 3);
        String comS = types[com];
        
        InputChecker ichecker = new InputChecker();
        Timer timer = new Timer();
        
        ichecker.start();
        timer.start();
        
        try {
        	ichecker.join();
        }catch(InterruptedException ex) {
        	ex.printStackTrace();
        }
        
        if(inputChk) {
        	String playerS = types[player];
        	int calc = (com - player) % 3;
        	
        	System.out.println("===결과===");
        	System.out.println("컴퓨터 : " + comS);
        	System.out.println("플레이어 : " + playerS);
        	
        	switch (calc) {
        	case 0: System.out.println("결과 : 비겼습니다."); break;
        	case 1: System.out.println("결과 : 컴퓨터의 승리."); break;
        	case 2: System.out.println("결과 : 플레이어의 승리."); break;
        	}
        }
	} 
}

class InputChecker extends Thread {
    @Override
    public void run(){

        String str;
        do {
        str = JOptionPane.showInputDialog("0: 가위, 1: 바위, 2: 보");
        }while(!(str.equals("0")||str.equals("1")||str.equals("2")));
        RockSissorsPaper.inputChk = true;
        RockSissorsPaper.player = Integer.parseInt(str);

    }
}

class Timer extends Thread{
	@Override
	public void run() {
		for(int i = 5; i >= 1; i--) {
			if(RockSissorsPaper.inputChk) {
				return;
			}
			try {
				System.out.println(i);
				Thread.sleep(1000);
			}catch(InterruptedException ex) {
				ex.printStackTrace();
			}
		}
		System.out.println("제한시간 종료");
		System.exit(0);
	}
}
