package com.spring.sub;

public class MultiplyImpl2 extends MultiplyImpl{
	
	@Override
	public int multiply(int a, int b) {
		return super.multiply(a, b) * 10;
	}
	
	@Override
	public int multiply(int a, int b, int c) {
		return super.multiply(a, b, c) * 10;
	}

}
