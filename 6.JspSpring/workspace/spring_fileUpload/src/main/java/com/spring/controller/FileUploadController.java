package com.spring.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.command.MultipartCommand;

@Controller
public class FileUploadController {
	
	@RequestMapping("/fileUploadForm")	// get, post에 상관없이 모두 받음
	public void fileUpload() {}

	@RequestMapping(value = "/multipartFile", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public ModelAndView uploadMultipartFile(@RequestParam(value = "title", defaultValue= "제목없음") String title,
										@RequestParam("file") MultipartFile multi,
										HttpServletRequest request,
										HttpServletResponse response,
										ModelAndView mnv) throws Exception{ // model객체는 spring adapter가 생성해서 넣어줌
		// model의 addAttribute된 것들은 request의 attribute에 담기게 됨
		// 단 model에 집합체를 담았을 경우 각각을 꺼내서 request에 각각 담아주게 된다.
		mnv.setViewName("fileUploaded");
		
		fileUpload(title, multi, request, response, mnv);
		
		return mnv;
		
	}
	
	@RequestMapping(value = "/multipartHttpServletRequest", method = RequestMethod.POST)
	public ModelAndView uploadByMultipartHttpServletRequest(
			MultipartHttpServletRequest request,
			HttpServletResponse response,
			ModelAndView mnv) throws Exception{ 
		
		String title = request.getParameter("title");
		MultipartFile multi = request.getFile("file");
		
		mnv.setViewName("fileUploaded");
		
		fileUpload(title, multi, request, response, mnv);
		
		return mnv;
		
	}
	
	@RequestMapping(value = "/commandObject", method = RequestMethod.POST)
	public ModelAndView uploadByCommandObject(MultipartCommand command, HttpServletRequest request,
											  HttpServletResponse response, ModelAndView mnv) throws Exception{
		
		MultipartFile multi = command.getFile();
		String title = command.getTitle();
		
		mnv.setViewName("fileUploaded");
		
		fileUpload(title, multi, request, response, mnv);
		
		return mnv;
	}
	
	private void fileUpload(String title, MultipartFile multi,
							HttpServletRequest request, HttpServletResponse response, ModelAndView mnv) 
									throws Exception{
		if(multi.isEmpty()) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('파일이 없습니다.');</script>");
			out.print("<script>history.go(-1);</script>");
			mnv.setViewName(null);
			return;
		}
		
		if(multi.getSize() > 1024 * 1024 * 5) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('용량초과입니다.');</script>");
			out.print("<script>history.go(-1);</script>");
			mnv.setViewName(null);
			return;
		}
		
		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
		
		String fileName = UUID.randomUUID().toString().replace("-", "") + "$$" + multi.getOriginalFilename();
		
		File file = new File(uploadPath, fileName);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		multi.transferTo(file);
		
		mnv.addObject("title", title);
		mnv.addObject("originalFileName", multi.getOriginalFilename());
		mnv.addObject("uploadedFileName", file.getName());
		mnv.addObject("uploadPath", file.getAbsolutePath());
	}
}
