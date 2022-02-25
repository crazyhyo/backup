package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class BaseBall {
	public static void main(String[] args) {
		new BaseBall().start();
	}

	private void start() {
		Set<Integer> rndNum = new HashSet<Integer>();
		int input = 0;
		int ball = 0;
		int strike = 0;
		int count = 0;
		
		while(rndNum.size() < 3) {
			int num = (int) (Math.random() * 9 + 1);
			rndNum.add(num);
		}
		
		List<Integer> ansNum = new ArrayList<Integer>(rndNum);
		
		Collections.shuffle(ansNum);
		
		System.out.println(ansNum);
		
		while(true) {
			count++;
			ball = 0;
			strike = 0;
			System.out.print("세자리 숫자입력 : ");
			input = ScanUtil.nextInt();
			
			strike = getStrike(ansNum, input);
			ball = getBall(ansNum, input);
			
			if(strike == 3) {
				System.out.println(count + "번째 만에 맞췄군요.");
				break;
			}else {
				System.out.println(strike + "S " + ball + "B");
			}
				
		}
		
	}

	private int getBall(List<Integer> ansNum, int input) {
		int num3 = input % 10;
		int num2 = (input / 10) % 10;
		int num1 = (input / 100) % 10;
		
		int res = 0;
		
		if(ansNum.get(0) == num2 || ansNum.get(0) == num3) res++; 
		if(ansNum.get(1) == num1 || ansNum.get(1) == num3) res++; 
		if(ansNum.get(2) == num1 || ansNum.get(2) == num2) res++; 
		
		return res;
	}

	private int getStrike(List<Integer> ansNum, int input) {
		int num3 = input % 10;
		int num2 = (input / 10) % 10;
		int num1 = (input / 100) % 10;
		
		int res = 0;
		
		if(ansNum.get(0) == num1) res++; 
		if(ansNum.get(1) == num2) res++; 
		if(ansNum.get(2) == num3) res++; 
		
		return res;
	}
}
