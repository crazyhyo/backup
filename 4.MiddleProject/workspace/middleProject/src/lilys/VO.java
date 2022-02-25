package lilys;

public class VO {

	private String name = "Lily";
	private int heightCm= 190;
	private int weightKg= 80;
	
	
	public String getName() {
		System.out.println("asdf");
		return name;
	}
	public void setName(String name) {
		System.out.println("name");
		this.name = name;
	}
	public int getHeightCm() {
		return heightCm;
	}
	public void setHeightCm(int heightCm) {
		
		System.out.println(heightCm);
		this.heightCm = heightCm;
	}
	public int getWeightKg() {
		return weightKg;
	}
	public void setWeightKg(int weightKg) {
		this.weightKg = weightKg;
	}
	
	public void conflictTest() {
		System.out.println("confilt");
	}
}
