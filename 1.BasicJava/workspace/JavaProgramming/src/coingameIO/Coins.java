package coingameIO;

import java.util.ArrayList;
import java.util.List;

public enum Coins {
	BitCoin(0),
	Ripple(1),
	DogeCoin(2);
	
	private final int NORMAL_PRICE[] = {2000, 200, 20};
	private final double ratio = 0.05;
	
	private String name;
	private List<Double> prices;
	private double collapse;
	private boolean alive;
	
	private double nextPrice(double currentPrice) {	// 현재 가격의 0.63배에서 1.37배까지 변동
		return currentPrice * (0.74 * Math.random() + 0.63);
	}
	
	public void update() {
		int size = prices.size();
		double currentPrice = prices.get(size - 1);
		double tomorrowPrice = nextPrice(nextPrice(currentPrice));	// 현재가격의 0.63배에서 1.37배 변동을 2회반복
		if(currentPrice < collapse) {	// 상장폐지 상태라면
			if(tomorrowPrice + tomorrowPrice * 0.4 > collapse) { // 상장폐지에서 빨리 벗어나기 위한 0.4배 가격 추가
				alive = true;			// 재상장
				System.out.println(name + "이 상장되었습니다.");
			}
			prices.add(tomorrowPrice + tomorrowPrice * 0.4);
		}else {
			prices.add(tomorrowPrice);
			if(tomorrowPrice < collapse) {
				alive = false;
				System.out.println(name + "이 상장폐지 되었습니다.");
			}
		}
	}
	public String getName() {
		return name;
	}
	
	public boolean IsAlive() {
		return alive;
	}
	
	public List<Double> getPrices(){
		return prices;
	}
	
	Coins(int type){
		prices = new ArrayList<Double>();
		prices.add(nextPrice(NORMAL_PRICE[type]));
		collapse = NORMAL_PRICE[type] * ratio;
		alive = true;
		switch(type) {
		case 0: name = "비트코인"; break;
		case 1: name = "리플"; break;
		case 2: name = "도지코인"; break;
		}
	}
	
	Coins(String name, List<Double> prices){
		this.name = name;
		this.prices = prices;
	}
}

