package kr.or.ddit.toy;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class SetMethods {
	
	public static void main(String[] args) {
		Set<String> set = new HashSet<String>();
		List<String> list = new ArrayList<String>();
		
		set.add("1");
		set.add("2");
		set.add("3");
		set.add("4");
		
		System.out.println("add(E e)");
		System.out.println(set);
		System.out.println("size()");
		System.out.println(set.size());
		
		System.out.println("toArray()");
		for(int i = 0; i < set.toArray().length; i++) {
			System.out.print(set.toArray()[i] + " ");
		}
		System.out.println();
		
		Object[] objArray = new Object[set.size()];
		
		System.out.println("toArray(Object)");
		for(int i = 0; i < set.toArray(objArray).length; i++) {
			System.out.print(set.toArray(objArray)[i] + " ");
		}
		System.out.println();
		
		
		
		System.out.println("contains(\"4\")");
		System.out.println(set.contains("4"));
		System.out.println("contains(\"5\")");
		System.out.println(set.contains("5"));
		
		list.add("6");
		list.add("7");
		list.add("1");
		list.add("3");
		
		System.out.println("list");
		System.out.println(list);
		
		System.out.println("containsAll(Collection<?> c)");
		System.out.println(set.containsAll(list));

		System.out.println("addAll(collection<? extends E> c)");
		set.addAll(list);
		System.out.println(set);
		
		System.out.println("spliterator()");
		System.out.println(set.spliterator());
		System.out.println(set);
		
		
		list.clear();
		
		list.add("1");
		list.add("2");
		list.add("4");
		
		System.out.println("list");
		System.out.println(list);

		System.out.println("containsAll(Collection<?> c)");
		System.out.println(set.containsAll(list));
		
		System.out.println("isEmpty()");
		System.out.println(set.isEmpty());
		
		System.out.println("remove(\"9\")");
		System.out.println(set.remove("9"));
		System.out.println(set);
		
		System.out.println("remove(\"6\")");
		System.out.println(set.remove("6"));
		System.out.println(set);

		System.out.println("list");
		System.out.println(list);
		
		
		System.out.println("removeAll(Collection<?> c)");
		System.out.println(set.removeAll(list));
		System.out.println(set);
		
		System.out.println("iterator()");
		Iterator<String> it = set.iterator();
		
		while(it.hasNext()) {
			System.out.println(it.next());
		}
		
		list.clear();
		
		list.add("3");
		list.add("7");
		
		System.out.println(list);
		
		System.out.println("retainAll(Collection<?> c) : 파라미터와의 교집합을 반환한다(변경이 있을시 true)");
		System.out.println(set.retainAll(list));
		System.out.println(set);

		list.clear();
		
		list.add("3");
		list.add("4");
		
		System.out.println(list);
		
		System.out.println("retainAll(Collection<?> c) : 파라미터와의 교집합을 반환한다(변경이 있을시 true)");
		System.out.println(set.retainAll(list));
		System.out.println(set);
		
		System.out.println();
		
		System.out.println("equals(list)");
		System.out.println(set.equals(list));
		
		System.out.println("equals(set)");
		System.out.println(set.equals(set));
		
		System.out.println("hashCode()");
		System.out.println(set.hashCode());
		
		System.out.println("clear()");
		set.clear();
		
		System.out.println(set);
		System.out.println("isEmpty()");
		System.out.println(set.isEmpty());
		
		
	}
	
}
/*
 * toArray(T[] a) 
 */
