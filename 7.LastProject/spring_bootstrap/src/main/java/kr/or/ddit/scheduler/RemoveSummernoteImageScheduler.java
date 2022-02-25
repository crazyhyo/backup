package kr.or.ddit.scheduler;

import java.io.File;
import java.util.List;

import com.jsp.command.SearchCriteria;
import com.jsp.dto.NoticeVO;

import kr.or.ddit.service.spring.ScheduledBoardService;
import kr.or.ddit.service.spring.ScheduledNoticeService;
import kr.or.ddit.service.spring.ScheduledPdsService;

public class RemoveSummernoteImageScheduler {
	
	private ScheduledNoticeService scheduledNoticeService = null;
	private ScheduledBoardService scheduledBoardService = null;
	private ScheduledPdsService scheduledPdsService = null;
	private String filePath = null;
	
	public void setFilePath(String filePath) {
		this.filePath =filePath;
	}
	
	public void setScheduledNoticeService(ScheduledNoticeService scheduledNoticeService) {
		this.scheduledNoticeService = scheduledNoticeService;
	}
	public void setScheduledBoardService(ScheduledBoardService scheduledBoardService) {
		this.scheduledBoardService = scheduledBoardService;
	}
	public void setScheduledPdsService(ScheduledPdsService scheduledPdsService) {
		this.scheduledPdsService = scheduledPdsService;
	}
	
	public void fileRemove() throws Exception{
		
//		System.out.println("kr.or.ddit.scheduler.RemoveSummernoteImageScheduler.fileRemove()!");
		
		
		File dir = new File(filePath);
		File[] files = dir.listFiles();
		boolean existFile = false;
		
		if(files != null) for(File file : files) {
			
			existFile = false;
			existFile = existFile
					|| (scheduledNoticeService.getNoticeByImage(file.getName()) != null)
					|| (scheduledBoardService.getBoardByImage(file.getName()) != null)
					|| (scheduledPdsService.getPdsByImage(file.getName()) != null);
			
			/*existFile = (scheduledNoticeService.getNoticeByImage(file.getName()) != null)
					|| (scheduledBoardService.getBoardByImage(file.getName()) != null)
					|| (scheduledPdsService.getPdsByImage(file.getName()) != null);*/
			
			
/*			SearchCriteria cri = new SearchCriteria();
			cri.setSearchType("c");
			cri.setKeyword(file.getName());
			
			List<NoticeVO> noticeList = (List<NoticeVO>)scheduledNoticeService.getNoticeList(arg0);*/
			if(existFile) {
				System.out.println(file.getName() + "는 사용하는 파일입니다.");
				continue;
			}else {
				System.out.println(file.getName() + "는 사용하지 않는 파일입니다.");
				if(file.exists())	file.delete();
			}
		}
	}
}
