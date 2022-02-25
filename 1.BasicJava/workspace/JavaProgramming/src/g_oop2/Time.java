package g_oop2;

public class Time {
	private int hour;
	private int minute;
	private int second;
	
	public int getHour() {
		return hour;
	}
	
	public void setHour(int hour) {
		
		this.hour = hour % 24;
	}
	
	public int getMinute() {
		return minute;
	}
	
	public void setMinute(int minute) {
		if(minute >= 60)	setHour(hour + 1);
		this.minute = minute % 60;
	}

	public int getSecond() {
		return second;
	}
	
	public void setSecond(int second) {
		if(second >= 60)	setMinute(minute + 1);
		this.second = second % 60;
	}
	
	//getter : get으로 시작하는 메서드, 변수의 값을 읽어오는 역할
	//setter : set으로 시작하는 메서드, 변수에 값을 저장하는 역할
	
	String getTime(){
		return hour + ":" + minute + ":" + second;
	}
	void clock(){
		while(true){
			System.out.println(getTime());
			stop(10);
			setSecond(second + 1);
		}
	}
	private void stop(int interval){
		try {
			Thread.sleep(interval);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
