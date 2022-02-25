/*
 * 21/09/15 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class T02_DOMParsingTest {

    public void parse() throws ParserConfigurationException, SAXException, IOException {

        // DOM document개겣를 생성하기 위한 메서드
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

        // DocumentBuilder 객체 생성하기
        DocumentBuilder builder = dbf.newDocumentBuilder();

        // DOM 파서로부터 입력바든 파일을 파싱하도록 요청
        String url;
		url = new File("./src/new_book.xml").toURI().toString();
		
		System.out.println(url);
		
        Document document = builder.parse(url);

        // DOM Document 객체로부터 루트 엘리먼트 및 자식 객체 가져오기
        Element root = document.getDocumentElement();
        System.out.println("루트 엘리먼트 태그명 : " + root.getTagName());

        // 하위 엘리먼트 접근방법1 : getElementsByTagName() 메서드 이용
        NodeList bookNodeList = root.getElementsByTagName("book");
        Node firstBookNode = bookNodeList.item(0);  // 첫 번째 항목
        Element firstBookElement = (Element) firstBookNode;

        // 속성 접근방법1: 엘리먼트 객체의 getAttribute() 이용
        System.out.println("엘리먼트 객체의 getAttribute()이용 => "
                + firstBookElement.getAttribute("isbn"));

        // 속성 접근방법2: 노드 객체의 getAttribute()메서드 이용(속성노드를 접근)
        NamedNodeMap nodeMap = firstBookNode.getAttributes();
        System.out.println("노드 객체의 getAttribute() 이용 => "
                + nodeMap.getNamedItem("isbn").getNodeValue());

        // 하위 엘리먼트 접근방법2 : getChildNodes()메서드 이용
        NodeList firstBookChildNodeList = firstBookNode.getChildNodes();
        // #text노드(공백문자)때문에 인텍스 값을 1로 설정해야 함.
        Node titleNode = firstBookChildNodeList.item(1);
        Element titleElement = (Element) titleNode;
        System.out.println("titleElement.getTagName() => "
                + titleElement.getTagName());
        System.out.println("titleElement.getContent() => "
                + titleElement.getTextContent());

        // 전체 출력하기
        System.out.println("-------------------------------------------------------------------");
        System.out.printf("%8s %8s %15s %10s %8s\n",
                "ISBN", "분류", "제목", "저자", "가격");
        System.out.println("-------------------------------------------------------------------");
        for(int i=0; i<bookNodeList.getLength(); i++){
            Node bookNode = bookNodeList.item(i);
            Element element = (Element) bookNode;
            String isbn = element.getAttribute("isbn");
            String kind = element.getAttribute("kind");
            String title = element.getElementsByTagName("title").item(0).getTextContent().trim();
            String author = element.getElementsByTagName("author").item(0).getTextContent().trim();
            String price = element.getElementsByTagName("price").item(0).getTextContent().trim();
            String str = String.format("%8s %8s %15s %10s %8s",
                    isbn, kind, title, author, price);
            System.out.println(str);
            
        }
        
    }

    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {

        new T02_DOMParsingTest().parse();
    }
}
