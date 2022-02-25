package e_oop;

public class Answer {
	int answer(int result, String ans){
		if(ans.equals("y") || ans.equals("Y")){
			switch(result){
			case 0:	result = 1;		break;
			case 1:	result = 4;		break;
			case 2:	result = 5;		break;
			case 3:	result = 6;		break;
			case 4:	result = 7;		break;
			case 5:	result = 7;		break;
			case 6:	result = 9;		break;
			case 7:	result = 8;		break;
			case 8:	result = 12;	break;
			}
		}else if(ans.equals("n") || ans.equals("N")){
			switch(result){
			case 0:	result = 3;		break;
			case 1:	result = 2;		break;
			case 2:	result = 4;		break;
			case 3:	result = 4;		break;
			case 4:	result = 5;		break;
			case 5:	result = 8;		break;
			case 6:	result = 7;		break;
			case 7:	result = 10;	break;
			case 8:	result = 11;	break;
			}
		}
		return result;
	}
}
