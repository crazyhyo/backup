package e_oop;

import java.util.ArrayList;

public class Coins {
	
	static final int[] COLLAPSE = {100, 10, 1};
	String name;
	double price = 0;
	int typeIndex = 0;
	double variance = 0;
	boolean onMarket = true;
	ArrayList<CoinInfo> information = new ArrayList<CoinInfo>();
	ArrayList<Double> differences = new ArrayList<Double>();
	
	
	Coins(int type){
		switch(type){
		case 0:
			typeIndex = type;
			name = "비트코인";	price = 2000;		variance = 0.37;
			price += ((Math.random() * (price * 2 + 1)) - price) * variance;
			information.add(new CoinInfo(name, price, 1));
			break;
		case 1:
			typeIndex = type;
			name = "리플";	price = 200;			variance = 0.37;
			price += ((Math.random() * (price * 2 + 1)) - price) * variance;
			information.add(new CoinInfo(name,price, 1));
			break;
		case 2:
			typeIndex = type;
			name = "도지코인";	price = 20;			variance = 0.37;
			price += ((Math.random() * (price * 2 + 1)) - price) * variance;
			information.add(new CoinInfo(name,price, 1));
			break;
		}
	}
	
	void printCoin(){
		if(onMarket){
			System.out.print("name: " + name + "\t\t\t\tprice: ");
			System.out.println(String.format("%.2f", price));
		}
		else{
			System.out.println("name: " + name + " is not on market");
		}
	}
	void printIsInMarket(){
		if(onMarket){
			if(price < COLLAPSE[typeIndex]){
				System.out.println("<<<<<<<" + name + ":no longer exist on market" + ">>>>>>>");
				onMarket = false;
			}
		}else if(price >= COLLAPSE[typeIndex]){
			System.out.println("<<<<<<<" + name + " in market!" + ">>>>>>>");
			onMarket = true;
			price = COLLAPSE[typeIndex] * 20;
		}
	}
	
	void record(String name, int days){
		information.add(new CoinInfo(name, price, days));
		differences.add(information.get(days-1).price - information.get(days-2).price);
	}
	
	void showCoinInfo(){
		System.out.println("\n<<" + name + ">>");
		for(CoinInfo temp : information){
			if(information.size() == 1){
				if(onMarket){
					System.out.print(temp.date + "일 가격: ");
					System.out.print(String.format("%.2f", temp.price));
					System.out.println("\t증감 : -");
				}
				else{
					System.out.print(temp.date + "일 가격: ");
					System.out.print("조회불가");
					System.out.println("\t증감 : -");
				}
			}else{
				if(onMarket){
					System.out.print(temp.date + "일 가격: ");
					System.out.print(String.format("%.2f", temp.price));
					if(information.size() > temp.date){
						System.out.print("\t증감 : " + String.format("%.2f", differences.get(temp.date - 1)));
						System.out.println("(" + String.format("%.2f",(differences.get(temp.date - 1) / temp.price * 100)) + "%)");
						}
				}else{
					System.out.print(temp.date + "일 가격: ");
					System.out.print("조회불가");
					System.out.println("\t증감 : -");
				}
			}
		}
		System.out.println("\n");
	}
	
}
