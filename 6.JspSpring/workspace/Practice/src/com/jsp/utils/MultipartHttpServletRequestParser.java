package com.jsp.utils;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.jsp.exception.NotMultipartFormDataException;

public class MultipartHttpServletRequestParser {
	
	private Map<String, String[]> paramString = new HashMap<String, String[]>();;
	private Map<String, List<FileItem>> paramFile= new HashMap<String, List<FileItem>>();
	
	public MultipartHttpServletRequestParser(HttpServletRequest request, 
											int memoryThreshold,
											int maxFileSize,
											int maxRequestSize) throws FileUploadException, NotMultipartFormDataException, UnsupportedEncodingException{
		
		ServletFileUpload upload;
			upload = ServletFileUploadBuilder.build(request, memoryThreshold, maxFileSize, maxRequestSize);
		
		List<FileItem> items;
		items = upload.parseRequest(request);
		
		if(items != null) for(FileItem item : items) {
			
			String paramName = item.getName();
			
			if(item.isFormField()) {
				String[] tempStr;
				tempStr = item.getString("utf-8").split(",");
				paramString.put(paramName, tempStr);
			}else {
				List<FileItem> files = paramFile.get(paramName);
				if(files == null) {
					files = new ArrayList<FileItem>();
					paramFile.put(paramName, files);
				}
				files.add(item);
			}
		}
		
	}
	
	public String getParameter(String key) {
		String value = "asdf";
		
		value.contains("asd");
		
		String[] values = this.paramString.get(key);
		if(values != null) {
			value = values[0];
		}
		return value;
	}
	
	public String[] getParameterValues(String key) {
		String[] values = null;
		if(this.paramString.get(key) != null) {
			values = this.paramString.get(key);
		}
		return values;
	}
	
	public FileItem getFileItem(String key) {
		FileItem file = null;
		List<FileItem> files = this.paramFile.get(key);
		if(files != null) {
			file = files.get(0);
		}
		return file;
	}

	public List<FileItem> getFileItems(String key) {
		List<FileItem> files = null;
		if(this.paramFile.get(key) != null) {
			files = this.paramFile.get(key);
		}
		return files;
	}
	
}
