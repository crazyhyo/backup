package kr.or.ddit.basic.ThreadGame;

public class Player{
	private String name;
	private int hp;
	private int atk;
	private int def;
	private boolean alive;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getHp() {
		return hp;
	}

	public void setHp(int hp) {
		this.hp = hp;
	}

	public int getAtk() {
		return atk;
	}

	public void setAtk(int atk) {
		this.atk = atk;
	}

	public int getDef() {
		return def;
	}

	public void setDef(int def) {
		this.def = def;
	}

	public boolean isAlive() {
		return alive;
	}

	public void setAlive(boolean alive) {
		this.alive = alive;
	}

	public Player(String name) {
		this.name = name;
		this.hp = 5000;
		this.atk = 1500;
		this.def = 500;
		this.alive = true;
	}
	
	public synchronized void Attack(Player player) {
		System.out.println(name + "의 공격!");
		int trueDamage = (int)((atk - player.def) * (Math.random() * 0.6 + 0.7));
		
		System.out.println(trueDamage + "의 데미지!");
		
		if(player.hp - trueDamage > 0) {
			player.hp -= trueDamage;
		}else {
			player.alive = false;
			player.hp = 0;
			System.out.println("경험치를 얻었습니다.");
		}
		
	}
	
	@Override
	public String toString() {
		return "이름 : " + name + "\nhp : " + hp + "\natk : " + atk + "\ndef : " + def;
	}
	
}
