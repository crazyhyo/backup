package kr.or.ddit.springmvc.board.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.validator.GenericValidator;
import org.jxls.common.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.or.ddit.springmvc.base.excel.ExcelView;
import kr.or.ddit.springmvc.board.service.AttachFileService;
import kr.or.ddit.springmvc.board.service.BoardService;
import kr.or.ddit.springmvc.board.vo.AttachFileVO;
import kr.or.ddit.springmvc.board.vo.BoardVO;

@Controller
public class BoardController {
	private static final Logger LOGGER = LoggerFactory.getLogger(BoardController.class);
	/** EgovSampleService */
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "attachFileService")
	private AttachFileService attachFileService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value = "/board/retrievePagingList.do")
	public String retrievePagingList(BoardVO boardVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = boardVO.preparePaginationInfo();

		List<BoardVO> resultList = boardService.retrievePagingList(boardVO);
		model.addAttribute("resultList", resultList);

		int totCnt = boardService.retrievePagingListCnt(boardVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/list";
	}
	
	
	@RequestMapping(value = "/board/updateView.do")
	public String updateView(BoardVO boardVO, ModelMap model) throws Exception {
		
		BoardVO retrieveBoardVO = boardService.retrieve(boardVO);
		retrieveBoardVO.copySearchCondition(boardVO);
		
		BeanUtils.copyProperties(retrieveBoardVO, boardVO);

		return "board/edit";
	}
	
	@RequestMapping(value = "/board/update.do")
	public String update(BoardVO boardVO, ModelMap model) throws Exception {
		
		boardService.update(boardVO);
		
		return "forward:/board/retrievePagingList.do";
	}
	
	@RequestMapping(value = "/board/delete.do")
	public String delete(BoardVO boardVO, ModelMap model) throws Exception {
		
		boardService.delete(boardVO);
		
		return "forward:/board/retrievePagingList.do";
	}
	
	@RequestMapping(value = "/board/createView.do")
	public String createView(BoardVO boardVO, HttpSession session, ModelMap model) throws Exception {
		generateSaveToken(boardVO, session);
		
		return "board/edit";
	}
	
	@RequestMapping(value = "/board/create.do")
	public String create(BoardVO boardVO, 
			HttpSession session,
			BindingResult bindingResult,
			ModelMap model) throws Exception {
		
		// Server-Side Validation
		beanValidator.validate(boardVO, bindingResult);

		if (bindingResult.hasErrors()) {
			generateSaveToken(boardVO, session);
			
			return "board/edit";
		}
				
		String sessionSaveToken = (String)session.getAttribute("SAVE_TOKEN");
		String saveToken = boardVO.getSaveToken();
		if(!GenericValidator.isBlankOrNull(sessionSaveToken)
				&& !GenericValidator.isBlankOrNull(saveToken)
				&& sessionSaveToken.equals(saveToken)){
			boardService.create(boardVO);
			session.removeAttribute("SAVE_TOKEN");
		}
		
		return "forward:/board/retrievePagingList.do";
	}

	private void generateSaveToken(BoardVO boardVO, HttpSession session) {
		String saveToken = UUID.randomUUID().toString();
		session.setAttribute("SAVE_TOKEN", saveToken);
		
		boardVO.setSaveToken(saveToken);
	}
	
	@RequestMapping(value = "/board/retrieveAjax.do")
	public String retrieveAjax(BoardVO boardVO, ModelMap model) throws Exception {
		
		BoardVO retrieveBoardVO = boardService.retrieve(boardVO);
		if(retrieveBoardVO != null){
			model.addAttribute("returnStatus", "success");
			model.addAttribute("boardVO", retrieveBoardVO);
		}else{
			model.addAttribute("returnStatus", "fail");
			model.addAttribute("returnMessage", "해당하는 게시글이 없습니다.");
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/board/retrieveExcelList.do")
	public String retrieveExcelList(BoardVO boardVO, ModelMap model) throws Exception {
		
		List<BoardVO> resultList = boardService.retrieveList(boardVO);
		
		
		Context context = new Context();
		context.putVar("list", resultList);
		
		model.addAttribute("context", context);
		model.addAttribute("templateName", ExcelView.TEMPLATE_SAMPLE);
		model.addAttribute("excelName", ExcelView.EXCEL_NAME_SAMPLE);
		
		return "excelView";
	}
	
	/**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/board/fileDown.do")    
    public void fileDown(AttachFileVO attachFileVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	AttachFileVO exsitAttachFileVO = attachFileService.retrieve(attachFileVO);
    	
    	//자료실은 특별히 다운로드 제약이 없으므로 파일에 대한 접근 권한은 체크 하지 않는다.
    	if(exsitAttachFileVO != null){
    		File sourceFile = new File(exsitAttachFileVO.getFilePath()+exsitAttachFileVO.getFileSaveName());
    		int sourceFileSize = (int)sourceFile.length();
			
    		try{
    			downloadFile(request, response, sourceFile, exsitAttachFileVO.getFileSrcName());
    		}catch(Exception e){
    			LOGGER.error(e.getMessage());
    			throw e;
    		}finally{
    			
    		}
		}
	}
    
    
    /**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    protected void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String browser = getBrowser(request);
	
	String dispositionPrefix = "attachment; filename=";
	String encodedFilename = null;
	
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
    private String getBrowser(HttpServletRequest request) {
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
    
	/**
     * 파일  다운로드
     * @param request
     * @param response
     * @param downFile
     * @param sourceFileName
     * @param downFileSize
     * @throws Exception
     * @throws IOException
     */
    protected void downloadFile(HttpServletRequest request, HttpServletResponse response, File downFile, String sourceFileName) throws Exception, IOException {
    	int downFileSize = (int)downFile.length();
		if(downFileSize>0){
			String mimetype = "application/x-msdownload";

			response.setContentType(mimetype);
			setDisposition(sourceFileName, request, response);
			response.setContentLength(downFileSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream());
			 * in.close(); 
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(downFile));
			    out = new BufferedOutputStream(response.getOutputStream());

			    FileCopyUtils.copy(in, out);
			    out.flush();
			} catch (Exception ex) {
			    //ex.printStackTrace();
			    // 다음 Exception 무시 처리
			    // Connection reset by peer: socket write error
				LOGGER.debug("IGNORED: " + ex.getMessage());
			} finally {
			    if (in != null) {
				try {
				    in.close();
				} catch (Exception ignore) {
				    // no-op
					LOGGER.debug("IGNORED: " + ignore.getMessage());
				}
			    }
			    if (out != null) {
				try {
				    out.close();
				} catch (Exception ignore) {
				    // no-op
					LOGGER.debug("IGNORED: " + ignore.getMessage());
				}
			    }
			}

		    } else {
				response.setContentType("text/html; charset=utf-8");

				PrintWriter printwriter = response.getWriter();
				printwriter.println("<script>alert('"+sourceFileName+"을 다운로드 할 수 없습니다. 관리자에게 문의하세요.');history.back();</script>");
				printwriter.flush();
				printwriter.close();

		    }
	}
	
}
