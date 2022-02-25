package kr.or.ddit.basic;

public enum Calculator {
	PLUS{
		double calc(double a, double b){ return a + b; }
	},
	MINUS{
		double calc(double a, double b) { return a - b;	}
	},
	PRODUCT{
		double calc(double a, double b) { return a * b;	}
	},
	DIVIDE{
		double calc(double a, double b) { return a / b;	}
	};
	
	abstract double calc(double a, double b);
	
}