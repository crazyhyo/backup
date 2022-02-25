package e_oop;

public class Calculator {
	double plus(double a, double b){
		return a + b;
	}
	double minus(double a, double b){
		return a - b;
	}
	double product(double a, double b){
		return a * b;
	}
	double divide(double a, double b){
		if(b != 0)		return a / b;
		else{
			System.out.println("0으로 나눌 수 없습니다.");
			return -65536;
		}
	}
	double remainder(double a, double b){
		return a % b;
	}
}
