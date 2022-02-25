package kr.or.ddit.basic;


public class PlanetArea {
	public enum Planet{
		Mercury(2439),
		Venus(6052),
		Earth(6371),
		Mars(3390),
		Jupiter(69911),
		Saturn(58232),
		Uranus(25362),
		Neptune(24622);
		
		private double radius;
		
		Planet(double radius){
			this.radius = radius;
		}
		
		public double getArea() {
			return 4 * Math.PI * radius * radius;
		}
		
	}
	public static void main(String[] args) {
		Planet mercury = Planet.Mercury;
		Planet venus = Planet.Venus;
		Planet earth = Planet.Earth;
		Planet mars = Planet.Mars;
		Planet jupiter= Planet.Jupiter;
		Planet saturn = Planet.Saturn;
		Planet uranus = Planet.Uranus;
		Planet neptune = Planet.Neptune;
		System.out.println(mercury.name() + "의 표면적 : " + String.format("%.2f", mercury.getArea()));
		System.out.println(venus.name() + "의 표면적 : " + venus.getArea());
		System.out.println(earth.name() + "의 표면적 : " + earth.getArea());
		System.out.println(mars.name() + "의 표면적 : " + mars.getArea());
		System.out.println(jupiter.name() + "의 표면적 : " + jupiter.getArea());
		System.out.println(saturn.name() + "의 표면적 : " + saturn.getArea());
		System.out.println(uranus.name() + "의 표면적 : " + uranus.getArea());
		System.out.println(neptune.name() + "의 표면적 : " + neptune.getArea());
		
		System.out.println();
		
		System.out.println("파이값입니다" + Math.PI);
		
		Planet[] planets = Planet.values();
		for(Planet p : planets) {
			System.out.println(p.name() + "의 반지름 : " + String.format("%.0f", p.radius) + "㎞");
			System.out.println("표면적 : " + String.format("%.0f", p.getArea()) + "㎢");
		}
	}
}