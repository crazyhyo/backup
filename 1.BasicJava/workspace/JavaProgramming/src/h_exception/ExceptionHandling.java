package h_exception;


public class ExceptionHandling {

	public static void main(String[] args) {
		/*
		 * 런타임 에러
		 * - 런타임 에러 발생시 발생한 위치에서 프로그램이 비정상적을 종료된다.
		 * - 에러 : 프로그램 코드에 의해 수습될 수 없는 심각한 오류(처리 불가)
		 * - 예외 : 프로그램 코드에 의해서 수습될 수 있는 다소 미약한 오류(처리 가능)
		 * 
		 * 예외
		 * - 모든 예외는 Exception 클래스의 자식 클래스이다.
		 * - RuntimeException 클래스와 그 자식들은 예외처리가 강제되지 않는다.
		 * - [RuntimeException 클래스와 그 자식들을 제외한] Exception 클래스의 자식들은 예외처리가 강제된다.
		 * 
		 * 예외처리(try-catch)
		 * - 예외처리를 통해 프로그램이 비정상적으로 종료되는 것을 방지할 수 있다.
		 * - try{} catch(Exception e) {}
		 * - try 블럭 안의 내용을 실행 중 예외가 발생하면 catch로 넘어간다.
		 * - catch의 ()안에는 처리할 예외를 지정해줄 수 있다.
		 * - 여러 종류의 예외를 처리할 수 있도록 catch는 하나 이상 올 수 있다.
		 * - 발생한 예외와 일치하는 catch 블럭안의 내용이 수행된 후 try-catch를 빠져나간다.
		 * - 발생한 예외와 일치하는 catch가 없는 경우 예외는 처리되지 않는다.
		 */
		
//		int result = (int)(10 / 0.0);
		
		try{
			int result = 10 / 0;
			//정수는 0으로 나눌 때 예외가 발생됨
			System.out.println(result);
			
		}catch(ArithmeticException | IndexOutOfBoundsException e){
			e.printStackTrace();
		}catch(NullPointerException e){
		}catch(Exception e){
			//모든 예외는 Exception의 자식 클래스, 다형성을 이용하여 모든 예외를 처리한 예시
			e.printStackTrace();
		}
		System.out.println("abcd");
		//예외처리는 형식적인 경우가 많음
		//잘 돌아가게 코드를 고치자.
		//보통 예외처리가 강제되는 경우에 예외처리를 한다(런타임예외 이외의 경우)
		//코드작성하고 문제가 없어보이는데 컴파일에러가 보인다면 Ctrl+1누르고 예외처리 하라고 하면 해주자.
		//예외 메세지를 읽는 법
		//어디서 어떤 예외가 왜 발생했는지 아는 것이 이번 시간의 내용
		//Exception in thread "main" 메인이라는 쓰레드에서 예외가 발생했다
		// java.lang.ArithmeticException: / by zero 예외의 종류는 이렇다
		// at h_exception.ExceptionHandling.main(ExceptionHandling.java:29) 예외 발생된 위치는 h_exception패키지의
		// ExceptionHandling 클래스의 main안에 있는 29번째 라인에서 발생한 것이다.
		
		test1();
		System.out.println("Outside of test1");
	}

	private static void test1() {
		test2();
	}

	private static void test2() {
//		System.out.println(10 / 0);
		/*try {
			new FileInputStream("");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}*/
		try {
			ScanUtil.nextInt();
			
		//} catch (NumberFormatException e) {
			//e.printStackTrace();
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.out.println("this");
		}
		System.out.println("Outside of TryCatch1");
	}
	/*
	at h_exception.ExceptionHandling.test2(ExceptionHandling.java:62)
	at h_exception.ExceptionHandling.test1(ExceptionHandling.java:58)
	at h_exception.ExceptionHandling.main(ExceptionHandling.java:53)
	가장 위에서 나온 위치가 문제가 아닌 경우도 있다.
	가장 위에 있는 곳이 내가 만든 것이 아닌 경우가 보통 그렇다.
	
	콜스택 : 실행되는 메서드가 저장되는 곳
	CallStack
	|___________|
	|___________|
	|___________|
	|___________|
	|__test2()__|
	|__test1()__|
	|___main()__|
	위는 뚫려있고 아래는 막혀있음 Stack구조 pop & push
	맨 위에는 가장 최근에 들어온, 가장 최근에 실행된 코드. 가장 오류가 발생했을 가능성이 높음
	*/

}
