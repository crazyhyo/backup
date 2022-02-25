package kr.or.ddit.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.josephoconnell.html.HTMLInputFilter;
import com.jsp.command.SearchCriteria;
import com.jsp.dto.AttachVO;
import com.jsp.dto.PdsVO;
import com.jsp.service.PdsService;

import kr.or.ddit.command.PdsModifyCommand;
import kr.or.ddit.command.PdsRegistCommand;
import kr.or.ddit.utils.GetAttachesFromMultipartFileAdapter;

@Controller
@RequestMapping("/pds")
public class PdsController {

	@Autowired
	//@Resource(name="pdsService")
	private PdsService pdsService;
	
	@Resource(name = "fileUploadPath")
	private String fileUploadPath;
	
	@RequestMapping("/main")
	public void main() throws Exception {}
	
	@RequestMapping("/list")
	public ModelAndView list(SearchCriteria cri, ModelAndView mnv) throws Exception{
		
		String url = "pds/list";
		
		Map<String, Object> dataMap = pdsService.getList(cri);
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registForm")
	public ModelAndView registForm(ModelAndView mnv) throws Exception{
		String url = "pds/regist";
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String regist(PdsRegistCommand registReq, RedirectAttributes attr) throws Exception{
		String url = "redirect:/pds/list.do";
		
		PdsVO pds = registReq.toPdsVO();
		
		List<AttachVO> attachList = GetAttachesFromMultipartFileAdapter.save(registReq.getUploadFile(), fileUploadPath);
		
		pds.setTitle(HTMLInputFilter.htmlSpecialChars(pds.getTitle()));
		pds.setAttachList(attachList);
		
		pdsService.regist(pds);
		
		attr.addFlashAttribute("from", "regist");
		
		return url;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(int pno, String from, ModelAndView mnv) throws Exception{
		
		String url = "pds/detail";
		
		PdsVO pds = null;
		if(from != null && from.equals("list")) {
			pds = pdsService.getPds(pno);
			url = "redirect:/pds/detail.do?pno=" + pno;
		}else {
			pds = pdsService.read(pno);
		}
		
		// 파일명 재정의
		if(pds != null) {
			List<AttachVO> attachList = pds.getAttachList();
			if(attachList != null) for(AttachVO attach : attachList) {
				String fileName = attach.getFileName().split("\\$\\$")[1];
				attach.setFileName(fileName);
			}
		}
		mnv.addObject("pds", pds);
		
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/modifyForm")
	public ModelAndView modifyForm(int pno, ModelAndView mnv) throws Exception{
		String url = "pds/modify";
		PdsVO pds = pdsService.getPds(pno);
		
		List<AttachVO> attachList = pds.getAttachList();
		if(attachList != null) for(AttachVO attach : attachList) {
			String fileName = attach.getFileName().split("\\$\\$")[1];
			attach.setFileName(fileName);
		}
		
		mnv.addObject("pds", pds);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modify")
	public String modifyPOST(PdsModifyCommand modifyReq,
			                 HttpServletRequest request,
			                 RedirectAttributes rttr) throws Exception{
		String url = "redirect:/pds/detail.do";
		
		//파일삭제
		if(modifyReq.getDeleteFile() != null && modifyReq.getDeleteFile().length > 0) {
			for(String anoStr : modifyReq.getDeleteFile()) {
				int ano = Integer.parseInt(anoStr);
				AttachVO attach = pdsService.getAttachByAno(ano);
				File deleteFile = new File(attach.getUploadPath(), attach.getFileName());
				if(deleteFile.exists()) {
					deleteFile.delete(); // File삭제
				}
				pdsService.removeAttachByAno(ano);
			}
		}
		
		//파일저장
		List<AttachVO> attachList
			= GetAttachesFromMultipartFileAdapter.save(modifyReq.getUploadFile(), fileUploadPath);
		
		PdsVO pds = modifyReq.toPdsVO();
		pds.setAttachList(attachList);
		pds.setTitle(HTMLInputFilter.htmlSpecialChars(pds.getTitle()));
		
		
		pdsService.modify(pds);
		rttr.addFlashAttribute("from", "modify");
		rttr.addAttribute("pno", pds.getPno());
		
		return url;
	}
	
	@RequestMapping("/remove")
	public String remove(int pno, RedirectAttributes attr) throws Exception{
		String url = "redirect:/pds/detail.do";
		
		List<AttachVO> attachList = pdsService.getPds(pno).getAttachList();
		if(attachList != null) for(AttachVO attach : attachList) {
			File target = new File(fileUploadPath, attach.getFileName());
			if(target.exists()) {
				target.delete();
			}
		}
		
		pdsService.remove(pno);
		
		attr.addFlashAttribute("from", "remove");
		attr.addAttribute("pno", pno);
		
		return url;
	}
	
	@RequestMapping("/getFile")
	public String getFile(int ano, Model model) throws Exception{
		String url = "downloadFile";
		
		AttachVO attach = pdsService.getAttachByAno(ano);
		
		System.out.println(attach.getUploadPath() + "=============");
		
		model.addAttribute("savedPath", attach.getUploadPath());
		model.addAttribute("fileName", attach.getFileName());
		
		return url;
	}
	
}
