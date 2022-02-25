package e_oop.restaurant;

import java.util.Arrays;

public class Boss {

	public static void main(String[] args) {

		Alba alba = new Alba();
		
		String[] order = alba.order();
		System.out.println(Arrays.toString(order));
		
		System.out.println("요리중 ... ");
		System.out.println("완성");
		String[] foods = {"완성된 짜장면", "완성된 탕수육"};
		alba.serving(foods);
		alba.pay(order);

	}

}
