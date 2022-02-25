package c_statement;

import java.util.Scanner;

public class SelfTest {

	public static void main(String[] args) {
		/*
		 * '탄수화물 중독' 자가진단하기
		 * 1. 아침을 배불리 먹은 후 점심시간 전에 배가 고프다.
		 * 2. 밥, 빵 과자 등의 음식을 먹기 시작하면 끝이 없다.\n
		 * 3. 음식을 금방 먹은 후에도 만족스럽지 못하고 더 먹는다.\n
		 * 4. 정말 배가 고프지 않더라도 먹을 때가 있다.\n
		 * 5. 저녁을 먹고 간식을 먹지 않으면 잠이 오지 않는다.\n
		 * 6. 스트레스를 받으면 자꾸 먹고 싶어진다.\n
		 * 7. 책상이나 식탁 위에 항상 과자, 초콜릿 등이 놓여있다.\n
		 * 8. 오후 5시가 되면 피곤함과 배고픔을 느끼고 일이 손에 안 잡힌다.\n
		 * 9. 과자, 초콜릿 등의 단 음식은 상상만 해도 먹고 싶어진다.\n
		 * 10. 다이어트를 위해 식이조절을 하는 데 3일도 못 같다.\n
		 * 
		 * 3개: 주의! 위험한 수준은 아니지만 관리가 필요함.
		 * 4~6개: 위험! 탄수화물 섭취를 줄이기 위한 식습관 개선이 필요함.
		 * 7개 이상: 중독! 전문의 상담이 필요함.
		 */
		
		/*Scanner sc = new Scanner(System.in);
		int selfTest;
		
		System.out.println("'탄수화물 중독' 자가진단을 시작합니다.\n\n");
		System.out.println("==========================================");
		System.out.println("'탄수화물 중독' 자가진단하기\n"
				+ "1. 아침을 배불리 먹은 후 점심시간 전에 배가 고프다.\n"
				+ "2. 밥, 빵 과자 등의 음식을 먹기 시작하면 끝이 없다.\n"
				+ "3. 음식을 금방 먹은 후에도 만족스럽지 못하고 더 먹는다.\n"
				+ "4. 정말 배가 고프지 않더라도 먹을 때가 있다.\n"
				+ "5. 저녁을 먹고 간식을 먹지 않으면 잠이 오지 않는다.\n"
				+ "6. 스트레스를 받으면 자꾸 먹고 싶어진다.\n"
				+ "7. 책상이나 식탁 위에 항상 과자, 초콜릿 등이 놓여있다.\n"
				+ "8. 오후 5시가 되면 피곤함과 배고픔을 느끼고 일이 손에 안 잡힌다.\n"
				+ "9. 과자, 초콜릿 등의 단 음식은 상상만 해도 먹고 싶어진다.\n"
				+ "10. 다이어트를 위해 식이조절을 하는 데 3일도 못 같다.");
		System.out.println("==========================================");
		
		System.out.print("위의 보기 중 해당하는 개수를 써 주세요: ");
		selfTest = Integer.parseInt(sc.nextLine());
		
		switch (selfTest){
		case 0: case 1:	case 2:
			System.out.println("2개 이하 : 안전!");	break;
		case 3:
			System.out.println("3개: 주의! 위험한 수준은 아니지만 관리가 필요함.");	break;
		case 4:	case 5: case 6:
			System.out.println("4~6개: 위험! 탄수화물 섭취를 줄이기 위한 식습관 개선이 필요함.");	break;
		case 7: case 8: case 9: case 10:
			System.out.println("7개 이상: 중독! 전문의 상담이 필요함.");	break;
		default :
			System.out.println("오류: 0에서 10까지의 숫자를 입력해주세요."); break;
		}*/
		
		/*Scanner sc2 = new Scanner(System.in);
		int selfTest2 = 0;
		int numOfNo=0;
		int flag=0;
		String ans = null;
		
		System.out.println("'탄수화물 중독' 자가진단을 시작합니다.\n\n");
		System.out.println("==========================================");
		System.out.println("'탄수화물 중독' 자가진단하기");
		System.out.println("1. 아침을 배불리 먹은 후 점심시간 전에 배가 고프다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("2. 밥, 빵 과자 등의 음식을 먹기 시작하면 끝이 없다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("3. 음식을 금방 먹은 후에도 만족스럽지 못하고 더 먹는다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("4. 정말 배가 고프지 않더라도 먹을 때가 있다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("5. 아침을 배불리 먹은 후 점심시간 전에 배가 고프다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("6. 스트레스를 받으면 자꾸 먹고 싶어진다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("7. 책상이나 식탁 위에 항상 과자, 초콜릿 등이 놓여있다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("8. 오후 5시가 되면 피곤함과 배고픔을 느끼고 일이 손에 안 잡힌다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("9. 과자, 초콜릿 등의 단 음식은 상상만 해도 먹고 싶어진다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("10. 다이어트를 위해 식이조절을 하는 데 3일도 못 같다. (y/n)");
		ans = sc2.nextLine();
		if (ans.toLowerCase().equals("y"))	selfTest2 += 1;
		else if(ans.toLowerCase().equals("n"))	numOfNo += 1;
		else	flag += 1;
		System.out.println("==========================================");
		if(flag != 0){
			System.out.println("오류: 유효하지 않은 문자 입력.");
		}
		else{
			if(selfTest2 < 3){
				System.out.println("2개 이하 : 안전!");
			}else if(selfTest2 == 3){
				System.out.println("3개: 주의! 위험한 수준은 아니지만 관리가 필요함.");
			}else if(selfTest2 > 3 && selfTest2 < 7){
				System.out.println("4~6개: 위험! 탄수화물 섭취를 줄이기 위한 식습관 개선이 필요함.");
			}else{
				System.out.println("7개 이상: 중독! 전문의 상담이 필요함.");
			}
			
		}*/
		
		Scanner sc2 = new Scanner(System.in);
		int selfTest2 = 0;
		int numOfNo=0;
		int flag=0;
		String[] questions = new String[10];
		String ans = null;
		
		questions[0] = "1. 아침을 배불리 먹은 후 점심시간 전에 배가 고프다.  (y/n)";
		questions[1] = "2. 밥, 빵 과자 등의 음식을 먹기 시작하면 끝이 없다.  (y/n)";
		questions[2] = "3. 음식을 금방 먹은 후에도 만족스럽지 못하고 더 먹는다.  (y/n)";
		questions[3] = "4. 정말 배가 고프지 않더라도 먹을 때가 있다.  (y/n)";
		questions[4] = "5. 저녁을 먹고 간식을 먹지 않으면 잠이 오지 않는다.  (y/n)";
		questions[5] = "6. 스트레스를 받으면 자꾸 먹고 싶어진다.  (y/n)";
		questions[6] = "7. 책상이나 식탁 위에 항상 과자, 초콜릿 등이 놓여있다.;  (y/n)";
		questions[7] = "8. 오후 5시가 되면 피곤함과 배고픔을 느끼고 일이 손에 안 잡힌다.  (y/n)";
		questions[8] = "9. 과자, 초콜릿 등의 단 음식은 상상만 해도 먹고 싶어진다.  (y/n)";
		questions[9] = "10. 다이어트를 위해 식이조절을 하는 데 3일도 못 같다.  (y/n)";
		
		System.out.println("'탄수화물 중독' 자가진단을 시작합니다.\n\n");
		System.out.println("==========================================");
		System.out.println("'탄수화물 중독' 자가진단하기");
		
		for (int i = 0; i < 10; i++) {
			System.out.println(questions[i]);
			ans = sc2.nextLine();
			if (ans.toLowerCase().equals("y"))			selfTest2 += 1;
			else if (ans.toLowerCase().equals("n"))		numOfNo += 1;
			else										flag += 1;
		}
		if(flag != 0){
			System.out.println("오류: 유효하지 않은 문자 입력.");
		}
		else{
			if(selfTest2 < 3)							System.out.println("2개 이하 : 안전!");
			else if(selfTest2 == 3)						System.out.println("3개: 주의! 위험한 수준은 아니지만 관리가 필요함.");
			else if(selfTest2 > 3 && selfTest2 < 7)		System.out.println("4~6개: 위험! 탄수화물 섭취를 줄이기 위한 식습관 개선이 필요함.");
			else										System.out.println("7개 이상: 중독! 전문의 상담이 필요함.");
		}
		
	}

}
