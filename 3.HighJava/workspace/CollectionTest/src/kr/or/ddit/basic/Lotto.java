package kr.or.ddit.basic;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class Lotto {
	
	public static void main(String[] args) {
		
		new Lotto().start();
		
	}
	
	public void start() {
		int input = 0;
		
		while(true) {
			printMain();
			System.out.print("메뉴선택 : ");
			input = ScanUtil.nextInt();
			switch(input) {
			case 1: buyLotto(); break;
			case 2:
				System.out.println("\n감사합니다.\n");
				System.exit(0);
			default :
				System.out.println("<유효하지 않은 입력값입니다.>");
				continue;
			}
		}
		
	}
	
	private void buyLotto() {
		int input = 0;
		while(true) {
			printBuyLotto();
			System.out.print("금액 입력 : ");
			input = ScanUtil.nextInt();
			
			if(input < 0) {
				System.out.println("금액은 음수가 될 수 없습니다.");
			}else if(input < 1000) {
				System.out.println("금액이 부족합니다.");
			}else {
				System.out.println("행운의 로또번호는 아래와 같습니다.");
				for(int i = 0; i < input / 1000; i ++) {
					Set<Integer> lotto = setLotto();
					System.out.println("로또번호" + (i + 1) + " : " + stringLottoNum(lotto));
				}
				System.out.println("\n받은 금액은 " + input + "원이고 거스름돈은 "
						+ input % 1000 + "원입니다.\n");
				break;
			}
			
		}
		
	}

	private HashSet<Integer> setLotto() {
		HashSet<Integer> lottoSet = new HashSet<Integer>();
		while(lottoSet.size() < 6) {
			int num = (int) (Math.random() * 45 + 1);
			lottoSet.add(num);
		}
		return lottoSet;
	}

	private void printBuyLotto() {
		System.out.println("\nLotto 구입 시작");
		System.out.println("\n(1000원에 로또번호 하나입니다.)");
	}

	private void printMain() {
		System.out.println();
		System.out.println("==========================");
		System.out.println("Lotto 프로그램");
		System.out.println("--------------------------");
		System.out.println("1. Lotto 구입");
		System.out.println("2. 프로그램 종료");
		System.out.println("==========================");
	}
	
	private String stringLottoNum(Set<Integer> lottoNum) {
		Iterator it = lottoNum.iterator();
//		String tmp = "";
		String tmp = "";
		while(it.hasNext()) {
			tmp += it.next() + " ";
//			tmp += it.next() + ",";
		}
//		return tmp.substring(0, tmp.length()-1);
		return tmp;
	}
}
