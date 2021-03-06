package egovframework.example.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class CmmnUtil {

	public static boolean createQrCode(String text, String fileName) {
		QRCodeWriter qrCodeWriter = new QRCodeWriter(); // QR 코드

		try {
			String enCodeText = new String(text.getBytes("UTF-8"), "ISO-8859-1");

			// zxing에서 스트림에 파일을 뿌릴수있도록 메소드를 지원함.rw 큐알코드
			OutputStream out = new FileOutputStream(String.format("/Temp/%s.png", fileName));
			BitMatrix bitMatrix = qrCodeWriter.encode(enCodeText, BarcodeFormat.QR_CODE, 500, 200);
			MatrixToImageWriter.writeToStream(bitMatrix, "png", out);
			out.close();
			return true;
			
		} catch (WriterException | IOException e) {
			e.printStackTrace();
			return false;
		}
		
	}
}
