package g_oop2;

public class AccessModifier {
	
	public String publicVar = "public : 접근제한이 없음";
	protected String protectedVar = "protected : 같은 패키지 + 상속받은 클래스에서 접근 가능";
	String defaultVar = "default : 같은 패키지에서만 접근 가능";
	private String privateVar = "private : 클래스 내에서만 접근 가능";
	
	public void publicMethod(){
		System.out.println(publicVar);
	}
	protected void protectedMethod(){
		System.out.println(protectedVar);
	}
	void defaultMethod(){
		System.out.println(defaultVar);
	}
	private void privateMethod(){
		System.out.println(privateVar);
	}
	
	public static void main(String[] args) {
		Time t = new Time();
		
//		t.hour = 14;
//		t.minute = 2;
//		t.second = 99;
		
		t.setHour(23);
		t.setMinute(59);
		t.setSecond(55);
		
		
		System.out.println(t.getTime());
		//사용자의 부적합한 입력문제 -> 직접 접근하지 못하게 그리고 메서드를 통해 간접적으로 접근할 수 있도록
		
		//접근제어자 사용 이유
		//데이터를 보호하기 위해
		//사용하는데 불필요한 멤버를 숨기기 위해
		t.clock();
	}
}
