package com.spring.sub;

public class MultiplyImpl implements Multiply{

	@Override
	public int multiply(int a, int b) {
		return a * b;
	}

	@Override
	public int multiply(int a, int b, int c) {
		return a * b * c;
	}

}
