package g_oop2;



public class Starcraft {
	
	public static void main(String[] args) {
		Marine marine = new Marine();
		Tank tank = new Tank();
		Dropship dropship = new Dropship();
		SCV scv = new SCV();
		
//		scv.repair(marine);
		scv.repair(tank);
		scv.repair(dropship);
		scv.repair(scv);
		
		System.out.println(SampleInterface.NUM1);
		//interface의 멤버변수는 static이 붙어있기 때문에 interface명.상수 로 접근을 하는 것이 바람직하다
		//interface는 interface를 상속받을 수 있지만 class는 상속받을 수 없다.
		//interface와 추상클래스는 리턴타입이 될 수 있다. 그러나 이러한 경우 작성자의 의도는
		//이를 상속받는 자식으로 리턴하는 것이다.
	}
	
}

class Unit{
	int hp;
	final int MAX_HP;
	
	Unit(int hp){
		MAX_HP = hp;
		this.hp = MAX_HP;
	}
}

class Marine extends Unit{
	Marine(){
		super(40);
	}
}

class Tank extends Unit implements Repairable{
	Tank() {
		super(150);
	}
}

class Dropship extends Unit implements Repairable{
	Dropship() {
		super(125);
	}
}

class SCV extends Unit implements Repairable{
	SCV() {
		super(60);
	}
	
	void repair(Repairable r){	//Tank와 Dropship만이 공유하는 타입이 없다
		if (r instanceof Unit) {	//Unit으로 형변환이 가능한지 확인
			Unit u = (Unit) r;

			while (u.hp < u.MAX_HP) {
				u.hp++;
			}
		}
	}
}

interface Repairable{
	
}