package kr.or.ddit.basic.ThreadGame;

public class MyGame {
	public static void main(String[] args) {
		Player player1 = new Player("asdf");
		Player player2 = new Player("qwer");
		
		PlayCommon pCom = new PlayCommon(player1, player2);
		
		PlayThread p1Thread = new PlayThread(pCom, 0);
		PlayThread p2Thread = new PlayThread(pCom, 1);
		
		p1Thread.start();
		p2Thread.start();
	}
}
