package asdf;

public class Coins {
	
	final int[] COLLAPSE = {200, 20, 2};
	String name;
	double price = 0;
	int typeIndex = 0;
	double variance = 0;
	boolean onMarket = true;
	
	
	
	public Coins(String name, int typeIndex) {
		this.name = name;
		this.variance = 0.37;
		this.typeIndex = typeIndex;
	}

	
	
	public Coins(Coins coins) {
		this.name = coins.name;
		this.price = coins.price;
		this.typeIndex = coins.typeIndex;
		this.variance = coins.variance;
		this.onMarket = coins.onMarket;
	}



	Coins(int typeIndex){
		switch(typeIndex){
		case 0:
			this.typeIndex = typeIndex;
			name = "비트코인";	price = 2000;		variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		case 1:
			this.typeIndex = typeIndex;
			name = "리플  ";	price = 200;			variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		case 2:
			this.typeIndex = typeIndex;
			name = "도지코인";	price = 20;			variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		}
	}


}
