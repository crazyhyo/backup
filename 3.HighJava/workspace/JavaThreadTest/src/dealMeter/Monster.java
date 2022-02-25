package dealMeter;

public class Monster {
	private volatile int hp;
	private volatile boolean alive;
//	private int hp;
//	private boolean alive;
	
	public Monster(int hp) {
		this.hp = hp;
		alive = true;
	}
	
//	public synchronized boolean getDamage(int damage) {
	public boolean getDamage(int damage) {
		
		if(hp - damage > 0) {
			System.out.println("몬스터는 " + damage + "의 데미지를 받았다");
			hp -= damage;
			System.out.println("남은 체력 : " + hp);
		}else {
			System.out.println("몬스터 처치됨");
			hp = 0;
			alive = false;
			return true;
		}
//		notifyAll();
//		try {
//			if(alive) {
//				wait();
//			}else {
//				notifyAll();
//			}
//		} catch (InterruptedException e) {
//			e.printStackTrace();
//		}
		return false;
	}
	
	public boolean isAlive() {
		return alive;
	}
}
