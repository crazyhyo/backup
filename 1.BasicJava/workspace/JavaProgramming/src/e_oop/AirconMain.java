package e_oop;

public class AirconMain {

	public static void main(String[] args) {
		AirConditioner air = new AirConditioner();
		
		if(!air.power)	air.toggle();
		air.run();
	}

}
