package j_collection;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Set;

public class HashMapClass {
	
	public static void main(String[] args) {
		/*
		 * Object put(Object key, Object value) : 지정된 키와 값을 저장한다.
		 * Object remove(Object key) : 지정된 키로 저장된 값을 제거한다.
		 * Object get(Object key) : 지정된 키의 값(없으면 null)을 반환한다.
		 * Set ketSet() : 저장된 모든 키를 Set으로 반한다.
		 * 
		 * Map : 키와 값을 저장, 순서가 없음
		 */
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("age", 10);
		map.put("name", "홍길동");
		map.put("date", new Date());
		//하나의 키는 하나의 값만 저장, 수정은 그냥 같은 키값으로 해결
		System.out.println(map);
		//hashmap내부적으로 저장되어있는 순서대로 출력
		map.put("name","이순신");
		System.out.println(map);
		
		map.remove("age");
		System.out.println(map);
		
		Object value = map.get("name");
		System.out.println(value);
		
		((String)value).charAt(0);
//		(String)value.charAt(0);
		//.연산이 형변환 연산보다 먼저 수행된다.
		//(String)value.charAt(0); 는 object type인 value에게 string 클래스의 메소드 charAt을 쓰라는 것, 그후에 형변환
		//에러
		
		Set<String> keys = map.keySet();	//저장된 모든 키
		
		for(String key : keys){	//향상된 for문, for each 문, iterable
			System.out.println(key + " : " + map.get(key));
			
		}	// Set이나 Map은 순서가 없기 때문에 내부적으로 저장된 순서에 따라서 for문이 수행된다
		
		map.values().toArray();
		
		//	HashMap과 ArrayList를 이용하여 Table을 구성하는 방법
		//	Table의 컬럼이름을 키로 인스턴스의 해당 키값을 value로 지정한 HashMap을 만든다
		//	이 HashMap은 Table의 컬럼 개수만큼의 키와 그만큼의 value를 가지고 있다.
		//	이 HashMap을 하나의 인스턴스로 취급하여 Table을 표현하는 ArrayList<HashMap>에 하나씩 add하면
		//	테이블을 표현하는 ArrayList 완성!
		
		/*
		 * 아이디		: admin
		 * 비밀번호	: admin123
		 * 이름		: 관리자
		 * 전화번호	: 010-1234-5678
		 */
		
		HashMap<String, String> user = new HashMap<>();
		user.put("아이디", "admin");
		user.put("비밀번호", "admin123");
		user.put("이름", "관리자");
		user.put("전화번호", "010-1234-5678");
		
		System.out.println(user);
		ArrayList<HashMap<String,String>> table = new ArrayList<HashMap<String,String>>();
		table.add(user);
		System.out.println(table);
		
//		Set<String> keyset = user.keySet();
//		for(String key : keyset){
//			user.remove(key);
//		}
//		user.clear();
		HashMap<String, String> user2 = new HashMap<>();
		System.out.println(user2);
		user2.put("아이디", "ADMIN");
		user2.put("비밀번호", "ADMIN123");
		user2.put("이름", "관리자1234");
		user2.put("전화번호", "010-8765-4321");
		table.add(user2);
		System.out.println(table);
		
		ArrayList<String> lprod_id = new ArrayList<String>();
		ArrayList<String> lprod_gu = new ArrayList<String>();
		ArrayList<String> lprod_nm = new ArrayList<String>();
		
		lprod_id.add("1");
		lprod_id.add("2");
		lprod_id.add("3");
		lprod_id.add("4");
		lprod_id.add("5");
		lprod_id.add("6");
		lprod_id.add("7");
		lprod_id.add("8");
		lprod_id.add("9");
		lprod_id.add("10");
		
		lprod_gu.add("P101");
		lprod_gu.add("P102");
		lprod_gu.add("P201");
		lprod_gu.add("P202");
		lprod_gu.add("P301");
		lprod_gu.add("P302");
		lprod_gu.add("P401");
		lprod_gu.add("P402");
		lprod_gu.add("P403");
		lprod_gu.add("P501");
		
		lprod_nm.add("컴퓨터제품");
		lprod_nm.add("전자제품");
		lprod_nm.add("여성캐주얼");
		lprod_nm.add("남성캐주얼");
		lprod_nm.add("피혁잡화");
		lprod_nm.add("화장품");
		lprod_nm.add("음반/CD");
		lprod_nm.add("도서");
		lprod_nm.add("문구류");
		lprod_nm.add("농산물");

		HashMap<String,String> instance = new HashMap<String,String>();
//		HashMap<String,String> instance1 = new HashMap<String,String>();
//		HashMap<String,String> instance2 = new HashMap<String,String>();
//		HashMap<String,String> instance3 = new HashMap<String,String>();
//		HashMap<String,String> instance4 = new HashMap<String,String>();
//		HashMap<String,String> instance5 = new HashMap<String,String>();
//		HashMap<String,String> instance6 = new HashMap<String,String>();
//		HashMap<String,String> instance7 = new HashMap<String,String>();
//		HashMap<String,String> instance8 = new HashMap<String,String>();
//		HashMap<String,String> instance9 = new HashMap<String,String>();
//		HashMap<String,String> instance10 = new HashMap<String,String>();
		
		ArrayList<HashMap<String,String>> LPROD = new ArrayList<HashMap<String,String>>();
		for(int i = 0; i < lprod_id.size(); i++){
			instance = new HashMap<String,String>();
			instance.put("LPROD_ID",lprod_id.get(i));
			instance.put("LPROD_GU",lprod_gu.get(i));
			instance.put("LPROD_NM",lprod_nm.get(i));
			LPROD.add(instance);
		}
		
		//new를 잘 쓰면 새로운 변수를 생성하지 않아도 된다!
		
//		System.out.println(LPROD);
//		LPROD.clear();
//		System.out.println(LPROD);
		
//		instance1.put("LPROD_ID","1");
//		instance1.put("LPROD_GU","P101");
//		instance1.put("LPROD_NM","컴퓨터제품");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","2");
//		instance1.put("LPROD_GU","P102");
//		instance1.put("LPROD_NM","전자제품");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","3");
//		instance1.put("LPROD_GU","P201");
//		instance1.put("LPROD_NM","여성캐주열");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","4");
//		instance1.put("LPROD_GU","P202");
//		instance1.put("LPROD_NM","남성캐주얼");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","5");
//		instance1.put("LPROD_GU","P301");
//		instance1.put("LPROD_NM","피혁잡화");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","6");
//		instance1.put("LPROD_GU","P302");
//		instance1.put("LPROD_NM","화장품");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","7");
//		instance1.put("LPROD_GU","P401");
//		instance1.put("LPROD_NM","음반/CD");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","8");
//		instance1.put("LPROD_GU","P402");
//		instance1.put("LPROD_NM","도서");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","9");
//		instance1.put("LPROD_GU","P403");
//		instance1.put("LPROD_NM","문구류");
//		LPROD.add(instance1);
//		instance1 = new HashMap<>();
//		instance1.put("LPROD_ID","10");
//		instance1.put("LPROD_GU","P501");
//		instance1.put("LPROD_NM","농산물");
//		LPROD.add(instance1);
		
		System.out.println("LPROD_ID\tLPROD_GU\tLPROD_NM");
		for(HashMap<String,String> walk : LPROD){
			System.out.print(walk.get("LPROD_ID") + "\t\t");
			System.out.print(walk.get("LPROD_GU") + "\t\t");
			System.out.println(walk.get("LPROD_NM") + "\t\t");
		}
	}
}
