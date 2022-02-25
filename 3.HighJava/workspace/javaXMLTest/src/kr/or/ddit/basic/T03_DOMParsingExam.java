/*
 * 21/09/15 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class T03_DOMParsingExam {

    public void parse() throws ParserConfigurationException, SAXException, IOException {

        // DocumentBuilder 생성
        DocumentBuilder builder = DocumentBuilderFactory
            .newInstance().newDocumentBuilder();

        String svcKey = "Grid_20150827000000000227_1";  // 레시피 재료 정보 조회 서비스
        String apiKey = "1df7e8571e8df3f8cbc9b87691ca7d3e4d04f03c593d477e52bf67b03f0b6e1c"; // 개인별 발급.
        String startIdx = "1";  	// 레시피 재료 시작 순번
        String endIdx = "5";		// 레시피 재료 종료 순번
        String recipeId = "463";	// 래시피가 궁금한 음식 ID

        URL url = new URL("http://211.237.50.150:7080/openapi/"+ apiKey
                + "/xml/"+ svcKey + "/"+startIdx +"/" + endIdx
                +"?RECIPE_ID=" +  recipeId);
        
        System.out.println("url => " + url);
        // DOM 파서로부터 입력받은 문서내용을 파싱하도록 요청
        Document document = builder.parse(url.toString());

        // DOM Document 객체로부터 루트 엘리먼트 객체 가져오기
        Element root = document.getDocumentElement();

        System.out.println("루트 엘리멘트 태그명 : " + root.getTagName());

        // 전체 레시피 수 가져오기
        String totalCnt = root.getElementsByTagName("totalCnt")
                            .item(0).getTextContent();

        endIdx = totalCnt;

        url = new URL("http://211.237.50.150:7080/openapi/"+ apiKey
                + "/xml/"+ svcKey + "/"+startIdx +"/" + endIdx
                +"?RECIPE_ID=" +  recipeId);

        // DOM 파서로부터 입력받은 문서내용을 파싱하도록 요청
        document = builder.parse(url.toString());

        // DOM Document 객체로부터 루트 엘리먼트 객체 가져오기
        root = document.getDocumentElement();

        NodeList rowNodeList = root.getElementsByTagName("row");

        String code = root.getElementsByTagName("code")
                        .item(0).getTextContent();
        if(code.equals("INFO-000")) {

            for(int i=0; i<rowNodeList.getLength(); i++){
                Element element = (Element) rowNodeList.item(i);

                String rowNum = element.getElementsByTagName("ROW_NUM")
                                .item(0).getTextContent();
                String irdntNm = element.getElementsByTagName("IRDNT_NM")
                                .item(0).getTextContent();
                String irdntCpcty = element.getElementsByTagName("IRDNT_CPCTY")
                                .item(0).getTextContent();
                String irdntTyNm = element.getElementsByTagName("IRDNT_TY_NM")
                                .item(0).getTextContent();

                String str = String.format("%3s %8s %10s %10s %8s",
                        rowNum, recipeId, irdntTyNm, irdntNm, irdntCpcty);
                System.out.println(str);
                System.out.println("-----------------------------------------------------");
            }
        }

    }
    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
		new T03_DOMParsingExam().parse();
	}
}
