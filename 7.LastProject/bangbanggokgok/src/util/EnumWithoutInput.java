package util;

public enum EnumWithoutInput {

	   HOME("HOME") 				,
	   LOGIN("LOGIN") 				,
	   JOIN("JOIN") 				,
	   SET_REGION("SET_REGION") 			,
	   RESERVATION_INFO("RESERVATION_INFO") 	,
	   MY_INFO_UPDATE("MY_INFO_UPDATE") 		,
	   BOOKER_INFO("BOOKER_INFO") 			,
	   SALES_MANAGE("SALES_MANAGE") 		,
	   RESERVATION_INFO_NON("RESERVATION_INFO_NON") ,
	   PAYMENT_ONE("PAYMENT_ONE")          ,
	   PAYMENT_CART("PAYMENT_CART")         ;
		
	String title;
	
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	private EnumWithoutInput(String title) {
		this.title = title;
	}
	
	public void showTest() {
		System.out.println();
	}
		

}
