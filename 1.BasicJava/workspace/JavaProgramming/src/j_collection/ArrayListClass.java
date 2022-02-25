package j_collection;

import java.util.ArrayList;

public class ArrayListClass {

	public static void main(String[] args) {
		/*
		 * 컬렉션 프레임워크
		 * interfaces
		 * [List]	인덱스로 저장함(순서가 있음)
		 * 			ArrayList
		 * [Map]	데이터를 키에 저장함, 키와 값을 같이 저장함, 순서가 없음
		 * 			HashMap
		 * [Set]	중복된 값이 저장되지 않음
		 * 
		 * 
		 * boolean add(Object obj) : 마지막 위치에 객체를 추가 후 성공여부를 반환한다.	//실패하는 경우? 저장할 수 있는 값의 개수만큼만 저장가능(int type의 개수만큼, 20억)
		 * void add(int index, Object obj) : 지정된 위치에 객체를 추가한다.		// index < .size(), 이미 저장된 범위 내에서만 index 지정 가능
		 * Object set(int index, Object object) : 지정된 위치에 객체를 저장 후 기존 객체를 반환한다.
		 * Object get(int index) : 지정된 위치의 객체를 반환한다.				//지정된 객체가 없으면 예외
		 * int size() : 저장된 객체의 수를 반환한다.
		 * Object remove(int index) : 지정된 위치의 객체를 제거 후 반환한다.
		 */
		
		ArrayList sample = new ArrayList();
		
		sample.add("abc");
		sample.add(100);
		
		//제네릭을 지정하지 않으면 넣을때는 편하나 꺼낼때는 타입을 예측하기 힘들다.
		//따라서 제네릭의 사용이 권장된다.
		
		ArrayList<Integer> list = new ArrayList<Integer>();
//		ArrayList<Integer> list = new ArrayList<>();
		
		list.add(10);
//		list.add("abc");
		list.add(20);
		
		System.out.println(list.add(30));
		
		System.out.println(list);		//Arraylist는 자체를 출력할 수 있다.
		
		list.add(1, 40);
		System.out.println(list);
		
//		Integer before = list.set(2, new Integer(50));	원래의 형식
		Integer before = list.set(2, 50);
		System.out.println("before : " + before);
		System.out.println("after : " + list.get(2));
		System.out.println(list);
		
		//컬렉션에는 객체만 저장가능, 기본형 타입은 저장불가
		//컬렉션에 기본형을 저장하고 싶다면 기본형을 객체형으로 변환하여 저장해야 함. 이 과정을 래핑이라고 하고 그 종류는 8가지가 있음
		/*
		 * byte : Byte
		 * short : Short
		 * int : Integer
		 * long : Long
		 * float : Float
		 * double : Double
		 * char : Character
		 * boolean : Boolean
		 * 
		 * 기본형타입과 래핑클래스 사이에는 자동으로 형변환이 된다
		 */
		
//		for(int i = 0; i < list.size(); i++){		// for문의 2번째 구역의 값이 변하는 경우, 처음보네. 실시간 반영되는구나
//			System.out.println(i + " : " + list.get(i));
//			list.remove(i);
//		}
		System.out.println(list);
		for(int i = list.size() - 1 ; i >= 0; i--){		
			System.out.println(i + " : " + list.remove(i));
		}
		System.out.println(list);
		//for문의 내부 실행순서 : 삼각형 모양으로 두번째, for문 내부, 세번째 를 반복하면서 실행된다.
		
		//list에 1~100사이의 랜덤값을 10개 저장해주세요.
		for(int i = 0; i < 10; i++){
			list.add((int)(Math.random() * 100 + 1));
		}
		System.out.println(list);
		
		int sum = 0;
		double avg = 0;
		//list에 저장된 값의 합계와 평균을 구해주세요.
//		for(Integer temp : list){
//			sum += temp;
//		}
		
		for(int i = 0; i < list.size(); i++){
			sum += list.get(i);
		}
		
		avg = (double)sum / list.size();
		
		System.out.println("합계 : " + sum + "/ 평균 : " + String.format("%.2f",avg));
		
		//list에서 최소값과 최대값을 구해주세요.
		int max = 0;
		int min = 100;
		
		for(int i = 0; i < list.size(); i++){
			if(min > list.get(i)){
				min = list.get(i);
			}
			if(max < list.get(i)){
				max = list.get(i);
			}
		}
		System.out.println(min);
		System.out.println(max);
		
		for(int i = 1; i < list.size(); i++){
			int temp = list.get(i);
			int j = 0;
			for(j = i - 1; j >= 0; j--){
				if(temp < list.get(j)){
					list.set(j + 1, list.get(j));
				}else
					break;
			}
			list.set(j + 1, temp);
		}
		System.out.println(list);
		
		
		//2차원
		
		ArrayList<ArrayList<Integer>> list2 = new ArrayList<ArrayList<Integer>>();
//		ArrayList<ArrayList<Integer>> temp = new ArrayList<ArrayList<>>();
//		ArrayList<ArrayList<Integer>> temp = new ArrayList<>();
		
		list = new ArrayList<>();
		list.add(10);
		list.add(20);
		list.add(30);
		list2.add(list);
		
		list = new ArrayList<>();
		list.add(40);
		list.add(50);
		list2.add(list);
		
		System.out.println(list2);
		
		for(int i = 0; i < list2.size(); i++){
			ArrayList<Integer> li = list2.get(i);
			for(int j = 0; j < li.size(); j++){
				System.out.println(li.get(j));
			}
		}
		
		int num = list2.get(0).get(1);
		System.out.println(num);
		
		for(ArrayList<Integer> tmpList : list2){
			for(Integer i : tmpList){
				System.out.println(i);
			}
		}
	}
	void swap(int idx1, int idx2, ArrayList<Integer> list){
		int temp = list.get(idx1);
		list.set(idx1, list.get(idx2));
		list.set(idx2, temp);
	}
	
	int pivot(int left, int right, ArrayList<Integer> list){
		int pivot = list.get(left);
		int low = left + 1;
		int high = right - 1;
		while(true){
			while(true){
				if(pivot >= list.get(low) && low <= right - 1){
					low++;
				}else				break;
			}
			while(true){
				if(pivot <= list.get(high) && high > 0){
					high--;
				}else				break;
			}
			if(high <= low)
				swap(high, low, list);
			break;
		}
		swap(high, left, list);
		return high;	
	}
	void quickSort(int left, int right, ArrayList<Integer> list){
		if(left < right){
			int pivot = pivot(left, right, list);
//			pivot(list)
		}
	}
	
}
