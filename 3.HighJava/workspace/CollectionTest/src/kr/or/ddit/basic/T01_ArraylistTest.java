package kr.or.ddit.basic;


import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class T01_ArraylistTest {
	public static void main(String[] args) {
		
		
		// DEFAULT_CAPACITY = 10
//		List list1 = new ArrayList();
		List list1 = new LinkedList();
			
		//add()메서드를 사용해서 데이터를 추가한다.
		list1.add("aaa");
		list1.add("bbb");
		list1.add(111);
//		list1.add(new Integer(111));
		list1.add('k');
		list1.add(true);
		list1.add(12.34);
		list1.add(0);
		
		//size() => 데이터 개수
		System.out.println("Size => " + list1.size());
		System.out.println("list " + list1);
		
		// get()으로 데이터 꺼내오기
		System.out.println("1번째 자료 : " + list1.get(0));
		
		// 데이터 끼워 넣기도 같다.
		list1.add(0,"zzz");
		System.out.println("list1 => " + list1);
		
		// 데이터 변경하기(set메서드)
		String temp = (String) list1.set(0,"yyy");
		System.out.println("temp => " + temp);
		System.out.println("list1 => " + list1);
		
		//삭제하기
//		list1.remove(0);	//파라미터가 int값이므로 index로 판단한다.
		list1.remove("bbb");//파라미터가 int가 아니면 값이 일치하는 것을 삭제한다.
		list1.remove(new Integer(0));	//값이 0인 데이터를 list에서 삭제하고 싶으면  이렇게 객체를 파라미터로 넣어야 한다.
		
		System.out.println("bbb 삭제 후 : " + list1);
		System.out.println("list1 => " + list1);
		System.out.println("=======================");
		
		// 제네릭을 지정하여 선언할 수 있다.
		List<String> list2 = new ArrayList<String>();
		// 제네릭의 사용이유 :  리스트의 내용물을 String으로 제한
		list2.add("AAA");
		list2.add("BBB");
		list2.add("CCC");
		list2.add("DDD");
		list2.add("EEE");
//		list2.add(2222);	//	제네릭 제한으로 인한 컴파일오류
		
		for(int i = 0; i < list2.size(); i++) {
			System.out.println(i + " : " + list2.get(i));
		}
		System.out.println("-------------------------------");
		
		// contains(비교객체) => 리스트에 '비교객체'가 있으면 true
		//						그렇지 않으면 false
		
		System.out.println(list2.contains("DDD"));
		System.out.println(list2.contains("ZZZ"));
		
		// indexOf(비교객체) => 리스트에 '비교객체'를 찾아 '비교객체가 있는
		//						index값을 반환한다.
		//						리스트에 '비교객체'가 없으면 -1을 반환한다.
		System.out.println("DDD의 index값 : " + list2.indexOf("DDD"));
		System.out.println("ZZZ의 index값 : " + list2.indexOf("ZZZ"));
		System.out.println("---------------------------------------");
		
		// toArray() => 리스트 안의 데이터들을 배열로 변환하여 반환한다.
		//				기본적으로 Object형 배열로 반환한다.
		Object[] strArr = list2.toArray();
		System.out.println("배열의 개수 : " + strArr.length);
		
		// ArrayList 순차적으로 지우기
		for(int i = 0; i < list2.size(); i++) {
			list2.remove(i);
		}
		/*for(int i = list2.size() - 1; i >= 0; i--) {
			list2.remove(i);
		}*/
		
		System.out.println("삭제후 크기 => " + list2.size());
	}
	
}
