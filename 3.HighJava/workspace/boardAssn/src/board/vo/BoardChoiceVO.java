package board.vo;

public class BoardChoiceVO {
	
	private String choiceName;
	private String connectedView;
	
	public String getChoiceName() {
		return choiceName;
	}

	public String getConnectedView() {
		return connectedView;
	}

	public BoardChoiceVO(String choiceName, String connectedView){
		this.choiceName = choiceName;
		this.connectedView = connectedView;
	}
}
