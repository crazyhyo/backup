package b_operator;

public class ArithmeticOperator {

	public static void main(String[] args) {
		/*
		 * 산술연산자
		 * - 사칙연산자 : +, -, *, /, %(나머지)
		 * - 복합연산자 : += -=, *=, /=, %=
		 * - 증감연산자 : ++, --
		 */
		
		/*int result = 10 + 20 - 30 * 40 / 50 % 60;*/

		// 나머지 연산도 *, /랑 같은 실행우선순위를 가짐
		// 나머지 연산
		
		/*result = 10 / 3;	//3.3333
		System.out.println(result);
		result = 10 % 3;
		System.out.println(result);*/
		
		//5개의 산술연산자를 사용해 5개의 연산을 수행후 결과를 출력해주세요.
		
		
		/*System.out.print("3 + 5 = ");
		System.out.println(3 + 5);
		System.out.print("3 - 5 = ");
		System.out.println(3 - 5);
		System.out.print("3 * 5 = ");
		System.out.println(3 * 5);
		System.out.print("3 / 5 = ");
		System.out.println(3.0 / 5.0);
		System.out.print("5 % 3 = ");
		System.out.println(5 % 3);*/
		
		//복합연산자
		//변수에 저장되어 있는 값에 연산을 수행할 때 수행할 연산자와 대입연산자를 결합해 사용할 수 있다.
		/*result = result + 3;
		System.out.println(result);
		
		result += 3;
		System.out.println(result);
		
		result -= 5;
		System.out.println(result);
		
		result *= 2;
		System.out.println(result);*/
		
		//아래의 문장을 복합연산자를 사용한 문장으로 만들어주세요.
		//result = result + 10;
		//result = result % 5;
		//result = result - 2 * 3;
		
		/*result += 10;
		result %= 5;
		result -= 2 * 3;*/
		
		//증감연산자
		//증감연산자(++) : 변수의 값을 1 증가시킨다.
		//감소연산자(--) : 변수의 값을 1 감소시킨다.
		int i = 0;
		
		i++;	//후위형 : 변수의 값을 읽어온 후에 1 증가된다.
		++i;	//전위형 : 변수의 값을 읽어오기 전에 1 증가된다.
		i--;	//후위형 : 변수의 값을 읽어온 후에 1 감소된다.
		--i;	//전위형 : 변수의 값을 읽어오기 전에 1 감소된다.
		
		i = 0;
		System.out.println("++i = " + ++i);
		i = 0;
		System.out.println("i++ = " + i++);
		System.out.println(i);
		
		//산술연산자의 경우 : 피연산자의 타입이 서로 같아야만 연산이 가능하다. / 사칙 + % 연산은 피연산자가 2개인 이항연산자
		int _int = 10;
		double _double = 3.14;
		double result2 = _int + _double;	//표현범위가 더 큰 타입으로 형변환된다. : 작은 타입에서 큰 타입으로 형변환하여 생략됨. 풀어쓰면 (double)_int + _double;
		System.out.println(result2);
		
		byte _byte = 5;
		short _short = 10;
		_int = _byte + _short;			//int보다 작은 타입은 int로 형변환된다. 컴퓨터의 연산 정의역은 4바이트 이상인 자료형, 우변의 값은 int 타입이다.
										//단, 컴퓨터는 기본적으로 4바이트 이상인 자료만 연산함. 1바이트와 2바이트 자료형은 4바이트인 int로 형변환하여 연산을 수행한다.
		System.out.println(_int);
		
		char _char = 'a';				//char 타입은 2바이트 연산시 4바이트인 int로 형변환 되어서 연산됨
		char _char2 = 'b';
		_int = _char + _char2;			//자바에서는 유니코드를 사용함 a: 97, b: 98
		System.out.println(_int);
		
		//오버플로우, 언더플로우
		//표현범위를 벗어나는값을 표현할 때 발생하는 현상
		byte b = 127;				//범위 : -128 ~ 127
		b++;
		System.out.println(b);		//-128로 출력
		b = -128;
		b--;
		System.out.println(b);		//127로 출력
		//Q: b = b-4;를 수행하면 어떻게 되느냐? int를 byte로 변환할 수 없다는 에러 발생
		
		
		
		//다음을 한줄씩 계산해서 최종 결과값을 출력해주세요.
		//1. 123456 + 654321
		//2. 1번의 결과값 * 123456
		//3. 2번의 결과값 / 123456
		//4. 3번의 결과값 - 654321
		//5. 4번의 결과값 % 123456
		
		double x = 123456 + 654321;
		x *= 123456;
		x /= 123456;
		x -= 654321;
		x %= 123456;
		System.out.println(x);
		
		//3개의 int형 변수를 선언 및 초기화 후 합계와 평균을 구해주세요.
		int var1 = 3;
		int var2 = 6;
		int var3 = 5;
		
		double sum;
		double average;
		sum = var1 + var2 + var3;
		average = sum / 3;			//이게 제대로 안되는 경우 1) sum이 int type인 경우 : 둘 모두 int라서 int값 계산됨 -> 해결1. sum을 double로 설정. 해결2. / 3을 / 3.0으로 변경
		// average = (double) (var1 + var2 + var3) / 3; 주의) 여기서 형변환(double)하지 않으면 제대로 계산 안됨
		System.out.println(sum);
		System.out.println(average);
		
		//반올림	Math.round는 항상 소수점 첫번째 자리에서 반올림하기 때문에 다른 자리수에서 반올림하기 위해서는 자리수를 맞춰서 곱하고 나누어 계산한다.
		average = Math.round(average * 100) / 100.0;
		System.out.println(average);
		
		//랜덤
		int random = (int)(Math.random() * 100) + 1;
		System.out.println(random);
		
		//Math.random() : 0.0 ~ 1.0미만(0.999...) / Math.random()의 출력값은 double 타입
	}

}
