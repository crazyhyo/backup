package kr.or.ddit.basic;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/upload2")
@MultipartConfig(fileSizeThreshold=1024 * 1024,
                    maxFileSize=1024 * 1024 * 5,
                    maxRequestSize=1024 * 1024 * 5 * 5)
public class FileUploadServlet2 extends HttpServlet{
	
	private static final String UPLOAD_DIR = "upload_files";

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if(!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            String fileName = "";
            for(Part part : req.getParts()) {
                fileName = getFileName(part);
                // 폼 필드가 아니거나 파일이 비어있지 않은 경우
                if(fileName != null && !fileName.equals("")) {
                    part.write(uploadPath + File.separator + fileName); // 파일 저장
                    System.out.println(uploadPath + File.separator + fileName + "업로드 완료!");
                }

            }

        } catch(FileNotFoundException ex) {
            ex.printStackTrace();
        }

        System.out.println("파라미터 값 : " + req.getParameter("sender"));

        resp.setContentType("text/html");
        resp.getWriter().println("업로드 완료!");
	}

    /**
     * Part객체를 파싱하여 파일 이름 추출하기
     * @param part Part 타입의 객체
     * @return 파일명 : 파일명이 존재하지 않으면 null 리턴함(폼필드)
     */
    private String getFileName(Part part){
    /*
     * Content-Disposition 헤더에 대하여...
     * 1. response header에 사용되는 경우... ex)파일 다운로드
     * Content-Disposition: inline(default)     //  다운로드한 파일을 브라우저가 읽어서 보여줌, 코알라예제
     * Content-Disposition: attachment          => 파일 다운로드
     * Content-Disposition: attachment; filename="filename.jpg" => filename.jpg 이름으로 다운로드
     *
     * 2. multipart body를 위한 헤더정보로 사용되는 경우... ex)파일 업로드
     * Content-Disposition: form-data
     * Content-Disposition: form-data; name="fieldName" <input type="file" name="filedName">의 name에 해당
     * Content-Disposition: form-data; name="fieldName"; filename="filename.jpg"
     */
        for(String content : part.getHeader("Content-Disposition").split(";")){

            if(content.trim().startsWith("filename")){
                return content.substring(content.indexOf("=") + 1).trim().replace("\"","");
            }
        }
        return null;
    }

}
