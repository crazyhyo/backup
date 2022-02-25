package e_oop;

public class Ant {
	String name;
	int balance;
	Account account;
	int myasset = 0;
	int goal;
	double ratio;
	
	Ant(String name, Coins[] coins, int goal){
		this.name = name;
		Account temp = new Account(coins, name);
		this.account = temp;
		this.balance = 50000;
		this.goal = goal;
	}
	void printAnt(){
		myAsset();
		System.out.println();
		System.out.println("<<<<현재 총 자산 : " + myasset + ">>>>\t\t\t달성률: " +  String.format("%.2f", ratio) + "%");
		System.out.println("=============================================================================");
		System.out.println("이름 : " + name + "\t\t보유금액 : " + balance + "\t\t목표금액 : " + goal);
		System.out.println("=============================================================================");
	}
	void myAsset(){
		myasset = 0;
		myasset = balance + account.getTotal();
		ratio = (double) myasset / goal * 100;
	}
	boolean isSuccess(){
		if(myasset >= goal){
			System.out.println("실행됨");
			return true;
		}
		else{
			return false;
		}
	}
}
