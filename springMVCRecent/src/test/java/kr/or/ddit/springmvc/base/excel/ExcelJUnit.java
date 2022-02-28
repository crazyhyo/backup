package kr.or.ddit.springmvc.base.excel;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.ddit.springmvc.board.dao.BoardMapper;
import kr.or.ddit.springmvc.board.vo.BoardVO;

//http://jxls.sourceforge.net/index.html 참고
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/egovframework/spring/context-aspect.xml"
		, "/egovframework/spring/context-common.xml"
		, "/egovframework/spring/context-datasource.xml"
		, "/egovframework/spring/context-properties.xml"
		, "/egovframework/spring/context-mapper.xml"
		, "/egovframework/spring/context-transaction.xml"
//		, "/egovframework/spring/context-security.xml"
})
public class ExcelJUnit {
	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelJUnit.class);
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	@Test
	public void testCreate(){
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		BoardVO paramBoardVO = new BoardVO();
		List<BoardVO> list;
		
		InputStream is = null;
		OutputStream os = null;
		
		try {
			list = boardMapper.retrieveList(paramBoardVO);
			modelMap.put("list", list);
		
			File outFile = new File("c:/temp/test.xlsx");
	        
			
			is = ExcelJUnit.class.getResourceAsStream("template_sample.xlsx");
		    os = new BufferedOutputStream(new FileOutputStream(outFile));
		    Context context = new Context();
		    context.putVar("list", list);
		    JxlsHelper.getInstance().processTemplate(is, os, context);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			Assert.fail();
		}finally{
			try{
        	if (os != null) os.close();
        	if (is != null) is.close();
			}catch(Exception e){
				e.printStackTrace();
				Assert.fail();
			}
        }
		Assert.assertTrue(true);
	}
}
