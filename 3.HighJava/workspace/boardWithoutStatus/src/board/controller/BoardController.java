package board.controller;

import board.vo.BoardScene;

public class BoardController {
	
	private BoardScene scene;
	
	BoardController(){
		scene = BoardScene.BOARD_LIST;
	}
	
	public static void main(String[] args) {
		new BoardController().start();
	}

	private void start() {
		while(true) {
			scene = scene.act();
		}
	}

}
