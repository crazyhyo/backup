package coingameIO;

import java.util.Scanner;
import java.util.Stack;

public class TestStackView {
	static Stack<View> viewStack = new Stack<View>();
	static Scanner sc = new Scanner(System.in);
	public static void main(String[] args) {
		View view = View.MAIN;
		viewStack.add(view);
		while(!viewStack.empty()) {
			System.out.println(view.name());
			switch(view) {
			case MAIN: break;
			case TRADE: break;
			case BUY: break;
			case SELL: break;
			case ACCOUNT: break;
			case BUY_BITCOIN: break;
			case BUY_RIPPLE: break;
			case BUY_DOGECOIN: break;
			case SELL_BITCOIN: break;
			case SELL_RIPPLE: break;
			case SELL_DOGECOIN: break;
			case CHART: break;
			case CHART_BITCOIN: break;
			case CHART_RIPPLE: break;
			case CHART_DOGECOIN: break;
			case CHART_NEWS: break;
			
			}
		}
	}
	
	public int printChoice(String...choices) {
		choices.
		return choices.length;
	}
	
	public  View main() {
		System.out.println("1.매매\t2.잔고\t3.차트\t4.다음날\t5.돌아가기");
		int input = 
		return 
	}
}

