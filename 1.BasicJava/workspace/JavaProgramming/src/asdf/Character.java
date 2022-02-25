package asdf;

public class Character {

	String name;		//이름
	int maxHP;			//최대 체력
	int maxMP;			//최대 마나
	int hp;				//체력
	int mp;				//마나
	int atk;			//공격력
	int def;			//방어력
	int level;			//레벨
	int exp;			//경험치
	Item[] items;		//보유아이템
	
	Character(String name, int hp, int mp, int atk, int def){
		this.name = name;
		this.maxHP = hp;
		this.hp = this.maxHP;
		this.maxMP = mp;
		this.mp = this.maxMP;
		this.atk = atk;
		this.def = def;
		this.level = 1;
		this.exp = 0;
		this.items = new Item[10];
	}
	
	void showInfo(){
		System.out.println("============================================");
		System.out.println("------------------- 상 태 ---------------------");
		System.out.println("이름 : " + name);
		System.out.println("레벨 : " + level + "(" + exp + "/100)");
		System.out.println("체력 : " + hp + "/" + maxHP);
		System.out.println("마나 : " + mp + "/" + maxMP);
		System.out.println("공격 : " + atk);
		System.out.println("방어 : " + def);
		System.out.println("------------------ 아이템 --------------------");
		for(int i = 0; i < items.length; i++){
			if(items[i] != null){
				System.out.println(items[i].itemInfo());
			}
		}
		System.out.println("============================================");
	}
	
	void attack(Monster m){
		int damage = Math.max(atk - m.def,1);
		m.hp = Math.max(m.hp - damage, 0);
		System.out.println(name + "가 공격으로 " + m.name + "에게" + damage +"의 데미지를 주었습니다.");
		System.out.println(m.name + "의 남은 체력 : " + m.hp);
	}
	
	void getExp(int exp){
		System.out.println(exp + "의 경험치를 획득하였습니다.");
		this.exp += exp;
		while(this.exp > 100){
			levelUp();
			this.exp -=100;
		}
	}
	
	void levelUp(){
		level++;
		maxHP += 10;
		maxMP += 5;
		atk += 2;
		def += 2;
		hp = maxHP;
		mp = maxMP;
		System.out.println("LEVLE UP!!");
	}
	
	void getItem(Item item){
		System.out.println(item.name + "을 획득하였습니다.");
		for(int i = 0; i < items.length; i++){
			if(items[i] == null){
				items[i] = item;
				break;
			}
		}
		maxHP += item.hp;
		maxMP += item.mp;
		atk += item.atk;
		def += item.def;
		
	}
	
	
}
