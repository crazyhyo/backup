package e_oop;

import java.util.ArrayList;

public class TradeRecord{
	
	ArrayList<CoinInfo> coinInfo;
	ArrayList<Integer> quantity;
	
	TradeRecord(CoinInfo coinInfo, int quantity){
		this.coinInfo.add(coinInfo);
		this.quantity.add(quantity);		
	}
	
	void insertRecord(CoinInfo coinInfo, int quantity){
		this.coinInfo.add(coinInfo);
		this.quantity.add(quantity);
	}
}
