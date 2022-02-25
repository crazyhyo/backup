package g_oop2;

public abstract class Aniamal {

	abstract void sound(int a);
}

class Dog extends Aniamal{

	@Override
	void sound(int a) {
		System.out.println("asdf!!");
	}
	
}

class Cat extends Aniamal{

	@Override
	void sound(int a) {
		System.out.println("qwer!!");
	}
	
}
class Duck extends Aniamal{

	@Override
	void sound(int a) {
		System.out.println("zxcv!!");
	}
	
}