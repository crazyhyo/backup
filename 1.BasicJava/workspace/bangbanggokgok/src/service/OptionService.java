package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.OptionDao;

public class OptionService {
	
	private OptionService() {
	}

	private static OptionService instance;

	public static OptionService getInstance() {
		if (instance == null) {
			instance = new OptionService();
		}
		return instance;
	}

	private static OptionDao optionDao = OptionDao.getInstance();
	
	public static Map<String, Object> option = new HashMap<String, Object>();

	
	public static int setOption() {
		System.out.println("SET_OPTION");
		OptionDao.lodgeQuery = new String();
		OptionDao.roomQuery = new String();
		option = new HashMap<String, Object>();
		
		System.out.println(OptionDao.lodgeQuery);
		System.out.println(OptionDao.roomQuery);
		
		while(true){
			System.out.println("option : " + option);
			System.out.println("1.지역설정\t2.인원설정\t3.날짜설정\t4.평점필터\t5.가격필터\t6.조건확정\n"
					+ "7.숙박시설종류 설정\t8.temp101.테스트\t0.돌아가기");
			int input = ScanUtil.nextInt();
			switch(input){
				case 1:	setRegion(option); break;
				case 2: setCapacity(option); break;
				case 3: setDate(option); break;
				case 4:	setRating(option); break;
				case 5: setPrice(option); break;
				case 6:
					OptionDao.convertQuery(option);
					System.out.println(OptionDao.lodgeQuery);
					System.out.println(OptionDao.roomQuery);
					
					
					
					return View.LODGE_LIST;
				case 7: break;
				case 8: break;
				case 101: return View.TEST;
				case 0: return View.EXIT;
			}
		
		}
	}
	private static void calcPrice(Map<String, Object> option) {
//		option.put("RESV_PRICE", 3);
	}
	
	public static String getSdate(){
		if(option.get("SDATE") == null){
			System.out.println("입실일 미설정");
			return null;
		}else{
			return (String)option.get("SDATE");
		}
	}
	public static String getEdate(){
		if(option.get("EDATE") == null){
			System.out.println("퇴실일 미설정");
			return null;
		}else{
			return (String)option.get("EDATE");
		}
	}
	public static int getCap(){
		if(option.get("CAPACITY") == null){
			System.out.println("인원수 미설정");
			return 0;
		}else{
			return (int)option.get("CAPACITY");
		}
	}
	public static int getCity(){
		if(option.get("CITY") == null){
			System.out.println("시 미설정");
			return 0;
		}else{
			return (int)option.get("CITY");
		}
	}
	public static int getProv(){
		if(option.get("PROV") == null){
			System.out.println("구 미설정");
			return 0;
		}else{
			return (int)option.get("PROV");
		}
	}
	public static int getRating(){
		if(option.get("RATING") == null){
			System.out.println("최소평점 미설정");
			return 0;
		}else{
			return (int)option.get("RATING");
		}
	}
	public static int getMinPrice(){
		if(option.get("MIN_PRICE") == null){
			System.out.println("최소가격 미설정");
			return 0;
		}else{
			return (int)option.get("MIN_PRICE");
		}
	}
	public static int getMaxPrice(){
		if(option.get("MAX_PRICE") == null){
			System.out.println("최대가격 미설정");
			return 0;
		}else{
			return (int)option.get("MAX_PRICE");
		}
	}
	
	public static int setRegion() {
		
		
		return 0;
	}
	
	public static void setRegion(Map<String, Object> option) {
		int input = 0;
		List<Map<String, Object>> cities = null;
		List<Map<String, Object>> provs = null;
		
		System.out.print("도시선택>");
		cities = optionDao.cityList();
		showCities(cities);
		input = ScanUtil.nextInt();
		option.put("CITY", input);
		
		System.out.print("구 선택>");
		provs = optionDao.provList(input);
		showProvs(provs);
		input = ScanUtil.nextInt();
		option.put("PROV", input);
		
	}
	
	private static void showProvs(List<Map<String, Object>> provs) {
		for(Map<String, Object> walk : provs){
			System.out.print(walk.get("PROV_CODE") + ": " + walk.get("PROV_NM") + "\t");
		}
		System.out.println();
	}
	private static void showCities(List<Map<String, Object>> cities) {
		for(Map<String, Object> walk : cities){
			System.out.print(walk.get("CITY_CODE") + ": " + walk.get("CITY_NM") + "\t");
		}
		System.out.println();
		
	}
	private static void setCapacity(Map<String, Object> option){
		System.out.print("인원수 입력>");
		int input = ScanUtil.nextInt();
		option.put("CAPACITY", input);
	}
	
	private static void setRating(Map<String, Object> option){
		System.out.print("최소평점 입력(0~5 정수)>");
		int input = ScanUtil.nextInt();
		option.put("RATING", input);
	}
	
	private static void setPrice(Map<String, Object> option){
		int input = 0;
		System.out.print("최소가격 입력>");
		input = ScanUtil.nextInt();
		option.put("MIN_PRICE", input);
		System.out.print("최대가격 입력>");
		input = ScanUtil.nextInt();
		option.put("MAX_PRICE", input);
	}
	
	private static void setDate(Map<String, Object> option){
		String input = null;
		System.out.print("입실일입력(yyyymmdd)>");
		input = ScanUtil.nextLine();
		option.put("SDATE", input);
		System.out.print("퇴실일입력(yyyymmdd)>");
		input = ScanUtil.nextLine();
		option.put("EDATE", input);
	}
}
