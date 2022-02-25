package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Stream {
	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList<>(Arrays.asList("Apple","Banana","Melon","Grape","Strawberry"));
		
		System.out.println(list.stream().map(s->s.toUpperCase()).collect(Collectors.joining(",")));
		
	}
}
