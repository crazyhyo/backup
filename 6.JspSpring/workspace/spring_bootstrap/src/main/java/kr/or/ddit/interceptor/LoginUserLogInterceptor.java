package kr.or.ddit.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jsp.dto.MemberVO;

public class LoginUserLogInterceptor extends HandlerInterceptorAdapter{

	private String savePath = "c://log";
	private String saveFileName = "login_user_log.csv";
	
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("preHandle occured here!");
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		System.out.println("postHandle occured here!");
		
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if(loginUser == null) return;
		
		String tag = "[loginuser]";
		String log = tag
						+ loginUser.getId() + ","
						+ loginUser.getPhone() + ","
						+ loginUser.getEmail() + ","
						+ request.getRemoteAddr() + ","
						+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		
		String test = makeLog(tag,
							  loginUser.getId(),
							  loginUser.getPhone(),
							  loginUser.getEmail(),
							  request.getRemoteAddr(),
							  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
		File file = new File(savePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String logFilePath = savePath + File.separator + saveFileName;
		BufferedWriter out = new BufferedWriter(new FileWriter(logFilePath, true));
		
		out.write(log);
		out.newLine();
		out.write(test);
		out.newLine();
		
		out.close();
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		System.out.println("afterCompletion occured here!");
		super.afterCompletion(request, response, handler, ex);
	}

	private String makeLog(String...strings) {
		
		StringBuffer sb = new StringBuffer();
		for(String string : strings) {
			sb.append(string);
			sb.append(",");
		}
		sb.append("log end");
		return sb.toString();
	}
}
