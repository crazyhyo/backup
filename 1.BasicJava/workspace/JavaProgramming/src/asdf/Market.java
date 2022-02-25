package asdf;

import java.util.ArrayList;

public class Market {
	Coins[] coins;
	ArrayList<CoinInfo> information = new ArrayList<CoinInfo>();
	ArrayList<Double> differences = new ArrayList<Double>();
	Coins[] nextCoins;
	
	
	Market(){
		Coins[] coins = new Coins[3];
		Coins[] nextCoins = new Coins[3];
		for(int i = 0; i < 3; i++){
			coins[i] = new Coins(i);
			information.add(new CoinInfo(coins[i].name,coins[i].price,1, true));
			nextCoins[i] = new Coins(coins[i]);
		}
		this.coins = coins;
		this.nextCoins = nextCoins;
		for(int i = 0; i < coins.length; i++){
			nextCoins[i].price = coins[i].price + ((Math.random() * coins[i].price * 2) - coins[i].price) * coins[i].variance;
			nextCoins[i].price = coins[i].price + ((Math.random() * coins[i].price * 2) - coins[i].price) * coins[i].variance;
			if(!nextCoins[i].onMarket)		nextCoins[i].price += nextCoins[i].COLLAPSE[i] * 0.3;
			record(nextCoins[i].name, nextCoins[i].price, 2, nextCoins[i].onMarket);
		}
		recordDiff();
	}
	
	void record(String name, double price, int days, boolean onMarket){
		information.add(new CoinInfo(name, price, days, onMarket));
	}
	void recordDiff(){
		int len = information.size();
		differences.add(information.get(len - 3).price - information.get(len - 6).price);
		differences.add(information.get(len - 2).price - information.get(len - 5).price);
		differences.add(information.get(len - 1).price - information.get(len - 4).price);
	}
	
	void showCoinInfo(int i){
		ArrayList<CoinInfo> tempInformation = new ArrayList<CoinInfo>(information.subList(0, information.size() - 3));
		
		System.out.println("\n<<" + coins[i].name + ">>");
		for(CoinInfo temp : tempInformation){
			if(tempInformation.size() == 3){
				if(information.get(temp.date * 3 - 3 + i).onMarket && temp.name == coins[i].name){
					System.out.print(temp.date + "일 가격: ");
					System.out.print(String.format("%.2f", temp.price));
					System.out.println("\t증감 : -");
				}
				else if(!tempInformation.get(temp.date * 3 - 3 + i).onMarket && (tempInformation.indexOf(temp) % 3 == 0)){
					System.out.print(temp.date + "일 가격: ");
					System.out.print("조회불가");
					System.out.println("\t증감 : -");
				}
			}else{
				if(tempInformation.get(temp.date * 3 - 3 + i).onMarket && temp.name == coins[i].name){
					System.out.print(temp.date + "일 가격: ");
					System.out.print(String.format("%.2f", temp.price));
					if(tempInformation.size() > temp.date * 3){
						System.out.print("\t증감 : " + String.format("%.2f", differences.get(temp.date * 3 - 3 + i)));
						System.out.println("(" + String.format("%.2f",(differences.get(temp.date * 3 - 3 + i) / temp.price * 100)) + "%)");
						}
				}else if(!tempInformation.get(temp.date * 3 - 3 + i).onMarket && (information.indexOf(temp) % 3 == 0)){
					System.out.print(temp.date + "일 가격: ");
					System.out.print("조회불가");
					System.out.println("\t증감 : -");
				}
			}
		}
		System.out.println("\n");
	}
	void printCoin(int i){
		if(coins[i].onMarket){
			System.out.print("이름: " + coins[i].name + "\t\t\t\t가격: ");
			System.out.print(String.format("%.2f", coins[i].price));
		}
		else{
			System.out.println("이름: " + coins[i].name + "\t\t\t\t(상장폐지)");
		}
	}
	void printIsInMarket(int i, int days){
		if(coins[i].onMarket){
			if(coins[i].price < coins[i].COLLAPSE[coins[i].typeIndex]){
				System.out.println("<<<<<<<" + coins[i].name + "이 상장폐지되었습니다." + ">>>>>>>");
				coins[i].onMarket = false;
				
			}
		}else if(coins[i].price >= coins[i].COLLAPSE[coins[i].typeIndex]){
			System.out.println("<<<<<<<" + coins[i].name + "이 상장되었습니다." + ">>>>>>>");
			coins[i].onMarket = true;
			coins[i].price = coins[i].COLLAPSE[coins[i].typeIndex] * 10;
			coins[i].price += ((Math.random() * coins[i].price * 2) - coins[i].price) * coins[i].variance;
		}
	}
}
