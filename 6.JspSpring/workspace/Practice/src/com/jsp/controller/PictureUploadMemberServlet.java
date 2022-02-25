package com.jsp.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;

import com.jsp.exception.NotMultipartFormDataException;
import com.jsp.utils.GetUploadPath;
import com.jsp.utils.MultipartHttpServletRequestParser;
import com.jsp.utils.SaveFileResolver;

@WebServlet("/member/picture")
public class PictureUploadMemberServlet extends HttpServlet{
	
	private final static int MEMORY_THRESHOLD = 1024 * 500 * 1;
	private final static int MAX_FILE_SIZE = 1024 * 1024 * 1;
	private final static int MAX_REQUEST_SIZE = 1024 * 1024 * 2;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		MultipartHttpServletRequestParser parser = null;
		String uploadFileName = "";
		
		try {
			parser = new MultipartHttpServletRequestParser(request, MEMORY_THRESHOLD, MAX_FILE_SIZE, MAX_REQUEST_SIZE);
			String uploadPath = GetUploadPath.getUploadPath("member.picture.upload");
			List<FileItem> fileItems = parser.getFileItems("pictureFile");
			List<File> uploadFiles;
			uploadFiles = SaveFileResolver.fileUpload(fileItems,uploadPath);
			uploadFileName = uploadFiles.get(0).getName();
			// 4. 이전 이미지 삭제
			String oldPicture = parser.getParameter("oldPicture");
			File oldFile = new File(uploadPath + File.separator + oldPicture);
			if (oldFile.exists()) {
				oldFile.delete();
			}
			
			// 5. 저장한 파일명 보내기
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.print(uploadFileName);
		} catch (NotMultipartFormDataException e) {
			response.sendError(response.SC_BAD_REQUEST); // 400
		} catch (FileUploadException e) {
			e.printStackTrace();
			response.sendError(response.SC_INTERNAL_SERVER_ERROR); // 500
		}catch (Exception e) {
			e.printStackTrace();
			response.sendError(response.SC_INTERNAL_SERVER_ERROR);
		}

	}

}
