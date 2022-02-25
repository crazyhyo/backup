package dao;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import service.LodgeService;
import service.MemberService;
import service.OptionService;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;

public class ReservationDao {
	private ReservationDao(){}
	private static ReservationDao instance;
	public static ReservationDao getInstance(){
		if(instance == null){
			instance = new ReservationDao();
		}
		return instance;
	}
	
	private static JDBCUtil jdbc = JDBCUtil.getInstance();
	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // yyyy-MM-dd 양식으로 변경
	
	public static void insertResv(boolean hasDateOption) {
		
		int sum = 0;
		
		if(!hasDateOption){
			OptionService.setDate(OptionService.option);
		}
		OptionService.setCapacity(OptionService.option);
		sum = OptionService.setSum();
	}

	//업주전용 - 예약자리스트
	
	public int bookerList(){
		
		String sql = " SELECT * "
				+ "		 FROM RESERVATION "
				+ "     WHERE LOD_NO = " + LodgeService.getLodgeNo();
		
		List<Map<String, Object>> bookerList = jdbc.selectList(sql);
		
		if(bookerList.size() == 0) {
			System.out.println("예약이 없습니다.");
		}else {
			for(Map<String, Object> walk : bookerList){
				System.out.print("예약번호 :" + walk.get("RESV_NO") + " ");
				System.out.print("주문번호:" + walk.get("ORD_NO") + " ");
				System.out.println("방번호:" + walk.get("RO_NO"));
				System.out.println("입실일:" + "\t" + sdf.format(walk.get("RESV_SDATE")));
				System.out.println("퇴실일:" + "\t" + sdf.format(walk.get("RESV_EDATE")));
				System.out.print("예약상태구분코드:" + walk.get("RESV_CODE") + " ");
				System.out.print("인원수:" +  walk.get("RESV_CAP") + "명 ");
				System.out.println("금액합계:" + walk.get("RESV_SUM") + "원");
				System.out.println("▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃");
				
				}

			System.out.println("0. 돌아가기");
			int input = ScanUtil.nextInt();
			
			switch (input) {
			case 0:
				return View.LODGE_MANAGE;
			}
		}
		return 0;
	}
	
	//MyResvList 추가
	public static List<Map<String, Object>> MyResvList(){
		
		String sql = " SELECT A.RESV_NO, C.LOD_NM, A.RO_NO, A.RESV_SDATE,"
				+ "           A.RESV_EDATE, B.ORD_DATE, A.RESV_CAP, A.RESV_SUM"
				+ "		 FROM RESERVATION a, tbl_order b, LODGE C"
				+ "     WHERE a.ord_no = b.ord_no"
				+ "			  and A.LOD_NO = C.LOD_NO"
				+ "		      and b.mem_no = " + MemberService.getMemNo();
		
		List<Map<String, Object>> myResvList = jdbc.selectList(sql);
		
		if(myResvList.size() == 0) {
			System.out.println("예약이 없습니다.");
			return null;
		}else {
			System.out.println("내 예약정보 :");
			return myResvList;
		}
	}
	
}
