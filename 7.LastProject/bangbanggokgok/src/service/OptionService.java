package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import util.ScanUtil;
import util.View;
import dao.OptionDao;
import dao.RoomDao;

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
		OptionDao.lodgeQuery = new String();
		OptionDao.roomQuery = new String();
		option = new HashMap<String, Object>();

		while (true) {
			System.out
					.println("1.지역설정\t2.숙박시설종류 설정\t3.평점필터\t4.가격필터\n"
							+ "5.날짜설정\t6.조건확정\t0.돌아가기");
			int input = ScanUtil.nextInt();
			switch (input) {
			case 1:
				setRegion(option);
				break;
			case 2:
				setType(option);
				break;
			case 3:
				setRating(option);
				break;
			case 4:
				setPrice(option);
				break;
			case 5:
				setDate(option);
				break;
			case 6:
				OptionDao.convertQuery(option);
				return View.LODGE_LIST;
			case 0:
				return View.SET_REGION;
			}

		}
	}

	private static void setType(Map<String, Object> option2) {
		System.out.println("1.호텔\t2.모텔\t3.펜션\t4.리조트\t5.게스트하우스");
		System.out.print("숙박시설 종류 선택>");
		int input = 0;
		input = ScanUtil.nextInt();
		option.put("TYPE", input);
	}

	public static int setSum() {
		if (getSdate() == null || getEdate() == null) {
			System.out.println("날짜설정 안됨");
			return -1;
		} else if (RoomService.currentRoom == null) {
			System.out.println("방 설정 안됨");
			return -1;
		} else {
			option.put(
					"SUM",
					RoomService.getPrice()
							* RoomDao.dateDiff(getSdate(), getEdate()));
			return (int) option.get("SUM");
		}
	}

	public static int getSum() {
		if (option.get("SUM") == null) {
			System.out.println("총 가격 없음");
			return 0;
		} else {
			return (int) option.get("SUM");
		}
	}

	public static String getSdate() {
		if (option.get("SDATE") == null) {
			return null;
		} else {
			return (String) option.get("SDATE");
		}
	}

	public static String getEdate() {
		if (option.get("EDATE") == null) {
			return null;
		} else {
			return (String) option.get("EDATE");
		}
	}

	public static int getCap() {
		if (option.get("CAPACITY") == null) {
			return 0;
		} else {
			return (int) option.get("CAPACITY");
		}
	}

	public static int getCity() {
		if (option.get("CITY") == null) {
			return 0;
		} else {
			return (int) option.get("CITY");
		}
	}

	public static int getProv() {
		if (option.get("PROV") == null) {
			return 0;
		} else {
			return (int) option.get("PROV");
		}
	}

	public static int getRating() {
		if (option.get("RATING") == null) {
			return 0;
		} else {
			return (int) option.get("RATING");
		}
	}

	public static int getMinPrice() {
		if (option.get("MIN_PRICE") == null) {
			return 0;
		} else {
			return (int) option.get("MIN_PRICE");
		}
	}

	public static int getMaxPrice() {
		if (option.get("MAX_PRICE") == null) {
			return 0;
		} else {
			return (int) option.get("MAX_PRICE");
		}
	}

	public static int setRegion() {
		
		OptionService.option.clear();
		if (setRegion(option) == View.HOME) {
			return View.HOME;
		}

		OptionDao.convertQuery(option);

		return View.LODGE_LIST;
	}

	public static int setRegion(Map<String, Object> option) {
		int input = 0;
		List<Map<String, Object>> cities = null;
		List<Map<String, Object>> provs = null;

		System.out.println("[0번을 홈화면으로 돌아갑니다.]");
		cities = optionDao.cityList();
		showCities(cities);
		System.out.println("도시선택>");
		input = ScanUtil.nextInt();

		if (input == 0)
			return View.HOME;
		else if (input < 0 || 9 < input) {
			System.out.println("잘못 누르셨습니다.");
			return View.HOME;
		}
		
		option.put("CITY", input);

		System.out.println("[0번을 홈화면으로 돌아갑니다.]");
		provs = optionDao.provList(input);
		showProvs(provs);
		System.out.println("구 선택>");
		input = ScanUtil.nextInt();
		if (input == 0)
			return View.HOME;
		else if (input < 0 || 9 < input) {
			System.out.println("잘못 누르셨습니다.");
			return View.HOME;
		}
		option.put("PROV", input);

		return View.SET_REGION;
	}

	public static void showProvs(List<Map<String, Object>> provs) {
		//선택지 출력화면 수정
		int i = 0;
		for (Map<String, Object> walk : provs) {
			System.out.print(walk.get("PROV_CODE") + ": " + walk.get("PROV_NM")
					+ "\t");
			i++;
			if(i % 5 == 0){
				System.out.println();
			}
		}
		System.out.println();
	}

	public static void showCities(List<Map<String, Object>> cities) {
		for (int i = 1; i <= cities.size(); i++) {
			System.out.print(cities.get(i - 1).get("CITY_CODE") + ": "
					+ cities.get(i - 1).get("CITY_NM") + "\t");
			if (i % 3 == 0)
				System.out.println();
		}

	}

	public static void setCapacity(Map<String, Object> option) {
		Map<String, Object> roCap = RoomDao.getCapacity();
		int minCap = (int)roCap.get("MINCAP");
		int maxCap = (int)roCap.get("MAXCAP");
		while(true){
			System.out.print("인원수 입력>");
			int input = ScanUtil.nextInt();
			if(input < minCap || input > maxCap){
				System.out.println("다시 입력해주세요");
				continue;
			}else{
				option.put("CAPACITY", input);
				break;
			}
		}
	}

	public static void setRating(Map<String, Object> option) {
		while(true){
			System.out.print("최소평점 입력(0~5 정수)>");
			int input = ScanUtil.nextInt();
			if(input < 0 || input > 5){
				System.out.println("0~5사이의 정수를 입력하세요");
				continue;
			}
			option.put("RATING", input);
			break;
		}
	}

	public static void setPrice(Map<String, Object> option) {
		int input = 0;
		System.out.print("최소가격 입력>");
		input = ScanUtil.nextInt();
		option.put("MIN_PRICE", input);
		System.out.print("최대가격 입력>");
		input = ScanUtil.nextInt();
		option.put("MAX_PRICE", input);
	}

	// validDate 함수 추가
		public static void setDate(Map<String, Object> option) {
			String input = null;
			option.remove("SDATE");
			option.remove("EDATE");
			while (option.get("SDATE") == null || option.get("EDATE") == null) {
				System.out.print("입실일입력(yyyymmdd)>");
				input = validDate(ScanUtil.nextLine());
				option.put("SDATE", input);
				if(option.get("SDATE") == null) continue;
				System.out.print("퇴실일입력(yyyymmdd)>");
				input = validDate(ScanUtil.nextLine());
				option.put("EDATE", input);
				if(option.get("EDATE") == null) continue;
			}
		}

		// 날짜 입력 정규식 추가
		public static String validDate(String input) {
			String str = null;
			String rex_date = "\\d{8}$";
			Pattern p = Pattern.compile(rex_date);
			Matcher m = p.matcher(input);
			if (m.matches()) {
				str = input;
			} else {
				System.out.println("잘못 입력하셨습니다.\n다시 시도해주세요");
			}

			return str;
		}
}
