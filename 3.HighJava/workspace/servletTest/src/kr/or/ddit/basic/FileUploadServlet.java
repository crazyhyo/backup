package kr.or.ddit.basic;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/upload")
public class FileUploadServlet extends HttpServlet{
	
	private static final String UPLOAD_DIR = "upload_files";
	// 메모리 임계크기(이 크기가 넘어가면 레파지토리 위치에 임시파일로 저장됨.) 바이트단위, 3메가바이트임
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;
	// 파일 1개당 최대 크기
	private static final long MAX_FILE_SIZE = 1024 * 1024 * 40;
	// 요청 파일 최대 크기(업로드하는 파일이 복수개일 때 파일들의 총 크기제한)
	private static final long MAX_REQUEST_SIZE = 1024 * 1024 * 50;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 인코딩 타입이 multipart/form-data인 경우
		if(ServletFileUpload.isMultipartContent(req)) {
			Map<String, String> formMap = new HashMap<String, String>();
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(MEMORY_THRESHOLD);
			factory.setRepository(new File("d:/D_Other/temp"));
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setFileSizeMax(MAX_FILE_SIZE);
			upload.setSizeMax(MAX_REQUEST_SIZE);
			
			// 웹 애플리케이션 루트 디렉토리 기준 업로드 설정하기
			String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;
			System.out.println("uploadPath => " + uploadPath);
			
			File uploadDir = new File(uploadPath);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
            }

			try {
				List<FileItem> formItems =upload.parseRequest(req);
				
				if(formItems != null && formItems.size() > 0) {
					for(FileItem item : formItems) {
						if(!item.isFormField()) {	// 파일인 경우
							// 전체 경로를 제외한 파일명만 추출하기
							String fileName = new File(item.getName()).getName();
							String filePath = uploadPath + File.separator + fileName;
							File storeFile = new File(filePath);
							item.write(storeFile);	// 업로드 파일 저장
						}else {	// 폼데이터인 경우...
							// 폼필드의 값이 한글인 경우에는 해당 문자열을 적절히 변환해주어야 한다.
							formMap.put(item.getFieldName(), item.getString("UTF-8"));
							
						}
						
					}
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}
			
			for(Entry<String, String> entry : formMap.entrySet()) {
				System.out.println("파라미터 명 : " + entry.getKey());
				System.out.println("파라미터 값 : " + entry.getValue());
			}
			
			resp.setContentType("text/html");
			resp.getWriter().print("업로드 완료 됨.");
		}
	}

}
