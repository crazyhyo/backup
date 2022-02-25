package dealMeter;

public class Player extends Thread{
	private Monster mon;
	private String name;
	private boolean lastAttack;
	private int totalDamage;
	
	public Player(String name, Monster mon) {
		this.name = name;
		this.mon = mon;
		this.lastAttack = false;
		this.totalDamage = 0;
	}
	
	@Override
	public void run() {
		while(mon.isAlive()) {
			try {
				attack(mon);
				Thread.sleep((int)(Math.random() * 100) + 200);
//				Thread.sleep(200);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println(name + "이 가한 데미지 : " + totalDamage);
		
		if(lastAttack) {
			System.out.println(name + "이 몬스터를 처치했습니다.");
		}
	}
	
	private void attack(Monster mon) {
		System.out.println(name + "의 공격");
		
		int damage = (int) ((Math.random() * 0.6 + 0.7) * 100);
		
		totalDamage += damage;
		
		System.out.println(damage + "의 데미지");
		
		lastAttack = mon.getDamage(damage);
		
	}
}
