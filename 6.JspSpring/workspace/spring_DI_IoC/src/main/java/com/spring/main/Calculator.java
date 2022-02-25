package com.spring.main;

import com.spring.sub.Divide;
import com.spring.sub.Minus;
import com.spring.sub.Multiply;
import com.spring.sub.Summation;

public class Calculator {

	private Summation summation;
	private Minus minus;
	private Multiply multiply;
	private Divide divide;
	
	public void setSummation(Summation summation) {
		this.summation = summation;
	}
	public void setMinus(Minus minus) {
		this.minus = minus;
	}
	public void setMultiply(Multiply multiply) {
		this.multiply = multiply;
	}
	public void setDivide(Divide divide) {
		this.divide = divide;
	}
	
	public int sum(int a, int b) {
		return summation.sum(a, b);
	}
	public int sum(int a, int b, int c) {
		return summation.sum(a, b, c);
	}

	public int minus(int a, int b) {
		return minus.minus(a, b);
	}
	
	public int minus(int a, int b, int c) {
		return minus.minus(a, b, c);
	}
	
	public int multiply(int a, int b) {
		return multiply.multiply(a, b);
	}
	
	public int multiply(int a, int b, int c) {
		return multiply.multiply(a, b, c);
	}
	
	public int divide(int a, int b) {
		return divide.divide(a, b);
	}
	
	public int divide(int a, int b, int c) {
		return divide.divide(a, b, c);
	}
}
