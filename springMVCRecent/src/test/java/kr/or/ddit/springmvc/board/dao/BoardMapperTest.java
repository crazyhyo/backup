package kr.or.ddit.springmvc.board.dao;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.ddit.springmvc.board.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={
	"/egovframework/spring/context-aspect.xml"
   ,"/egovframework/spring/context-common.xml"
   ,"/egovframework/spring/context-datasource.xml"
   ,"/egovframework/spring/context-mapper.xml"
})
public class BoardMapperTest {
	protected Logger logger = LoggerFactory.getLogger(this.getClass().getName());
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	@Test
	public void testInit(){
		Assert.assertNotNull(boardMapper);
	}
	
//	@Test
	public void testCreate(){
		BoardVO boardVO = new BoardVO();
		
		for(int i=0;i<500;i++){
			boardVO.setTitle("JUnit 제목"+(i+1)+"번째");
			boardVO.setContents("JUnit 내용입니다."+(i+1)+"번째");
			boardVO.setWriter("테스터");
			boardVO.setUserPassword("123457");
			boardVO.setOpenYn("Y");
			
			try {
				boardMapper.create(boardVO);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				Assert.fail();
			}
		}
		
		Assert.assertNotNull(boardVO.getBoardSn());
	}
	
//	@Test
	public void testUpdate(){
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("JUnit 수정");
		boardVO.setContents("JUnit 내용입니다. 수정했습니다.");
		boardVO.setWriter("관리자");
		boardVO.setUserPassword("223322");
		boardVO.setOpenYn("N");
		boardVO.setBoardSn("1");
		
		try {
			int cnt = boardMapper.update(boardVO);
			Assert.assertTrue(cnt>0);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			Assert.fail();
		}
	}
	
//	@Test
	public void testDelete(){
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardSn("2");
		
		try {
			int cnt = boardMapper.delete(boardVO);
			Assert.assertTrue(cnt>0);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			Assert.fail();
		}
	}
	
//	@Test
	public void testRetrieve(){
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardSn("3");
		
		try {
			BoardVO retrieveBoardVO = boardMapper.retrieve(boardVO);
			Assert.assertNotNull(retrieveBoardVO);
			System.out.println(retrieveBoardVO);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			Assert.fail();
		}
	}
	
	
	@Test
	public void testRetrieveList(){
		BoardVO boardVO = new BoardVO();
		boardVO.setSearchCondition("1");
		boardVO.setSearchKeyword("2");
		
		try {
			List<BoardVO> list = boardMapper.retrieveList(boardVO);
			Assert.assertTrue(list.size()>0);
			for(BoardVO listBoardVO:list){
				logger.info(listBoardVO.toString());
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			Assert.fail();
		}
	}
	
	
}
