package Programmers;

import java.util.Arrays;
import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;

public class Randomstudents {

	public static void main(String[] args) {
		/*
		 * 숫자를 입력받아 입력받은 숫자만큼 403호 학생들 중 랜덤으로 출력해주세요.
		 * 25명
		 * 사용자가 3이라 입력하면 403중 3명 뽑기
		 * + 중복되지 않아야 함
		 * 이단비, 김노을, 정현욱, 박소현, 김수진, 이희현, 강건, 이민영, 하기재, 이윤우, 김미희,
		 * 김혜윤, 신승철, 이광효, 김진혁, 마창수, 양기욱, 이동근, 석기현, 류인성, 이미정, 임나리,
		 * 송민섭, 김지윤, 조명석
		 */
		
		Map<Integer,String> students403 = new HashMap<Integer,String>();
		Scanner sc = new Scanner(System.in);
		int numOfStudents, count, rand;
		int decision;
		
		students403.put(1,"이단비");
		students403.put(2,"김노을");
		students403.put(3,"정현욱");
		students403.put(4,"박소현");
		students403.put(5,"김수진");
		students403.put(6,"이희현");
		students403.put(7,"강건");
		students403.put(8,"이민영");
		students403.put(9,"하기재");
		students403.put(10,"이윤우");
		students403.put(11,"김미희");
		students403.put(12,"김혜윤");
		students403.put(13,"신승철");
		students403.put(14,"이광효");
		students403.put(15,"김진혁");
		students403.put(16,"마창수");
		students403.put(17,"양기욱");
		students403.put(18,"이동근");
		students403.put(19,"석기현");
		students403.put(20,"류인성");
		students403.put(21,"이미정");
		students403.put(22,"임나리");
		students403.put(23,"송민섭");
		students403.put(24,"김지윤");
		students403.put(25,"조명석");
		
		Set<Integer> keySet = students403.keySet();
		
		do{
			System.out.print("1~25사이의 값을 입력하세요: ");
			numOfStudents = Integer.parseInt(sc.nextLine());
		}while(numOfStudents > 25 || numOfStudents < 1);
		
		int[] chosenStudents = new int[numOfStudents];
		
		count = 0;

		while(count != numOfStudents){
			decision = 0;
			rand = (int)(Math.random() * 25) + 1;
			
			for(int i = 0; i < count; i++){
				if(chosenStudents[i] == rand){
					decision = -1;
					break;
				}
			}
			if(decision != -1){
				chosenStudents[count] = rand;
				count++;
			}
		}
		
		System.out.println(Arrays.toString(chosenStudents));
		
		count = 0;
		for(int i: keySet){
			count++;
				System.out.println("student403.get(\"" + chosenStudents[i-1] + "\") = " + students403.get(chosenStudents[i-1]));
			if(count == numOfStudents)		break;
			
		}
		

				
	}

}
