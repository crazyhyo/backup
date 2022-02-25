package play;

public class Coins {
	
	final int[] COLLAPSE = {200, 20, 2};
	String name;
	double price = 0;
	int typeIndex = 0;
	double variance = 0;
	boolean onMarket = true;

	Coins(int type){
		switch(type){
		case 0:
			typeIndex = type;
			name = "비트코인";	price = 2000;		variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		case 1:
			typeIndex = type;
			name = "리플";	price = 200;			variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		case 2:
			typeIndex = type;
			name = "도지코인";	price = 20;			variance = 0.37;
			price += ((Math.random() * price * 2) - price) * variance;
			break;
		}
	}


}
