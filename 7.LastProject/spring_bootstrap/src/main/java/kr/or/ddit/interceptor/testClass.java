package kr.or.ddit.interceptor;

public class testClass {
	
	private static String makeLog(String...strings) {
		
		StringBuffer sb = new StringBuffer();
		for(String string : strings) {
			sb.append(string);
			sb.append(",");
		}
		sb.append("log end");
		return sb.toString();
	}
	
	public static void main(String[] args) {
		String test = makeLog("[test1]", "[test2]", "[test3]");
		System.out.println(test);
	}
}
