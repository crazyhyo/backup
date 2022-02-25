package com.jsp.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

public class SaveFileResolver {
	
	public static List<File> fileUpload(List<FileItem> items, String uploadPath) throws Exception {
		
		
		List<File> uploadFileList = new ArrayList<File>();
		File file = new File(uploadPath);
		file.mkdirs();
		
		if(items != null) for(FileItem item : items) {
			String fileName = new File(item.getName()).getName(); //사용자 파일명
			fileName = MakeFileName.toUUIDFileName(fileName, "$$"); // 고유한 파일명
			
			File storeFile = new File(uploadPath + File.separator + fileName);
			//local HDD 에 저장.
			try {
				item.write(storeFile);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			uploadFileList.add(storeFile);
		}
		
		return uploadFileList;
	}
}
