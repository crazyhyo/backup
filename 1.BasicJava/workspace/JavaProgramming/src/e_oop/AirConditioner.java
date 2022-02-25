package e_oop;

public class AirConditioner {
	
	boolean power;
	double currentTemperature = (int)(Math.random() * 10) + 18;
	double goalTemperature = currentTemperature;
	int currentWind = 2;

	void toggle(){
		if(power)
			System.out.println("작동을 종료합니다.");
		power = !power;
		if(power){
			System.out.println("작동을 시작합니다.");
			currentTemperature = (int)(Math.random() * 10) + 18;
			goalTemperature = currentTemperature;
		}
	}
//	void getTemperature(){
//		currentTemperature = (int)(Math.random() * 10) + 25;
//	}
	void downButton(){
		if(goalTemperature > 18)
			goalTemperature--;	
	}
	void upButton(){
		if(goalTemperature < 28)
			goalTemperature++;
	}
	void upWind(){
		if(currentWind < 3)
			currentWind++;
	}
	void downWind(){
		if(currentWind > 1)
			currentWind--;
	}
	void run(){
		while(power){
			
			printMain();
			String decision = ScanUtil.nextLine();
			if(decision.equals("q")) toggle();
			else if(decision.equals("w")){
				while(true){
					printGoal();
					decision = ScanUtil.nextLine();
					if(decision.equals("q")){
						System.out.println("목표온도로 운전을 실행합니다.");
						operation();
						break;
					}else if(decision.equals("w")){
						upButton();
						
					}else if(decision.equals("e")){
						downButton();
					}
				}
			}else if(decision.equals("e")){
				while(true){
					printGoalWind();
					decision = ScanUtil.nextLine();
					if(decision.equals("q")){
						System.out.println("목표바람세기로 운전을 실행합니다.");
						break;
					}else if(decision.equals("w")){
						upWind();
						
					}else if(decision.equals("e")){
						downWind();
					}
				}
			}
		}
	}
	void operation(){
		while(currentTemperature != goalTemperature){
			if(currentTemperature > goalTemperature)	coolDown();
			else										heatUp();
		}
		printCurrentTemperature();
		System.out.println("목표온도에 도달했습니다.");
	}
	void coolDown(){
		if(currentWind == 2){
			printCurrentTemperature();
			System.out.println("냉방을 실행합니다.");
			currentTemperature = currentTemperature - 1;
		}else if(currentWind == 1){
			printCurrentTemperature();
			System.out.println("냉방을 실행합니다.");
			currentTemperature = currentTemperature - 0.5;
		}else if(currentWind == 3){
			printCurrentTemperature();
			System.out.println("냉방을 실행합니다.");
			if(currentTemperature - 2 >= goalTemperature)
				currentTemperature = currentTemperature - 2;
			else currentTemperature = goalTemperature;
		}
	}
	void heatUp(){
		if(currentWind == 2){
			printCurrentTemperature();
			System.out.println("난방을 실행합니다.");
			currentTemperature = currentTemperature + 1;
		}else if(currentWind == 1){
			printCurrentTemperature();
			System.out.println("난방을 실행합니다.");
			currentTemperature = currentTemperature + 0.5;
		}else if(currentWind == 3){
			printCurrentTemperature();
			System.out.println("난방을 실행합니다.");
			if(currentTemperature + 2 <= goalTemperature)
				currentTemperature = currentTemperature + 2;
			else currentTemperature = goalTemperature;
		}
	}
	void printMain(){
		System.out.println("q:전원\tw:목표온도 설정\te:바람세기 설정");
		System.out.print("동작을 선택해주세요:");
	}
	void printGoal(){
		System.out.println("q:목표온도 설정완료\tw:목표온도 증가\te:목표온도 감소");
		printCurrentTemperature();
		System.out.println("현재 목표온도는 " + goalTemperature + "도 입니다.");
	}
	void printCurrentTemperature(){
		System.out.println("현재 온도는 " + currentTemperature + "입니다");
	}
	void printGoalWind(){
		System.out.println("q:바람세기 설정완료\tw:바람세기 증가\te:바람세기 감소");
		printWind();
		System.out.println("바람세기를 선택해주세요.");
	}
	void printWind(){
		String wind = "";
		switch(currentWind){
		case 1: wind = "약"; break;
		case 2: wind = "중"; break;
		case 3: wind = "강"; break;
		}
		System.out.println("현재 바람세기는 " + wind +"입니다.");
	}
}
