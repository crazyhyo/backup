package kr.or.ddit.basic.ThreadGame;

import java.util.Scanner;

public class PlayThread extends Thread{
	
	PlayCommon pCom;
	int index;
	
	public PlayThread(PlayCommon pCom, int index) {
		this.pCom = pCom;
		this.index = index;
	}
	
	@Override
	public void run() {
		
		Scanner sc = new Scanner(System.in);
		int input;
		
		game : while(true) {
			System.out.println("===" + pCom.getPlayers()[index].getName() + "의 턴===");
			System.out.println("1. 공격\t2. 종료");
			input = sc.nextInt();
			switch(input) {
			case 1:
				if(index == 0) {
					pCom.oneAtkTwo();
				}else if(index == 1) {
					pCom.twoAtkOne();
				}
				if(!pCom.getPlayers()[(index + 1) % 2].isAlive()) {
					System.out.println(pCom.getPlayers()[index].getName() + "의 승리");
					break game;
				}else {
					System.out.println("상대방의 턴으로 넘어갑니다.");
					notify();
					try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
				break;
			case 2:
				System.out.println("종료하셨습니다.");
				break game;
			}
		}
	}
}
