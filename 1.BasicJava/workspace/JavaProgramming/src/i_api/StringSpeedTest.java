package i_api;

public class StringSpeedTest {

	public static void main(String[] args) {
//		stringbuffer : string을 보완하기 위한 클래스
		String str = "a";
		long start = System.currentTimeMillis();
		for(int i = 0; i < 200000; i++){
			str += "a";
		}
		long end = System.currentTimeMillis();
		//현재시간을 ms단위로 표현해서 long타입으로 반환
		System.out.println(end - start + "ms");
		StringBuffer sb = new StringBuffer("a");
//		long start = System.currentTimeMillis();
		for(int i = 0; i < 200000; i++){
			sb.append("a");
		}
//		long end = System.currentTimeMillis();
		//현재시간을 ms단위로 표현해서 long타입으로 반환
		System.out.println(end - start + "ms");
		
		//String은 변경을 가하면 객체를 새로 생성한다.
	}

}
