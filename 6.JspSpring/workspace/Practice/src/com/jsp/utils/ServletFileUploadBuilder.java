package com.jsp.utils;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.jsp.exception.NotMultipartFormDataException;

public class ServletFileUploadBuilder {

	public static ServletFileUpload build(
							int memoryThreshold,
							int maxFileSize,
							int maxRequestSize) {
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		factory.setSizeThreshold(memoryThreshold);
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		upload.setFileSizeMax(maxFileSize);
		upload.setSizeMax(maxRequestSize);
		
		return upload;
		
	}
	public static ServletFileUpload build(HttpServletRequest request,
			int memoryThreshold,
			int maxFileSize,
			int maxRequestSize) throws NotMultipartFormDataException {
		if(ServletFileUpload.isMultipartContent(request)) {
			return build(memoryThreshold, maxFileSize, maxRequestSize);
		}else {
			throw new NotMultipartFormDataException();
		}
	}
}
