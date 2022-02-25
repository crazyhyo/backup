package kr.or.ddit.cmm.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.cmm.service.AtchFileServiceImpl;
import kr.or.ddit.cmm.service.IAtchFileService;
import kr.or.ddit.cmm.vo.AtchFileVO;

@WebServlet("/filedownload.do")
public class FileDownloadServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long fileId = req.getParameter("fileId") != null ?
				Long.parseLong(req.getParameter("fileId")) : -1;
		int fileSn = req.getParameter("fileSn") != null ?
				Integer.parseInt(req.getParameter("fileSn")) : 1;
				
		// 파일 정보 조회
		
		IAtchFileService fileService = AtchFileServiceImpl.getInstance();
		AtchFileVO fileVO = new AtchFileVO();
		fileVO.setAtchFileId(fileId);
		fileVO.setFileSn(fileSn);
		
		fileVO = fileService.getAtchFileDetail(fileVO);
		
		// 파일 다운로드 처리를 위한 응답헤더 정보 설정하기
		resp.setContentType("application/octet-stream");
		
		// +문자 공백처리
		// attachment는 파일로 떨구라는 것, default는 inline, 열라는 것
		// Content-Disposition에서는 +가 ' '(공백문자)를 의미함, %20은 ' '(공백문자를 의미함)
		resp.setHeader("Content-Disposition", "attachment; filename=\""
				+ URLEncoder.encode(fileVO.getOrignlFileNm(), "UTF-8").replace("\\+", "%20") + "\"");
		BufferedInputStream bis = 
				new BufferedInputStream(
						new FileInputStream(
								fileVO.getFileStreCours()));
		BufferedOutputStream bos =
				new BufferedOutputStream(resp.getOutputStream());
		
		int c = -1;
		while((c = bis.read()) != -1) {
			bos.write(c);
		}
		
		bos.close();
		bis.close();
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
