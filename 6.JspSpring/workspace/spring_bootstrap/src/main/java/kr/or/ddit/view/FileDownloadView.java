package kr.or.ddit.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.web.servlet.View;

import com.jsp.utils.MakeFileName;

public class FileDownloadView implements View{

	private String contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE; //
	
	@Override
	public String getContentType() {
		return this.contentType;
	}

	@Override
	public void render(Map<String, ?> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		// Map<String, ?> : runtime에 결정된 ?타입으로 된 맵
		
		String savedPath = (String) model.get("savedPath");
		String fileName = (String) model.get("fileName");
		
		File downloadFile = new File(savedPath + File.separator + fileName);
		FileInputStream inStream = new FileInputStream(downloadFile);
		
		ServletContext context = request.getServletContext();
		String mimeType = context.getMimeType(downloadFile.getName()); // 브라우저가 열 수 있는 형식(pdf, jpg, png...)이면 저장하지 말고 브라우저로 열어라
		if(mimeType == null) {
			mimeType = "application/octet-stream";
		}
		response.setContentType(mimeType);
		response.setContentLength((int)downloadFile.length());
		
		String headerKey = "Content-Disposition";
		
		String sendFileName = MakeFileName.parseFileNameFromUUID(fileName, "\\$\\$");
		
		String header = request.getHeader("User-Agent");
		if(header.contains("MSIE")) {
			sendFileName = URLEncoder.encode(sendFileName, "utf-8");
		}else {
			sendFileName = new String(sendFileName.getBytes("utf-8"), "ISO-8859-1");
		}
		
		String headerValue = "attachment; filename" + sendFileName;
		
		response.setHeader(headerKey, headerValue);
		
		OutputStream outStream = response.getOutputStream();
		
		byte[] buffer = new byte[4096];
		int bytesRead = -1;
		while((bytesRead = inStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, bytesRead);
		}
		
		outStream.close();
		inStream.close();
		
	}

}
