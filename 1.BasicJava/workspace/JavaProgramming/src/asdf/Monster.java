package asdf;

public class Monster {

	String name;		//이름
	int maxHP;			//최대 체력
	int maxMP;			//최대 마나
	int hp;				//체력
	int mp;				//마나
	int atk;			//공격력
	int def;			//방어력
//	int level;			//레벨
	Item[] items;		//보유아이템
	
	Monster(String name, int hp, int mp, int atk, int def, Item[] items) {
		this.name = name;
		this.maxHP = hp;
		this.maxMP = mp;
		this.hp = maxHP;
		this.mp = maxMP;
		this.atk = atk;
		this.def = def;
		this.items = items;
	}
	
	void attack(Character c){
		int damage = Math.max(atk - c.def,1);
		c.hp = Math.max(c.hp - damage, 0);
		System.out.println(name + "가 공격으로 " + c.name + "에게" + damage +"의 데미지를 주었습니다.");
		System.out.println(c.name + "의 남은 체력 : " + c.hp);
	}
	
	Item itemDrop(){
		return items[(int)(Math.random() * items.length)];
	}

	
}
