package egovframework.example.sample.intercept;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import egovframework.example.sample.service.LoginVo;

@Controller
//@RequestMapping(value= {"/com", "/com2"})
public class LoginController {

	// request 요청시 post, get, service 등 모든 요청을 다 받아서 처리
//	@RequestMapping(value= {"/login.do", "/loginFront.do"})
	
	// request 요청시 get 방시만 허용하고 나머지는 다 에러처리
	@GetMapping(value = {"/login.do", "/loginFront.do"})
	
	// request 요청시 POST방식만 허용하고, 나머지는 다 에러 처리 (ex 서브밋 버튼 중
	//@PostMapping(value = {"/login.do", "/loginFront.do"})
	public String loginFront() {
		
		try {
			String filePath = "/Temp/Crunchify.com-QRCode3.png";

			QRCodeWriter qrCodeWriter = new QRCodeWriter(); // QR 코드

			String text = "http://192.168.143.22/covid/common/loginForm";
			text = new String(text.getBytes("UTF-8"), "ISO-8859-1");

			BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, 500, 500);

			System.out.println(Color.BLACK.getTransparency());

			MatrixToImageConfig config = new MatrixToImageConfig(Color.RED.hashCode(), Color.WHITE.hashCode());
			System.out.println(config.getPixelOffColor());
			System.out.println(config.getPixelOnColor());

			Path file = Paths.get(filePath);

			MatrixToImageWriter.writeToPath(bitMatrix, "png", file, config);

			BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix, config);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		ImageIO.write(qrImage, "jpg", new File("/Temp/Crunchify.com-QRCode.jpg"));
		
		
		return "loginFront";
	}
	
	@GetMapping(value="loginProc.do")
	public String loginProc(HttpServletRequest req, HttpSession sessions) {
		
		HttpSession session = req.getSession();
		
		LoginVo loginInfo = new LoginVo();
		
		{	// db에서 조회된 데이터
			loginInfo.setId("heebang");
			loginInfo.setName("오니짱");
			loginInfo.setAge("55");
			loginInfo.setLogin(true);
		}
		
		{
			sessions.setAttribute("loginInfo", loginInfo);
		}
		
		return "loginFront";
	}
	
}
