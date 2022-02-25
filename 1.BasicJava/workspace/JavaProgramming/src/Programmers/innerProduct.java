package Programmers;
import java.util.Arrays;
import java.util.Scanner;

public class innerProduct {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		int len = 0;
		int innerProduct = 0;
		do{
			System.out.print("두 배열의 크기를 입력하세요(입력범위는 1부터 1000입니다.)");
			len = Integer.parseInt(sc.nextLine());
		}while( len < 1 || len > 1000);
		int[] a = new int[len];
		int[] b = new int[len];

		for(int i = 0; i < len; i++){
			int rand = (int)(Math.random() * 2001) - 1001 ;
			a[i] = rand;
			rand = (int)(Math.random() * 2001) - 1001 ;
			b[i] = rand;
		}

		System.out.print("a와 b의 내적은 ");

		for(int i = 0; i < len; i++){
			innerProduct += a[i] * b[i];
			System.out.print( a[i] + "*" + b[i] );
			if(i != len -1)	System.out.print(" + ");
		}
		
		System.out.println(" = " + innerProduct + "입니다.");
		
	}

}
