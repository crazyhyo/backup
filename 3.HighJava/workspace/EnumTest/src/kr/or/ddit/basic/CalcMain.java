package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Arrays;

public class CalcMain {
	public static void main(String[] args) {
		Calculator plusCalc = Calculator.PLUS;
		Calculator minusCalc = Calculator.MINUS;
		Calculator productCalc = Calculator.PRODUCT;
		Calculator divideCalc = Calculator.DIVIDE;
		
		System.out.println(plusCalc.calc(2, 3));
		System.out.println(minusCalc.calc(2, 3));
		System.out.println(productCalc.calc(2, 3));
		System.out.println(divideCalc.calc(2, 3));
		
	}
}
