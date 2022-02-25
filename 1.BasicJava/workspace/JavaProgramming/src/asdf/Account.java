package asdf;

import java.util.ArrayList;

public class Account {
	String name;
	int[] quantity = new int[3];
	double[] avgCost = new double[3]; 
	int sum = 0;
	ArrayList<TradeRecord> tradeRecord = new ArrayList<TradeRecord>();

	Account(Coins[] coins, String name){
		for(int i = 0; i < coins.length; i++)		quantity[i] = 0;
		this.name = name;
	}
	void printAccount(Coins[] coins){
		for(int i = 0; i < 3; i++)	getAvg(i, coins);
		System.out.println("=================================계좌잔고 현황==================================");
		for(int i = 0; i < coins.length; i++){
			System.out.print("이름: " + coins[i].name + "\t\t보유수량: " + quantity[i] +"(" + String.format("%.2f",avgCost[i]) + "/"); 
		    if(avgCost[i] != 0)
		    	System.out.print(String.format("%.2f", ((coins[i].price/avgCost[i]) - 1) * 100) + "%)");
		    else
		    	System.out.print("0.00%)\t");
			System.out.println("\t현재가치 : " + String.format("%.0f", coins[i].price * quantity[i]));
		}
		getTotal(coins);
		System.out.println("계좌 총 자산 : " + sum);
		System.out.println("=============================================================================");
//		printTradeRecord();
	}
	
	int getTotal(Coins[] coins){
		sum = 0;
		for(int i = 0; i < coins.length; i++)			sum += coins[i].price * quantity[i];
		return sum;
	}
	
	void getAvg(int i, Coins[] coins){
		int currentQuantity = 0;
		int index = 0;
		int cmpQtt = 0;
		double tempSum = 0;
		for (TradeRecord walk : tradeRecord) {
			if (walk.coinInfo.name.equals(coins[i].name)) {
				currentQuantity += walk.quantity;
				if (currentQuantity == 0) {
					index = tradeRecord.indexOf(walk);
				}
			}
		}
		while(cmpQtt < currentQuantity){
		for(TradeRecord walk : tradeRecord){
			if(tradeRecord.indexOf(walk) >= index && walk.coinInfo.name.equals(coins[i].name)){
					if(walk.quantity + cmpQtt <= currentQuantity && walk.quantity > 0){
						cmpQtt += walk.quantity;
						tempSum += walk.quantity * walk.coinInfo.price;
					}else if(walk.quantity > 0){
						tempSum += (currentQuantity - cmpQtt) * walk.coinInfo.price;
						cmpQtt = currentQuantity;
						break;
					}
				}
			}
		}
		if(currentQuantity != 0)			avgCost[i] = tempSum / currentQuantity;
		else								avgCost[i] = 0;
	}

//	void printTradeRecord(){
//		for(TradeRecord walk : tradeRecord){
//			System.out.print("("+walk.coinInfo.date + ")" + String.format("%.2f",walk.coinInfo.price) + "/" + walk.quantity);
//		}
//		System.out.println(Arrays.toString(quantity));
//		System.out.println();
//	}


}
