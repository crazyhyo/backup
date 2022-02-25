package kr.or.ddit.basic;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import java.io.BufferedReader;
import java.io.IOException;


public class XMLAssn {
	 public static void main(String[] args) throws IOException, ParserConfigurationException, SAXException {
	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/5020000/librarySvc/getLibrary"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=obZW9dscln7%2Bzj%2BJ1sYoDwiKS5rjrx%2Fp91XiXgd2b6r7MuNwgxuJD1n6LjpSa2UuxnTGeq034Gqeh7W4vRDR%2Fg%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("obZW9dscln7%2Bzj%2BJ1sYoDwiKS5rjrx%2Fp91XiXgd2b6r7MuNwgxuJD1n6LjpSa2UuxnTGeq034Gqeh7W4vRDR%2Fg%3D%3D", "UTF-8")); /*공공데이터포털에서 받은 인증키*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("20", "UTF-8")); /*한 페이지 결과 수*/
	        URL url = new URL(urlBuilder.toString());
	        
	        DocumentBuilder builder = DocumentBuilderFactory
	                .newInstance().newDocumentBuilder();
	        
	        Document document = builder.parse(url.toString());
	        
	        Element response = document.getDocumentElement();

	        System.out.println("루트 엘리멘트 태그명 : " + response.getTagName());
	        
	        NodeList itemList = response.getElementsByTagName("item");
	        
	        String header = String.format("%-30s|%-80s|%-30s|%-30s|%-30s|%-30s",
	        		"subject", "address", "telephone", "homepage", "longitude", "latitude");
	        System.out.println(header);
	        System.out.println("=======================================================================");
	        for(int i=0; i<itemList.getLength(); i++){
                Element element = (Element) itemList.item(i);

                String subject = element.getElementsByTagName("subject")
                                .item(0).getTextContent();
                String address = element.getElementsByTagName("address")
                                .item(0).getTextContent();
                String telephone = element.getElementsByTagName("telephone")
                                .item(0).getTextContent();
                String homepage = element.getElementsByTagName("homepage")
                                .item(0).getTextContent();
                String longitude = element.getElementsByTagName("longitude")
                        .item(0).getTextContent();
                String latitude = element.getElementsByTagName("latitude")
                        .item(0).getTextContent();

                String str = String.format("%-30s|%-80s|%-30s|%-30s|%-30s|%-30s",
                		subject, address, telephone, homepage, longitude, latitude);
                System.out.println(str);
                System.out.println("-----------------------------------------------------");
            }
	        
	        
	        /*HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	            sb.append("\n");
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());*/
	    }
}
