package Programmers;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class BeakJoon {

	public static void main(String[] args) throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer st = new StringTokenizer(br.readLine()," ");
		System.out.println("   ");
		int a = Integer.parseInt(st.nextToken());
		int b = Integer.parseInt(st.nextToken());
		
		System.out.println(a * (b % 10));
		System.out.println(a * ((b / 10) % 10));
		System.out.println(a * (b / 100));
		System.out.println(a * b);
	}
}



//import java.io.*;
//import java.util.*;
//
//public class Main {
//    public static void main(String[] args) throws IOException{
//        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
//        StringTokenizer st = new StringTokenizer(br.readLine()," ");
//
//        int a = Integer.parseInt(st.nextToken());
//        int b = Integer.parseInt(st.nextToken());
//
//        System.out.println(a+b);
//        System.out.println(a-b);
//        System.out.println(a*b);
//        System.out.println(a/b);
//        System.out.println(a%b);
//			br.close();
//    }
//}