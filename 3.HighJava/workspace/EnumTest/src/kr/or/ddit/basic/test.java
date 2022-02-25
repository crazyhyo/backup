package kr.or.ddit.basic;

public class test {

	public enum Planet {
		수성(2439), 금성(6052), 지구(6371), 화성(3390), 
		목성(69911), 토성(58232), 천왕성(25362), 해왕성(24622);

		private int radius;

		// 생성자
		Planet(int data) {
			this.radius = data;
		}

		// 값을 반환
		public int getRadius() {
			return radius;
		}
	}

	public static void main(String[] args) {

		Planet[] planetArr = Planet.values();
		for (Planet p : planetArr) {
			double area = Math.round(4 * 3.14 * p.getRadius() * p.getRadius());
			System.out.println(p.name() + "의 면적  : " + area);
		}

	}


}
