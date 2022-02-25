package dealMeter;

public class TestGame {
	
	public static void main(String[] args) {
		Monster mon = new Monster(2000);
		
		Player player1 = new Player("player1", mon);
		Player player2 = new Player("player2", mon);
		Player player3 = new Player("player3", mon);
		Player player4 = new Player("player4", mon);
		Player player5 = new Player("player5", mon);
		
		player1.start();
		player2.start();
		player3.start();
		player4.start();
		player5.start();
	}
	
	
}
