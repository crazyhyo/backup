package coingameIO;

public enum View {
	START(),
	MAIN("매매", "잔고", "차트", "다음날"),
	TRADE("매수", "매도"),
	BUY("비트코인", "리플", "도지코인"),
	SELL("비트코인", "리플", "도지코인"),
	ACCOUNT(),
	BUY_BITCOIN(),
	BUY_RIPPLE(),
	BUY_DOGECOIN(),
	SELL_BITCOIN(),
	SELL_RIPPLE(),
	SELL_DOGECOIN(),
	CHART("비트코인", "리플", "도지코인", "뉴스보기"),
	CHART_BITCOIN(),
	CHART_RIPPLE(),
	CHART_DOGECOIN(),
	CHART_NEWS();
	
	String[] choices;
	View[] connectedViews;
	
	public int printChoices() {
		String str = "";
		for(int i = 1; i <= choices.length; i++) {
			str += i + "." + choices[i-1] + "\t";
		}
		str += (choices.length + 1) + ".돌아가기";
		
		System.out.println(str);
		
		return choices.length + 1;
	}
	
	View(String...choices){
		this.choices = choices;
	}
	
}