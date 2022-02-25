package e_oop;

public class AirconExample {
	final int MIN_TEMP = 18;
	final int MAX_TEMP = 30;			//	const와 같음, 상수, 이름을 모두 대문자로 만든다
	final String[] windArr = {"송풍", "미풍", "약풍", "강풍", "터보"};
	
	boolean power;
	int temperature = 24;
	int windIndex = 2;
	
	void power(){
		power = !power;
		System.out.println(power);
	}
	void tempUp(){
		if (power) {
			if (temperature < MAX_TEMP) {
				temperature++;
			}
			System.out.println("설정 온도 : " + temperature + "도");
		}
	}
	void tempDown(){
		if (power) {
			if (temperature > MIN_TEMP) {
				temperature--;
			}
			System.out.println("설정 온도 : " + temperature + "도");
		}
	}
	void wind(){
		if(power){
			windIndex++;
			windIndex %= 5;
		}
		System.out.println("바람 세기 : " + windArr[windIndex]);
	}
	public static void main(String[] args) {
		AirconExample aircon = new AirconExample();
		while(true){
			System.out.println("1.전원\t2.온도+\t3.온도-\t4.바람세기");
			int input = ScanUtil.nextInt();
			switch(input){
			case 1: 
				aircon.power();
				break;
			case 2: 
				aircon.tempUp();
				break;
			case 3: 
				aircon.tempDown();
				break;
			case 4: 
				aircon.wind();
				break;
			case 0: 
				System.exit(0);
				break;
			default :
				break;
			}
		}
	}
}
