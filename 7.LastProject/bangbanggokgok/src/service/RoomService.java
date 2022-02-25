
/*
 * roomSelect(방상세) : x
 * roomAdd(방추가) : o
 * roomModify(방수정) : o
 * roomDelete(방삭제) : o
 * 
 */

package service;

import java.util.Map;

import util.JDBCUtil;
import util.ScanUtil;
import util.View;
import dao.LodgeDao;
import dao.ReservationDao;
import dao.RoomDao;

public class RoomService {

	
	public static Map<String, Object> currentRoom = null;
	public static RoomDao roomDao = RoomDao.getInstance();
	public static LodgeDao lodgeDao = LodgeDao.getInstance();
	
	public static int getRoomNo() {
		
		if(currentRoom != null){
			return (int)currentRoom.get("RO_NO");
		}else{
			System.out.println("현재 선택된 숙소가 없습니다.");
		}
		return -1;
	}

	
	public static int roomDetail(){
		roomDao.selectRoom(currentRoom);
		
		boolean HasDateOption = (OptionService.getSdate() != null && OptionService.getEdate() != null);
		
		System.out.println("1.예약하기\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1: 
		
		if(MemberService.currentMember != null){
			if((int)MemberService.currentMember.get("MEM_CODE") == 2){
				System.out.println("숙박시설주 회원은 예약할 수 없습니다. 일반회원이나 비회원으로 이용해주세요");
				ScanUtil.stop(1000);
				return View.ROOM_DETAIL;
			}
		}
			
		System.out.println("예약기간을 설정하면 예약가능 여부가 표시됩니다.");
		
		if(HasDateOption){
			if(roomDao.checkAvail(roomDao.getRoomResv())){
				System.out.println("예약가능합니다!");
				System.out.println("가격 : " + OptionService.setSum());
				ReservationDao.insertResv(HasDateOption);
				return View.RESERVATION;
			}else{
				System.out.println("예약불가합니다!");
				OptionService.option.remove("SDATE");
				OptionService.option.remove("EDATE");
				ScanUtil.stop(1000);
				return View.ROOM_DETAIL;
			}
		}else{
			OptionService.setDate(OptionService.option);
			HasDateOption = (OptionService.getSdate() != null && OptionService.getEdate() != null);
			if(roomDao.checkAvail(roomDao.getRoomResv())){
				System.out.println("예약가능합니다!");
				System.out.println("가격 : " + OptionService.setSum());
				ReservationDao.insertResv(HasDateOption);
				return View.RESERVATION;
			}else{
				System.out.println("예약불가합니다!");
				ScanUtil.stop(1000);
				OptionService.option.remove("SDATE");
				OptionService.option.remove("EDATE");
				return View.ROOM_DETAIL;
			}
		}
		case 0: return View.ROOM_LIST;
		}
		return View.ROOM_DETAIL;
	}
	
	//숙박업주 관리용

	public static int roomManage() {
		System.out.println("===" + LodgeService.getLodgeName() + "===");
		
		lodgeDao.getRoomList();
		
		Map<String, Object> tmpRoom = null;
		
		System.out.println("1.객실추가\t2.객실조회\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		//숙소선택
		case 1:
			roomAdd();
			return View.ROOM_MANAGE;
		case 2: tmpRoom = roomDao.searchRoom();
			if (tmpRoom == null){
				System.out.println("해당 객실이 존재하지 않습니다.");
				ScanUtil.stop(1000);
				return View.ROOM_MANAGE;
			}else{
				currentRoom = tmpRoom;
				return View.MY_ROOM_DETAIL;
			} 
		case 0: return View.LODGE_MANAGE;
		}
		
		return 0;
	}
	
	public static int roomAdd(){
		roomDao.addRoom();
		return View.ROOM_MANAGE;
	}
	
	
	
	public static int roomModify(){
		roomDao.modifyRoom();
		return View.ROOM_DETAIL;
	}
	
	public static int roomDelete(){
		roomDao.deleteRoom();
		return View.ROOM_MANAGE;
	}
	
	public static int myRoomDetail(){
		roomDao.selectRoom(currentRoom);
		
		System.out.println("1.수정하기\t2.삭제하기\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch(input){
		case 1: 
			roomModify();
			return View.ROOM_MANAGE;
		case 2:
			roomDelete();
			return View.ROOM_MANAGE;
		case 0: return View.LODGE_MANAGE;
		}
		return 0;
	}
	
	public static int getPrice() {
		if(currentRoom == null){
			System.out.println("객실선택 안됨");
			return -1;
		}else{
			return (int)currentRoom.get("RO_N_PRICE");
		}
	}
}
