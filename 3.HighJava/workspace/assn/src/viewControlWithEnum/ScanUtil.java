package viewControlWithEnum;
import java.util.Scanner;

public class ScanUtil {
	
	private static Scanner s = new Scanner(System.in);
	public static String nextLine(){
		return s.nextLine();					//인스턴스 변수일 때 컴파일에러, public s
	}
	
	public static int nextInt(){	
		int num = 0;
		while(true){
			try {
				num = Integer.parseInt(s.nextLine());
			} catch (Exception e) {		//	숫자를 입력받을 때까지 반복한다.
				System.out.println("잘못 입력하셨습니다. 숫자를 입력해주세요.");
				continue;		
			}
			break;
		}
		return num;
	}
}