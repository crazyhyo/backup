package kr.or.ddit.member.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.cmm.service.AtchFileServiceImpl;
import kr.or.ddit.cmm.service.IAtchFileService;
import kr.or.ddit.cmm.vo.AtchFileVO;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImp1;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

@WebServlet(value="/member/insert.do")
public class InsertMemberServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/WEB-INF/views/member/insertForm.jsp").forward(req, resp);

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		AtchFileVO atchFileVO = new AtchFileVO();
		// Multipart가 맞는지 확인...
		if(((FileUploadRequestWrapper)req).isMultipartContent()){
			
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			
			Map<String, FileItem[]> fileItemMap =
				((FileUploadRequestWrapper)req).getFileItemMap();	
			System.out.println("파일 아이템 크기 => " + fileItemMap.size());
			
			if(fileItemMap.size() > 0) {
				try {
					atchFileVO = fileService.saveAtchFileList(fileItemMap);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		// 1. 요청 파라미터 정보 가져오기
		String memId = req.getParameter("memId");
		String memName = req.getParameter("memName");
		String memTel = req.getParameter("memTel");
		String memAddr = req.getParameter("memAddr");
		
		// 2. 서비스 객체 생성하기
		IMemberService memService = MemberServiceImp1.getInstance();
		
		// 3. 회원정보 등록
		MemberVO mv = new MemberVO();
		mv.setMemAddr(memAddr);
		mv.setMemId(memId);
		mv.setMemName(memName);
		mv.setMemTel(memTel);
		mv.setAtchFileId(atchFileVO.getAtchFileId());
		
		int cnt = memService.registerMember(mv);
		
		String msg = cnt > 0 ? "success" : "fail";
		
		req.setAttribute("msg", msg);

		// 4. 목록 화면으로 이동
//		req.getRequestDispatcher("/member/list.do").forward(req, resp);
		
		String redirectUrl = req.getContextPath() + "/member/list.do?msg=" + URLEncoder.encode(msg,"UTF-8");
		
		resp.sendRedirect(redirectUrl);	// 목록조회화면으로 리다이렉트
		
	}

}
