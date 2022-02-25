/*
 * 21/09/23 
 * author : Lee KwangHyo
 */

package kr.or.ddit.http;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.StringTokenizer;

public class MyHttpServer {
    private final int port = 80;
    private final String encoding = "UTF-8";

    /**
     *  서버 시작
     */

    public void start(){

        System.out.println("HTTP 서버가 시작되었습니다.");

        try(ServerSocket server = new ServerSocket(port)){
            while(true){
                try{
                    Socket socket = server.accept();

                    HttpHandler handler = new HttpHandler(socket);

                    new Thread(handler).start(); // 요청 처리 시작...

                }catch(IOException ex){
                    System.err.println("커넥션 오류!!");
                    ex.printStackTrace();
                }catch(RuntimeException ex) {
                    System.err.println("알 수 없는 오류!!");
                    ex.printStackTrace();
                }
            }
        }catch(IOException ex){
            ex.printStackTrace();
        }
    }

    /**
     * HTTP 요청 처리를 위한 Runnable 클래스
     */

    private class HttpHandler implements Runnable{
        private final Socket socket;

        public HttpHandler(Socket socket){
            this.socket = socket;
        }

        @Override
        public void run(){

            OutputStream out = null;
            BufferedReader br = null;


            try{
                out = new BufferedOutputStream(
                        socket.getOutputStream());
                br = new BufferedReader(
                        new InputStreamReader(
                            socket.getInputStream()));

                // 요청헤더 정보 파싱하기
                StringBuilder request = new StringBuilder();	//	String에 += 같은 연산이 반복 될 때 전용클래스의 메서드를 이용하면 성능향상
                while(true){
                    String str = br.readLine();

                    if(str.equals("")) break; // empty line 체크

                    request.append(str + "\n");
                }

                System.out.println("요청헤더:\n" + request.toString());
                System.out.println("--------------------------------------");

                String reqPath = "";

                // 요청 페이지 정보 가져오기
                StringTokenizer st = new StringTokenizer(request.toString());	// 특정 구분자를 가지고 문자열을 토큰화시키는 전용 클래스
                while(st.hasMoreTokens()){
                    String token = st.nextToken();
                    if(token.startsWith("/")){
                    	reqPath = token;
                    }
                }
                
                // 경로 디코딩
                reqPath = URLDecoder.decode(reqPath, "utf-8");
                
                // 상대경로(프로젝트 폴더기준) 설정
                String filePath = "./WebContent" + reqPath;

                // 해당 파일이름을 이용하여 Content-type 정보 추출하기
                String contentType = URLConnection
                    .getFileNameMap().getContentTypeFor(filePath);

                // CSS파일인 경우 인식이 안되서 추가함
                if(contentType == null && filePath.endsWith(".css")){
                    contentType = "text/css";
                }

                System.out.println("ContentType => " + contentType);

                File file = new File(filePath);
                if(!file.exists()) {
                    makeErrorPage(out, 404, "Not Found");
                    return;
                }

                byte[] body = makeResponseBody(filePath);

                byte[] header = makeResponseHeader(body.length, contentType);

                // 요청 헤더가 HTTP/1.0이나 그 이후의 버전을 지원할 경우 MIME 헤더를 전송한다.
                if(request.toString().indexOf("HTTP/") != -1) {
                    out.write(header); // 응답헤더 보내기
                }

                System.out.println("응답헤더:\n" + new String(header));
                System.out.println("--------------------------------------");

//                System.out.println("응답바디:\n" + new String(body));
//                System.out.println("--------------------------------------");

                out.write(body); // 응답내용 보내기
                out.flush();

            }catch(IOException ex){
                System.err.println("입출력 오류!!");
                ex.printStackTrace();
            }finally {
                try{
                    socket.close(); // 소켓 닫기(연결 끊기)
                }catch(IOException ex){
                    ex.printStackTrace();
                }
            }

        }
    }

    /**
     * 응답 헤더 생성하기
     * @param length 응답내용 크기
     * @param contentType 마임타입
     * @return 바이트배열
     */
    private byte[] makeResponseHeader(
    		int length, String contentType) {
    	String header = "HTTP/1.1 200 OK\r\n"
    			+ "Server: MyHTTPServer 1.0\r\n"
    			+ "Content-length: " + length + "\r\n"
    			+ "Content-Type: " + contentType
    			+ "; charset=" + this.encoding + "\r\n\r\n";
    	
    	return header.getBytes();
    }
    
    private byte[] makeResponseBody(String filePath) {
    	
    	FileInputStream fis = null;
    	byte[] data = null;
    	
    	try{
    		File file = new File(filePath);
    		data = new byte[(int) file.length()];
    		
    		fis = new FileInputStream(file);
    		fis.read(data);
    		
    	}catch(IOException ex){
    		System.err.println("입출력 오류!!!");
    		ex.printStackTrace();
    	}finally {
    		if(fis != null) {
    			try{
    				fis.close();
    			}catch(IOException ex){
    				ex.printStackTrace();
    			}
    		}
    	}
    	return data;
    }

    /**
     * 에러페이지 생성 
     * @param out
     * @param statusCode
     * @param errMsg
     */
    private void makeErrorPage(
            OutputStream out, int statusCode, String errMsg) {
        String statusLine = "HTTP/1.1" + " " + statusCode
            + " " + errMsg;
        try{
            out.write(statusLine.getBytes());
            out.flush();
        }catch(IOException ex){
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new MyHttpServer().start();
    }
}
