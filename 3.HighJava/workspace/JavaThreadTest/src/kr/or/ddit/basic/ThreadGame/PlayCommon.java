package kr.or.ddit.basic.ThreadGame;

public class PlayCommon {
	private Player player1;
	private Player player2;
	
	public PlayCommon(Player player1, Player player2) {
		this.player1 = player1;
		this.player2 = player2;
	}
	
	public Player[] getPlayers() {
		Player[] players = {player1, player2};
		return players;
	}
	
	public synchronized void oneAtkTwo() {
		player1.Attack(player2);
	}
	public synchronized void twoAtkOne() {
		player2.Attack(player1);
	}
	
}
