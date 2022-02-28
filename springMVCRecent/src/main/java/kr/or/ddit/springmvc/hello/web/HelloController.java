package kr.or.ddit.springmvc.hello.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {
	@RequestMapping(value="/hello.do")
	public String sayHello(ModelMap modelMap) throws Exception{
		modelMap.addAttribute("name", "홍길동");
		modelMap.addAttribute("now", new Date());
		return "hello/say";
	}
	
	@RequestMapping(value="/helloForm.do", method=RequestMethod.GET)
	public String helloGet(@RequestParam("name") String name,
			               @RequestParam(value="pageNo", required=false) String pageNo,
			ModelMap modelMap) throws Exception{
		
		System.out.println(name);
		modelMap.addAttribute("methodType", "GET 방식");	
		modelMap.addAttribute("name", name);	
		modelMap.addAttribute("pageNo", pageNo);	
		return "hello/view";
	}
	
	@RequestMapping(value="/helloForm.do", method=RequestMethod.POST)
	public String helloPost(@RequestParam("name") String name,
            				@RequestParam(value="pageNo", required=false) String pageNo,
	        ModelMap modelMap) throws Exception{
		
		System.out.println(name);
		modelMap.addAttribute("methodType", "POST 방식");
		modelMap.addAttribute("name", name);
		modelMap.addAttribute("pageNo", pageNo);
		return "hello/view";
	}
}
	
