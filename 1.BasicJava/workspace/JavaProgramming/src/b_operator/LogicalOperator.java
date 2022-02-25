package b_operator;

public class LogicalOperator {

	public static void main(String[] args) {
		/*
		 * 논리연산자
		 * - &&(and) , ||(or), !(NOT)
		 * - 피연산자로 boolean만 허용한다.
		 */
		
		int x = 10;
		int y = 20;
		boolean b = 0 < x && x < 10 || x < y;
		//주의) 한 문장에서 and와 or이 동시에 사용된 경우에는 and연산이 우선순위를 가진다
		
		b = !(x < y);
		//주의 !은 boolean타입 앞에만 붙여야 함. 예를 들어 !x<y는 컴파일 에러 인트타입 앞에 ! 못붙임
		System.out.println(b);
		//효율적 연산
		b = true && true;	//true
		b = true && false;	//false
		b = false && true;	//false
		b = false && false;	//false
		
		b = true || true;	//true
		b = true || false;	//true
		b = false || true;	//true
		b = false || false;	//false
		//왼쪽의 피연산자에서 결과가 정해지면 오른쪽은 수행하지 않는다.
		
		//효율적 연산으로 인해 내가 의도한 결과가 나오지 않을 수 있다.
		int a = 10;
		b = a < 5 && 0 < a++;
		System.out.println(a);
		
		//다음의 문장들을 코드로 작성해주세요.
		//x가 y보다 크고 x가 10보다 작다.
		b = x > y && x < 10;
		System.out.println(b);
		//x가 짝수이고 y보다 작거나 같다.
		b = x % 2 == 0 && x <= y;
		System.out.println(b);
		//x가 3의 배수이거나 5의 배수이다.
		b = x % 3 == 0 || x % 5 == 0;
		System.out.println(b);
	}

}
