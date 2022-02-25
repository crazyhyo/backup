package e_oop;

public class FireAnt {
	
	
	public static void main(String[] args) {

		Coins[] coins = new Coins[3];
		for(int i = 0; i < 3; i++){
			coins[i] = new Coins(i);
		}
		System.out.println("이름을 입력해주세요.");
		String name = ScanUtil.nextLine();
		Ant ant = new Ant(name, coins, 0);
		
		
		
		boolean flag = true;
		while(flag){
			System.out.println("1쉬움\t\t2보통\t\t3어려움");
			System.out.println("난이도를 선택해주세요.");
			int goal = ScanUtil.nextInt();
			switch(goal){
			case 1:
				ant.goal = 100000;
				ant.account = new Account(coins, ant.name);
				for(int i = 0; i < coins.length; i++) ant.account.coins[i].variance = 0.27;
				flag = false;
				break;
			case 2:
				ant.goal = 500000;
				ant.account = new Account(coins, ant.name);
				for(int i = 0; i < coins.length; i++) ant.account.coins[i].variance = 0.47;
				flag = false;
				break;
			case 3:
				ant.goal = 1000000;
				ant.account = new Account(coins, ant.name);
				ant.account.coins[0].variance = 0.47;
				for(int i = 0; i < coins.length; i++) ant.account.coins[i].variance = 0.67;
				flag = false;
				break;
			}
		}
		
		CoinGame coinGame = new CoinGame(coins, ant);
		
		coinGame.run();
		
	}
	

}
