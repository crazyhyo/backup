/*
 * Project Name		:	Bangbanggokgok
 * 
 * File Name		:	LodgeService.java
 * Revision			:	0.1
 * Date				:	2021.08.15
 * Author			:	Lee KwangHyo
 * 
 */

/*
 * public static int getLodgeNo() : O
 * public static String getLodgeName() : O
 * public static int roomList() : O
 * public static void showRoomList() : O
 * public static int lodgeList() : O
 * lodgeAdd(건물추가) : x
 * lodgeModify(건물수정) : x
 * lodgeDelete(건물삭제) : x
 * 
 */

package service;

import java.util.List;
import java.util.Map;

import util.JDBCUtil;
import util.ScanUtil;
import util.View;
import controller.Controller;
import dao.LodgeDao;
import dao.RoomDao;

public class LodgeService {

	public static Map<String, Object> currentLodge = null;
	public static LodgeDao lodgeDao = LodgeDao.getInstance();
	public static RoomDao roomDao = RoomDao.getInstance();

	public static int getLodgeNo() {

		if (currentLodge != null) {
			return (int) currentLodge.get("LOD_NO");
		} else {
			System.out.println("현재 선택된 숙소가 없습니다.");

		}
		return -1;
	}

	public static String getLodgeName() {
		if (currentLodge != null) {
			return (String) currentLodge.get("LOD_NM");
		} else {
			System.out.println("현재 선택된 숙소가 없습니다.");
		}
		return null;
	}

	public static int roomList() {
		System.out.println("===" + LodgeService.getLodgeName() + "===");
		showRoomList();

		Map<String, Object> tmpRoom = null;

		while (true) {
			System.out.println("1.객실선택\t2.날짜입력\t3.공지사항\t4.후기 게시판\t0.돌아가기");

			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				tmpRoom = roomDao.searchRoom();
				if (tmpRoom == null) {
					System.out.println("해당하는 객실이 없습니다.");
					ScanUtil.stop(1000);
					return View.ROOM_LIST;
				} else {
					RoomService.currentRoom = tmpRoom;
					return View.ROOM_DETAIL;
				}
				// 변경
			case 2:
				OptionService.setDate(OptionService.option);
				return View.ROOM_LIST;
			case 3:
				return View.NOTICE_BOARD_LIST;
			case 4:
				return View.REVIEW_BOARD_LIST;
			case 0:
				return View.LODGE_LIST;
			default:
				System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
				continue;
			}
		}

	}

	public static void showRoomList() {
		List<Map<String, Object>> getRoomList = lodgeDao.getRoomList();

		if (getRoomList.size() == 0) {
			System.out.println("해당 숙소에 등록된 방이 없습니다.");
			ScanUtil.stop(1000);
		} else {

			for (Map<String, Object> walk : getRoomList) {
				System.out.println(walk.get("NO"));
				System.out.println(walk.get("TYPE"));
				System.out.println(walk.get("PRICE"));
				System.out
						.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
			}
		}
	}

	public static int lodgeList() {
		Map<String, Object> tmpLodge = null;

		if(lodgeDao.showList() == -1){
			System.out.println();
			return View.SET_REGION;
		}
		
		System.out.println("1.숙소선택\t2.조건설정\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch (input) {
		// 숙소선택
		case 1:
			tmpLodge = lodgeDao.searchLodge();
			if (tmpLodge == null) {
				System.out.println("해당 숙소가 존재하지 않습니다.");
				ScanUtil.stop(1000);
				return View.LODGE_LIST;
			} else {
				currentLodge = tmpLodge;
				return View.ROOM_LIST;
			}
		case 2:
			return View.SET_OPTION; // 조건설정
		case 0:
			return View.SET_REGION;
		}
		return 0;
	}

	// --------------내 건물
	// 목록-------------------------------------------------------------------------------------------
	public static int myLodgeList() {
		Map<String, Object> tmpLodge = null;

		lodgeDao.showList();
		System.out.println("1.관리건물 추가\t2.건물상세\t0.돌아가기");
		int input = ScanUtil.nextInt();
		switch (input) {
		case 1:
			lodgeDao.addLodge();
			return View.MY_LODGE_LIST;
		case 2:
			tmpLodge = lodgeDao.searchLodge();
			if (tmpLodge == null) {
				System.out.println("해당 숙소가 존재하지 않습니다.");
				ScanUtil.stop(1000);
				return View.MY_LODGE_LIST;
			} else {
				currentLodge = tmpLodge;
				return View.LODGE_MANAGE;
			}
		case 0:
			return View.HOME;
		}
		return 0;
	}

	public static int lodgeAdd() {
		lodgeDao.addLodge();
		return View.LODGE_LIST;
	}

	public static int lodgeManage() {
		if (lodgeDao.selectLodge(currentLodge) == -1) {
			return View.MY_LODGE_LIST;
		} else {
			System.out.println("1.객실관리\t2.매출조회\t3.게시판관리\t4.예약자정보\n"
					+ "10.건물수정\t11.건물삭제\t0.돌아가기");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				return View.ROOM_MANAGE;
			case 2:
				return View.SALES_MANAGE;
			case 3:
				return View.BOARD_MANAGE;
			case 4:
				return View.BOOKER_INFO;
			case 10:
				lodgeDao.modifyLodge();
				return View.MY_LODGE_LIST;
			case 11:
				lodgeDao.deleteLodge();
				return View.MY_LODGE_LIST;
			case 0:
				return View.MY_LODGE_LIST;
			}
		}
		return 0;
	}

	public static int salesManage() {
		System.out.println("SALES_MANAGE");
		lodgeDao.salesManage();
		return View.LODGE_MANAGE;
	}

	public static int boardManage() {
		System.out.println("1.공지게시판\t2.리뷰게시판\t0.돌아가기 >");
		int input = ScanUtil.nextInt();

		switch (input) {
		case 1:
			return View.NOTICE_BOARD_LIST;
		case 2:
			return View.REVIEW_BOARD_LIST;
		case 0:
			return View.LODGE_MANAGE;
		}
		return 0;
	}
}