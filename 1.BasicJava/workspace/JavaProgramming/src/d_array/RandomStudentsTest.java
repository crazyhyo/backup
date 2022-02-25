package d_array;

import java.util.Arrays;
import java.util.Scanner;


public class RandomStudentsTest {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		int numOfStudents, count, rand;
		int decision;
		String[] studentMembers = {"이단비","김노을","정현욱","박소현","김수진","이희현","강건","이민영","하기재",
									"이윤우","김미희","김혜윤","신승철","이광효","김진혁","마창수","양기욱","이동근",
									"석기현","류인성","이미정","임나리","송민섭","김지윤","조명석"};

		do{
			System.out.print("1~" + studentMembers.length + "사이의 값을 입력하세요: ");
			numOfStudents = Integer.parseInt(sc.nextLine());
		}while(numOfStudents > studentMembers.length || numOfStudents < 1);
		
		int[] chosenStudents = new int[numOfStudents];
		
		count = 0;
		
/*		for(int i = 1; i < studentMembers.length * 50; i++){
			rand = (int)(Math.random() * 10);
			String temp = studentMembers[0];
			studentMembers[0] = studentMembers[rand];
			studentMembers[rand] = temp;
		}
		
		for(int i = 0; i < numOfStudents; i++){
			System.out.print(studentMembers[i] + " ");
		}*/
			
/*		while(count != numOfStudents){
			decision = 0;
			rand = (int)(Math.random() * studentMembers.length) + 1;
			
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
		}*/
		while(count != numOfStudents){
			decision = 0;
			rand = (int)(Math.random() * studentMembers.length) + 1;
			for(int i = 0; i < count; i++){
				if(chosenStudents[i] == rand){
					decision++;
				}
			}
			if(decision == 0){
				chosenStudents[count] = rand;
				count++;
			}
		}
/*		for(int i = 0; i < numOfStudents; i++){
			rand = (int)(Math.random() * studentMembers.length) + 1;
			chosenStudents[i] = rand;
			for(int j = 0; j < i; j++){
				if(chosenStudents[i] == chosenStudents[j]){
					i--;
					break;
				}
			}
		}*/
		
		System.out.println(Arrays.toString(chosenStudents));
		
		for(int i = 0; i < numOfStudents; i++){
			System.out.print(studentMembers[chosenStudents[i]-1] + " ");
		}
		/*
		 * do{
		 * 		int random = (int)(Math.random() * studentMembers.length) + 1;
		 * 		
		 * 		boolean flag = true;
		 * 		for(int i = 0; i < studentMembers.length; i++){
		 * 			if(students[random].equals(pick[i])){
		 * 				flag = true
		 * 			}
		 * 		}
		 * 		if(flag){
		 * 			chosenStudents[count++] = students[random];			//	배열의 0번 인덱스 값에 값을 할당하고 증가시킴
		 * 		}
		 * }while(pickcount < count)
		 */
		
	}

}
