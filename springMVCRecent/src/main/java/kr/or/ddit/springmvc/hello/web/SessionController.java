package kr.or.ddit.springmvc.hello.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

@Controller
@SessionAttributes("loginId")
public class SessionController {
	@RequestMapping(value="/login.do")
	public String login(ModelMap modelMap) throws Exception{
		modelMap.addAttribute("loginId", "dditUser");		
		return "hello/session";
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(ModelMap modelMap
			, @ModelAttribute("loginId") String loginId
			, SessionStatus status) throws Exception{
		System.out.println("logout loginId: "+loginId);
		status.setComplete();
		return "hello/session";
	}
}
