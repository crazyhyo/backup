package kr.or.ddit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.jsp.utils.MakeFileName;


@RestController
//	이 컨트롤러의 모든 메서드에 @ResponseBody 어노테이션을 부여한다. = 내보내는 모든 Object를 Serialize해서 내보내겠다.
//	내보내는 것을 InternalViewResolver가 받지 않는다.
//	대신 redirect와 forward가 불가능하다.
public class SummernoteController {

	@Resource(name="imgPath")
	private String imgPath;
	
	@RequestMapping("/uploadImg")
	public ResponseEntity<String> uploadImg(MultipartFile file, HttpServletRequest request)
					throws Exception{
		
		ResponseEntity<String> result = null;
		
		int fileSize = 5 * 1024 * 1024;
		
		if(file.getSize() > fileSize) {
			return new ResponseEntity<String>("용량 초과입니다.", HttpStatus.BAD_REQUEST);
		}
		String savePath = imgPath.replace("/", File.separator);
		String fileFormat = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
		String fileName = MakeFileName.toUUIDFileName("." + fileFormat, "");
		
		File saveFile = new File(savePath, fileName);
		saveFile.mkdirs();
		try {
			file.transferTo(saveFile);
			result = new ResponseEntity<String>(request.getContextPath() + "/getImg.do?fileName=" + fileName, HttpStatus.OK);
		} catch(IOException e) {
			result = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	@RequestMapping("/getImg")
	public ResponseEntity<byte[]> getImg(String fileName, HttpServletRequest request) throws Exception{
		
		ResponseEntity<byte[]> entity = null;
		
		String savePath = imgPath.replace("/", File.separator);
		File sendFile = new File(savePath, fileName);
		
		InputStream in = null;
		try {
			in = new FileInputStream(sendFile);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		} finally {
			in.close();
		}
		return entity;
	}
	
	@RequestMapping("/deleteImg")
	public ResponseEntity<String> delete(@RequestBody Map<String, String> data) throws Exception{
		
		// JSON data를 받아오는 방법(spring)
		
		ResponseEntity<String> result = null;
		
		String savePath = imgPath.replace("/", File.separator);
		String fileName = data.get("fileName");
		
		File target = new File(savePath + File.separator + fileName);
		
		System.out.println(savePath + fileName);
		
		if(!target.exists()) {
			result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			
		} else {
			try {
				target.delete();
				result = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				System.out.println("try");
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<String>("Fail", HttpStatus.INTERNAL_SERVER_ERROR);
				System.out.println("catch");
			}
		}
		return result;
	}
}
