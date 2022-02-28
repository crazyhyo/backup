package kr.or.ddit.springmvc.base.excel;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelView extends AbstractXlsView{	
	public static final String TEMPLATE_SAMPLE =  "template_sample.xlsx";
	public static final String EXCEL_NAME_SAMPLE =  "샘플";
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		setHeader(request, response, model);
		generateXLSTansformer(request, response, model);
		
	}
	
	public static void generateXLSTansformer(HttpServletRequest request, HttpServletResponse response, Map<String, Object> modelMap) throws Exception {
		modelMap.put("templateFilePath", getTmeplateFilePath(request, modelMap));
		
		File file = new File(""+getTmeplateFilePath(request, modelMap));
		
		if (!file.isFile()) {
			throw new Exception("템플릿 양식 파일이 존재하지 않습니다.");
		}

		InputStream is = null;
		OutputStream os = null;
		try{
			is = new BufferedInputStream(new FileInputStream(file));
			
        	os = response.getOutputStream();
        	Context context = (Context)modelMap.get("context");            
            JxlsHelper.getInstance().processTemplate(is, os, context);	  
            os.flush();
	    }catch(Exception e){
        	e.printStackTrace();
        }finally{
        	if (os != null) os.close();
        	if (is != null) is.close();
        }
	}
	
	/***
	 * 실제 경로 조회
	 */
	public static String getRealPath(HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath("/");
	}
	
	public static String getTmeplateFilePath(HttpServletRequest request, Map<String, Object> map) {
		String realPath = getRealPath(request);		

		return realPath + "WEB-INF/template/excel" + "/" + (String)map.get("templateName");
	}
	
	public static void setHeader(HttpServletRequest request, HttpServletResponse response, Map<String, Object> modelMap) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String dateStr = sdf.format(new Date());
		
		String excelName = modelMap.get("excelName").toString() + "_" + dateStr + ".xlsx";
		String mimetype = "application/x-msdownload";
		response.setContentType(mimetype);
		setDisposition(excelName, request, response);
		
	}
	
	
	/**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    public static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String browser = getBrowser(request);
	
	String dispositionPrefix = "attachment; filename=";
	String encodedFilename = null;
//	response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
	
	if (browser.equals("MSIE")) {
	    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
	} else if (browser.equals("Firefox")) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if (browser.equals("Opera")) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if (browser.equals("Chrome")) {
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < filename.length(); i++) {
		char c = filename.charAt(i);
		if (c > '~') {
		    sb.append(URLEncoder.encode("" + c, "UTF-8"));
		} else {
		    sb.append(c);
		}
	    }
	    encodedFilename = sb.toString();
	} else {
	    //throw new RuntimeException("Not supported browser");
	    throw new IOException("Not supported browser");
	}
	
	response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

	if ("Opera".equals(browser)){
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
    }
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }

	
}
