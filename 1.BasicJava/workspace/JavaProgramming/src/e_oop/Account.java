package e_oop;

import java.util.ArrayList;

public class Account {
	Coins[] coins = new Coins[3];
	int[] quantity = new int[coins.length];
	String name;
	int sum = 0;
	ArrayList<TradeRecord> tradeRecord;
	
	
	
	Account(Coins[] coins, String name){
		this.coins = coins;
		for(int i = 0; i < coins.length; i++)		quantity[i] = 0;
		this.name = name;
	}
	void printAccount(Coins[] coins){
		this.coins = coins;
		System.out.println("=================================계좌잔고 현황==================================");
		for(int i = 0; i < coins.length; i++){
			System.out.println("이름: " + coins[i].name + "\t\t보유수량: " + quantity[i] + "\t\t현재가치 : "
		                       + String.format("%.0f", coins[i].price * quantity[i]));
		}
		getTotal();
		System.out.println("계좌 총 자산 : " + sum);
		System.out.println("=============================================================================");
	}
	
	int getTotal(){
		sum = 0;
		for(int i = 0; i < coins.length; i++)			sum += this.coins[i].price * quantity[i];
		return sum;
	}
}
