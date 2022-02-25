package asdf;

public class CoinGame {
	Ant ant;
	boolean quit = false;
	int days = 0;
	boolean success = false;
	Market market;
	News news;
	
	CoinGame(){
		this.market = new Market();
		printGameStart();
		System.out.println("이름을 입력해주세요.");
		String name = ScanUtil.nextLine();
		Ant ant = new Ant(name, market.coins, 0);
		this.ant = ant;
		this.news = new News();
	}
	
	void run(){
		setDifficulty();
		ant.printAnt(market.coins);
		ant.account.printAccount(market.coins);
		days++;
		while (!quit && !success) {
			act : while(true){
			printMain();
			String decision = ScanUtil.nextLine();
				switch(decision){
				case "1":
					trade : while(true){
						printTrade();
						decision = ScanUtil.nextLine();
						switch (decision) {
						case "1":
							buy();
							break;
						case "2":
							sell();
							break;
						case "3":
							System.out.println("돌아가기");
							break trade;
						case "4":
							update();
							break act;
						}
					}
					break;
				case "2":
					ant.printAnt(market.coins);
					ant.account.printAccount(market.coins);
					System.out.println("아무키나 눌러 메인화면으로 돌아가기");
					ScanUtil.nextLine();
					break;
				case "3":
					chart : while(true){
						printChartTarget();					
						decision = ScanUtil.nextLine();
						switch (decision) {
						case "1":
							market.showCoinInfo(0);
							break;
						case "2":
							market.showCoinInfo(1);
							break;
						case "3":
							market.showCoinInfo(2);
							break;
						case "4":
							printNews();
							break;
						case "5":
							System.out.println("돌아가기");
							break chart;
						}
					}
					break;
				case "4":
					update();
					break act;
				case "5":
					System.out.println("진행상황 :" + days + "일");
					ant.printAnt(market.coins);
					ant.account.printAccount(market.coins);
					System.out.println("게임을 종료합니다.");
					quit = true;
					break act;
				}
			}
			if(success)		printSuccess();
		}
	}
	
	void printNews(){
		double sumRatio = 0;
		String output = "다시 볼 수 없습니다.";
		for(int i = 0; i < market.coins.length; i++){
			sumRatio += market.differences.get(days * 3 - 3 + i) / market.information.get(days * 3 - 3 + i).price * 100;
		}
		if(news.accessNews)
			output = news.pickNews(sumRatio);
		System.out.println(output);
	}
	void printSuccess(){
		System.out.println();
		System.out.println("=============================================================================");
		System.out.println("\t\t\t\t승         리");
		System.out.println("=============================================================================");
		System.out.println("                                       일차 :" + days + "일");
	}
	void printMain(){
		try{
			for(int i = 0; i < 5; i++){
				Thread.sleep(300);
				System.out.println("\n\n\n\n\n\n");
			}
		}catch(Exception e){
			System.out.println(e);
		}
		System.out.println("\t\t\t\t***" + days + "일차***");
		printCoin();
		System.out.println("=============================================================================");
		System.out.println("1매매\t\t2계좌확인\t\t3차트소식\t\t4다음날\t\t5종료");
		System.out.println("=============================================================================");
		System.out.print("동작을 선택해주세요:");
	}
	void printCoin(){
		for(int i = 0; i < market.coins.length; i++){
			market.printCoin(i);
			if(market.coins[i].onMarket){
				if(days == 1)
					System.out.println();
				else if(!market.information.get(days * 3 - 6 + i).onMarket)
					System.out.println();
				else if(market.coins[i].onMarket) {
					System.out.print("\t("+String.format("%.2f",market.differences.get(days * 3 - 6 + i)));
					System.out.println("/"+String.format("%.2f",(market.differences.get(days * 3 - 6 + i) / market.information.get(days * 3 - 6 + i).price * 100))+"%)");
				}
			}
		}
	}
	void printGameStart(){
		System.out.println("=============================================================================");
		System.out.println("=============================================================================");
		
		System.out.println("\n\n\n");
		System.out.println("\t\t\t\t  Fire Ant");
		System.out.println("\n\n\n");
		
		System.out.println("=============================================================================");
		System.out.println("=============================================================================");
		System.out.println("\t\t코인거래를 통해 목표금액을 달성하는 게임입니다");
		System.out.println("\t\t코인의 가격이 너무 낮아지면 상장폐지 될 수 있으니 주의하세요");
		System.out.println("\t\t그럼 게임을 시작합니다\n\n");
	}
	void printTrade(){
		System.out.println("\n1매수\t\t2매도\t\t3돌아가기\t\t4다음날");
		System.out.print("동작을 선택해주세요:");
	}
	
	void printTarget(){
		System.out.println("\n1비트코인\t\t2리플\t\t3도지코인\t\t4돌아가기");
		System.out.print("매매 대상을 선택해주세요:");
	}
	
	void printChartTarget(){
		System.out.println("\n1비트코인\t\t2리플\t\t3도지코인\t\t4뉴스보기\t\t5돌아가기");
		System.out.print("차트를 볼 코인을 선택해주세요:");
	}
	
	int selectQuantity(int quantity){
		System.out.print("매매수량을 선택해주세요 : ");
		int decision = ScanUtil.nextInt();
		while(decision < 0 || decision > quantity){
			System.out.println("매매할 수 없는 수량입니다. 다시 선택해주세요.");
			System.out.print("매매수량을 선택해주세요 : ");
			decision = ScanUtil.nextInt();
		}
		System.out.println();
		return decision; 
	}
	
	void getPrice(){
		
		for(int i = 0; i < market.coins.length; i++){
			Coins tempCoin = new Coins(market.nextCoins[i]);
			market.nextCoins[i].price += ((Math.random() * market.nextCoins[i].price * 2) - market.nextCoins[i].price) * market.nextCoins[i].variance;
			market.nextCoins[i].price += ((Math.random() * market.nextCoins[i].price * 2) - market.nextCoins[i].price) * market.nextCoins[i].variance;
			market.nextCoins[i].price += ((Math.random() * market.nextCoins[i].price * 2) - market.nextCoins[i].price) * market.nextCoins[i].variance;
			market.nextCoins[i].price += ((Math.random() * market.nextCoins[i].price * 2) - market.nextCoins[i].price) * market.nextCoins[i].variance;
			if(!market.nextCoins[i].onMarket)		market.nextCoins[i].price += market.nextCoins[i].COLLAPSE[i] * 0.3;
			market.record(market.nextCoins[i].name, market.nextCoins[i].price, days + 2, market.nextCoins[i].onMarket);
			market.coins[i] = tempCoin;
			market.printIsInMarket(i, days + 1);
			if(!market.coins[i].onMarket){
				ant.account.tradeRecord.add(new TradeRecord(new CoinInfo(market.coins[i].name, market.coins[i].price, days, market.coins[i].onMarket),-ant.account.quantity[i]));
				ant.account.quantity[i] = 0;
			}
		}
	}
	void update(){
		getPrice();
		days++;
		news.accessNews = true;
		market.recordDiff();
		success = ant.isSuccess();
	}
//	void printInformation() {
//		
//		for(CoinInfo temp : market.information) {
//			System.out.print(temp.date + "\t");
//			System.out.print(temp.name + "\t");
//			System.out.println(temp.price);
//		}
//	}
//	void printDiff() {
//		
//		for(Double tempd : market.differences) {
//			System.out.println(market.differences.indexOf(tempd));
//			System.out.println(tempd);
//		}
//	}
	void setDifficulty() {
		boolean flag = true;
		while(flag){
			System.out.println("1쉬움\t\t2보통\t\t3어려움");
			System.out.println("난이도를 선택해주세요.");
			String goal = ScanUtil.nextLine();
			switch(goal){
			case "1":
				ant.goal = 100000;
				ant.account = new Account(market.coins, ant.name);
				for(int i = 0; i < market.coins.length; i++) market.coins[i].variance = 0.27;
				flag = false;
				break;
			case "2":
				ant.goal = 500000;
				ant.account = new Account(market.coins, ant.name);
				for(int i = 0; i < market.coins.length; i++) market.coins[i].variance = 0.47;
				flag = false;
				break;
			case "3":
				ant.goal = 1000000;
				ant.account = new Account(market.coins, ant.name);
				for(int i = 0; i < market.coins.length; i++) market.coins[i].variance = 0.67;
				flag = false;
				break;
			}
		}
	}
	boolean buyCoin(int i){
		int quantity = 0;
		int qnt = 0;
		int calc = 0;
		quantity = (int) (ant.balance / market.coins[i].price);
		market.printCoin(i);
		System.out.println();
		if (!market.coins[i].onMarket) {
			System.out.println("매매할 수 없습니다.");
			ant.account.quantity[0] = 0;
			return false;
		}
		System.out.println("현재 매수하실 수 있는 수량은 " + quantity + "입니다.");
		qnt = selectQuantity(quantity);
		calc = qnt * (int) market.coins[i].price;
		System.out.println(market.coins[i].name + " " + qnt
				+ "개 구매 완료, 결재금액 : " + calc);
		ant.account.tradeRecord.add(new TradeRecord(new CoinInfo(market.coins[i].name, market.coins[i].price, days, market.coins[i].onMarket),qnt));
		ant.account.quantity[i] += qnt;
		ant.balance -= calc;
		return true;
	}
	boolean sellCoin(int i){
		int quantity = 0;
		int qnt = 0;
		int calc = 0;
		market.printCoin(i);
		System.out.println();
		if (!market.coins[i].onMarket) {
			System.out.println("매매할 수 없습니다.");
			return false;
		}
		quantity = ant.account.quantity[i];
		System.out.println("현재 매도하실 수 있는 수량은 " + quantity + "입니다.");
		qnt = selectQuantity(quantity);
		calc = qnt * (int) market.coins[i].price;
		System.out.println(market.coins[i].name + " " + qnt
				+ "개 매도 완료, 결재금액 : " + calc);
		ant.account.tradeRecord.add(new TradeRecord(new CoinInfo(market.coins[i].name, market.coins[i].price, days, market.coins[i].onMarket),-qnt));
		ant.account.quantity[i] -= qnt;
		ant.balance += calc;
		return true;
	}
	
	void buy(){
		buy : while(true){
			printTarget();
			String decision = ScanUtil.nextLine();
			switch (decision) {
			case "1":
				buyCoin(0);
				break buy;
			case "2":
				buyCoin(1);
				break buy;
			case "3":
				buyCoin(2);
				break;
			case "4":
				System.out.println("돌아가기");
				break buy;
			}
		}
	}
	void sell(){
		ant.account.printAccount(market.coins);
		sell : while(true){
			printTarget();
			String decision = ScanUtil.nextLine();
			switch (decision) {
			case "1":
				sellCoin(0);
				break sell;
			case "2":
				sellCoin(1);
				break sell;
			case "3":
				sellCoin(2);
				break sell;
			case "4":
				System.out.println("돌아가기");
				break sell;
			}
		}
	}
}
