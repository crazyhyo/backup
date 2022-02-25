package kr.or.ddit.api;

import java.net.HttpURLConnection;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import java.io.IOException;

public class HolidayAPITest {
    public static void main(String[] args) throws IOException, ParserConfigurationException, SAXException {
        URL url = new URL("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?serviceKey=obZW9dscln7%2Bzj%2BJ1sYoDwiKS5rjrx%2Fp91XiXgd2b6r7MuNwgxuJD1n6LjpSa2UuxnTGeq034Gqeh7W4vRDR%2Fg%3D%3D&pageNo=1&numOfRows=200&solYear=2022");
        
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
        
        Document document = documentBuilder.parse(url.toString());

        // DOM Document 객체로부터 루트 엘리먼트 객체 가져오기
        Element root = document.getDocumentElement();

        System.out.println("루트 엘리멘트 태그명 : " + root.getTagName());

        NodeList itemList = root.getElementsByTagName("item");
        
        System.out.println(itemList == null);
        
        if(itemList != null) for(int i = 0; i < itemList.getLength(); i++) {
        	Node item = itemList.item(i);
        	
        	NodeList itemChilds = item.getChildNodes();
        	
        	if(itemChilds != null) for(int j = 0; j < itemChilds.getLength(); j++) {
        		Node itemChild = itemChilds.item(j);
        		
        		if(itemChild.getNodeName().equals("dateName")) {
        			String dateName = itemChild.getTextContent();
        			System.out.println(dateName);
        		}
        		
        		if(itemChild.getNodeName().equals("locdate")) {
        			String locdate = itemChild.getTextContent();
        			System.out.println(locdate);
        			System.out.println("===");
        		}
        	}
        	conn.disconnect();
        }
    }
}