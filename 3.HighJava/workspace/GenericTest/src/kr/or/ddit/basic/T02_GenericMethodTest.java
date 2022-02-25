package kr.or.ddit.basic;

class Util {
    /*
     *  제네릭 메서드 <T, R> R method(T t)
     *
     *  파라미터 타입과 리턴타입으로 타입 파라미터를 가지는 메서드
     *  선언방법: 리턴타입 앞에 <> 기호를 추가하고 타입파라미터를 ㅣㄱ술 후 사용함.
     *
     *  @param p1
     *  @param p2
     *  @return
     */

	public static <K, V> boolean compare(Pair<K, V> p1,
                                         Pair<K, V> p2) {
        boolean keyCompare = p1.getKey().equals(p2.getKey());
        boolean valueCompare = p1.getValue().equals(p2.getValue());
        return keyCompare && valueCompare;
        
	}
    // 파라미터에 제네릭 문법을 사용하기 위해서는 사용할 타입문자를 먼저
    // 컴파일러에게 인식시켜주어야 한다. 이를 위해 리턴타입 앞에
    // 어떤 글자를 제네릭 타입문자로 사용할 것인지 명시해 주었다.

}



public class T02_GenericMethodTest {
    public static void main(String[] args) {
        
        Pair<Integer, String> p1 = new Pair<Integer, String>(1, "홍길동");
        Pair<Integer, String> p2 = new Pair<Integer, String>(1, "홍길동");

        boolean result1 = Util.<Integer, String>compare(p1, p2);

        if(result1){
            System.out.println("논리(의미)적으로 동일한 객체임");
        }else{
            System.out.println("논리(의미)적으로 동일한 객체아님.");
        }

        Pair<String, String> p3 = new Pair<String, String>("001", "홍길동");
        Pair<String, String> p4 = new Pair<String, String>("002", "홍길동");


        //boolean result2 = Util.<String, String>compare(p3, p4);
        boolean result2 = Util.compare(p3, p4);

        if(result2){
            System.out.println("논리(의미)적으로 동일한 객체임");
        }else{
            System.out.println("논리(의미)적으로 동일한 객체아님.");
        }
        
        // 제네릭 메서드 테스트
        p1.<String, Integer>displayAll("키",180);
        p1.displayAll("키",180);
        p1.displayAll(180,"키");
        //위를 보면 p1은 Pair<Integer, String>으로 선언되어 있다!
        //제네릭 메서드에 타입파라미터를 정의해주었기 때문에 autocasting되는 것을 확인할 수 있다
        //타입파라미터 없으면 컴파일 에러
    }
}

/*
 *  멀티타입<K,V>를 가지는 제네릭 클래스
 *  @param <K>
 *  @param <V>
 */
class Pair<K, V>{
	private K key;
	private V value;
	
	public Pair(K key, V value) {
		super();
		this.key = key;
		this.value = value;
	}
	public K getKey() {
		return key;
	}
	public void setKey(K key) {
		this.key = key;
	}
	public V getValue() {
		return value;
	}
	public void setValue(V value) {
		this.value = value;
	}

    // key와 value 모두 출력하기
    public <K, V> void displayAll(K key, V val) {
        System.out.println(key.toString() + " : " + val.toString());

    }
}
