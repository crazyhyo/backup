package com.spring.exe;

import com.spring.main.Calculator;
import com.spring.sub.Divide;
import com.spring.sub.DivideImpl;
import com.spring.sub.Minus;
import com.spring.sub.MinusImpl;
import com.spring.sub.Multiply;
import com.spring.sub.MultiplyImpl;
import com.spring.sub.Summation;
import com.spring.sub.SummationImpl;

public class Main {

	private Calculator cal = new Calculator();
	
	{
		Summation summation = new SummationImpl();
		Minus minus = new MinusImpl();
		Multiply multiply = new MultiplyImpl();
		Divide divide = new DivideImpl();
		
		cal.setDivide(divide);
		cal.setMinus(minus);
		cal.setMultiply(multiply);
		cal.setSummation(summation);
	}
	
	public static void main(String[] args) {
		
		Main main = new Main();
		int a = 4 , b = 2, c = 1;
		
		System.out.println(main.cal.sum(a,b));
		System.out.println(main.cal.minus(a,b));
		System.out.println(main.cal.multiply(a,b));
		System.out.println(main.cal.divide(a,b));
		
		
	}
}
