package e_oop;

public class CoinGame {
	Ant ant;
	boolean quit = false;
	int days = 0;
	boolean success = false;
	
	CoinGame(Coins[] coins, Ant ant){
		this.ant = ant;
		this.ant.account.coins = coins;
	}
	
	void run(){
		ant.printAnt();
		ant.account.printAccount(ant.account.coins);
		days++;
		main : while (!quit && !success) {
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
							getPrice();
							break act;
						}
					}
					break;
				case "2":
					ant.printAnt();
					ant.account.printAccount(ant.account.coins);
					System.out.println("아무키나 눌러 메인화면으로 돌아가기");
					ScanUtil.nextLine();
					break;
				case "3":
					chart : while(true){
						chartTarget();					
						decision = ScanUtil.nextLine();
						switch (decision) {
						case "1":
							ant.account.coins[0].showCoinInfo();
							break;
						case "2":
							ant.account.coins[1].showCoinInfo();
							break;
						case "3":
							ant.account.coins[2].showCoinInfo();
							break;
						case "4":
							System.out.println("돌아가기");
							break chart;
						}
					}
					break;
				case "4":
					getPrice();
					break act;
				case "5":
					System.out.println("진행상황 :" + days + "일");
					ant.printAnt();
					ant.account.printAccount(ant.account.coins);
					System.out.println("게임을 종료합니다.");
					quit = true;
					break;
				}
			}
			if(success)		printSuccess();
		}
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
		for(int i = 0; i < 10; i++){
			Thread.sleep(300);
			for(int j = 0; j < 3; j++)	System.out.println();
		}
		}catch(Exception e){
			System.out.println(e);
		}
		System.out.println("\t\t\t\t***" + days + "일차***");
		printCoin();
		System.out.println("=============================================================================");
		System.out.println("1매매\t\t2잔고확인\t\t3차트확인\t\t4다음날\t\t5종료");
		System.out.println("=============================================================================");
		System.out.print("동작을 선택해주세요:");
	}
	void printCoin(){
		for(int i = 0; i < ant.account.coins.length; i++){
			ant.account.coins[i].printCoin();
		}
	}
	void printTrade(){
		System.out.println("\n1매수\t\t2매도\t\t3돌아가기\t\t4다음날");
		System.out.print("동작을 선택해주세요:");
	}
	
	void printTarget(){
		System.out.println("\n1비트코인\t\t2리플\t\t3도지코인\t\t4돌아가기");
		System.out.print("매매 대상을 선택해주세요:");
	}
	
	void chartTarget(){
		System.out.println("\n1비트코인\t\t2리플\t\t3도지코인\t\t4돌아가기");
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
		for(int i = 0; i < ant.account.coins.length; i++){
			ant.account.coins[i].price += ((Math.random() * (ant.account.coins[i].price * 2)) - ant.account.coins[i].price) * ant.account.coins[i].variance;
			ant.account.coins[i].printIsInMarket();
		}
		days++;
		for(int i = 0; i < ant.account.coins.length; i++){
			ant.account.coins[i].record(ant.account.coins[i].name, days);
		}
		success = ant.isSuccess();
	}
	
	void buy(){

		int quantity = 0;
		int qnt = 0;
		int calc = 0;
		buy : while(true){
			printTarget();
			String decision = ScanUtil.nextLine();
			switch (decision) {
			case "1":
				quantity = (int) (ant.balance / ant.account.coins[0].price);
				ant.account.coins[0].printCoin();
				if (!ant.account.coins[0].onMarket) {
					System.out.println("매매할 수 없습니다.");
					ant.account.quantity[0] = 0;
					break buy;
				}
				System.out.println("현재 매수하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[0].price;
				System.out.println(ant.account.coins[0].name + " " + qnt
						+ "개 구매 완료, 결재금액 : " + calc);
				ant.account.quantity[0] += qnt;
				ant.balance -= calc;
				break buy;
			case "2":
				quantity = (int) (ant.balance / ant.account.coins[1].price);
				ant.account.coins[1].printCoin();
				if (!ant.account.coins[1].onMarket) {
					System.out.println("매매할 수 없습니다.");
					ant.account.quantity[1] = 0;
					break buy;
				}
				System.out.println("현재 매수하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[1].price;
				System.out.println(ant.account.coins[1].name + " " + qnt
						+ "개 구매 완료, 결재금액 : " + calc);
				ant.account.quantity[1] += qnt;
				ant.balance -= calc;
				break buy;
			case "3":
				quantity = (int) (ant.balance / ant.account.coins[2].price);
				ant.account.coins[2].printCoin();
				if (!ant.account.coins[2].onMarket) {
					System.out.println("매매할 수 없습니다.");
					ant.account.quantity[2] = 0;
					break buy;
				}
				System.out.println("현재 매수하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[2].price;
				System.out.println(ant.account.coins[2].name + " " + qnt
						+ "개 구매 완료, 결재금액 : " + calc);
				ant.account.quantity[2] += qnt;
				ant.balance -= calc;
				break;
			case "4":
				System.out.println("돌아가기");
				break buy;
			}
		}
	}
	void sell(){
		int quantity = 0;
		int qnt = 0;
		int calc = 0;
		ant.account.printAccount(ant.account.coins);
		sell : while(true){
			printTarget();
			String decision = ScanUtil.nextLine();
			switch (decision) {
			case "1":
				ant.account.coins[0].printCoin();
				if (!ant.account.coins[0].onMarket) {
					System.out.println("매매할 수 없습니다.");
					break sell;
				}
				quantity = ant.account.quantity[0];
				System.out.println("현재 매도하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[0].price;
				System.out.println(ant.account.coins[0].name + " " + qnt
						+ "개 매도 완료, 결재금액 : " + calc);
				ant.account.quantity[0] -= qnt;
				ant.balance += calc;
				break sell;
			case "2":
				ant.account.coins[1].printCoin();
				if (!ant.account.coins[1].onMarket) {
					System.out.println("매매할 수 없습니다.");
					break sell;
				}
				quantity = ant.account.quantity[1];
				System.out.println("현재 매도하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[1].price;
				System.out.println(ant.account.coins[1].name + " " + qnt
						+ "개 매도 완료, 결재금액 : " + calc);
				ant.account.quantity[1] -= qnt;
				ant.balance += calc;
				break sell;
			case "3":
				ant.account.coins[2].printCoin();
				if (!ant.account.coins[2].onMarket) {
					System.out.println("매매할 수 없습니다.");
					break sell;
				}
				quantity = ant.account.quantity[2];
				System.out.println("현재 매도하실 수 있는 수량은 " + quantity + "입니다.");
				qnt = selectQuantity(quantity);
				calc = qnt * (int) ant.account.coins[2].price;
				System.out.println(ant.account.coins[2].name + " " + qnt
						+ "개 매도 완료, 결재금액 : " + calc);
				ant.account.quantity[2] -= qnt;
				ant.balance += calc;
				break sell;
			case "4":
				System.out.println("돌아가기");
				break sell;
			}
		}
	}


}
