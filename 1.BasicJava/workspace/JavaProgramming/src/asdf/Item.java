package asdf;

public class Item {
	
	String name;		//이름
	int hp;				//체력
	int mp;				//마나
	int atk;			//공격력
	int def;			//방어력
	
	Item(String name, int hp, int mp, int atk, int def){
		this.name = name;
		this.hp = hp;
		this.mp = mp;
		this.atk = atk;
		this.def = def;
	}
	String itemInfo(){
		String info = name + " :";
		if(0< hp) info += " 체력+" + hp;
		if(0< mp) info += " 마나+" + mp;
		if(0< atk) info += " 공격+" + atk;
		if(0< def) info += " 방어+" + def;
		return info;
	}
}
