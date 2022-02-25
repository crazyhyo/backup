/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2021-10-25 00:50:53 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.html;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import kr.or.ddit.member.vo.MemberVO;

public final class memUpdate_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("kr.or.ddit.member.vo.MemberVO");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");

	MemberVO vo = (MemberVO) session.getAttribute("vo");
	int memCode = 0; // 비회원
	String myPage = "";
	
	if(vo.getMemCode() == 1){				// 개인회원
		memCode = vo.getMemCode();
		myPage = "/CodePeople/html/myPagePerson.html";
	} else if (vo.getMemCode() == 2){		// 기업회원
		memCode = vo.getMemCode();
		myPage = "/CodePeople/html/myPageCompany.html";
	} else if(vo.getMemCode() == 3){		// 관리자
		memCode = vo.getMemCode();
		myPage = "/CodePeople/html/myPageAdmin.html";
	}


      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"ko\">\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("\t<title>회원정보 수정</title>\r\n");
      out.write("\t<meta charset=\"utf-8\">\r\n");
      out.write("\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n");
      out.write("\t<script src=\"https://kit.fontawesome.com/d3ee6ce800.js\" crossorigin=\"anonymous\"></script>\r\n");
      out.write("\t<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("\t<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("\t<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\r\n");
      out.write("\t<script src=\"//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js\"></script>\r\n");
      out.write("\t<script src=\"/CodePeople/js/jquery-3.6.0.min.js\"></script>\r\n");
      out.write("  <script src=\"/CodePeople/js/jquery.serializejson.min.js\"></script>\r\n");
      out.write("  \r\n");
      out.write("  <link rel=\"stylesheet\" href=\"/CodePeople/css/main.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" href=\"/CodePeople/css/memInfo.css\">\r\n");
      out.write("\r\n");
      out.write("  <script src=\"/CodePeople/js/join.js\"></script>\r\n");
      out.write("  \r\n");
      out.write("  <style>\r\n");
      out.write("    .zipInput{\r\n");
      out.write("      display: flex;\r\n");
      out.write("    }\r\n");
      out.write("  .form-control.zip{\r\n");
      out.write("    width: 50%;\r\n");
      out.write("    margin: 0px;\r\n");
      out.write("    margin-right: 10px;\r\n");
      out.write("  }\r\n");
      out.write("  </style>\r\n");
      out.write("\t<script>\r\n");
      out.write("\t$(function () {\r\n");
      out.write("\t  $(\".list-group .memInfo\").click(function (e) {\r\n");
      out.write("\t\t    let submenu = $(this).next(\"ul\");\r\n");
      out.write("\r\n");
      out.write("\t\t    if (submenu.is(\":visible\")) {\r\n");
      out.write("\t\t      submenu.slideUp();\r\n");
      out.write("\t\t    } else {\r\n");
      out.write("\t\t      submenu.slideDown();\r\n");
      out.write("\t\t    }\r\n");
      out.write("\t\t  });\r\n");
      out.write("\t});\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\t<!-- 헤더 -->\r\n");
      out.write("\t<div id=\"header\">\r\n");
      out.write("\t\t<!-- 헤더 메인 메뉴 바 -->\r\n");
      out.write("\t\t<div id=\"header-container\">\r\n");
      out.write("\t\t\t<!-- 좌측 메뉴 -->\r\n");
      out.write("\t\t\t<div id=\"header-left-menu\">\r\n");
      out.write("\t\t\t\t<!-- 로고 -->\r\n");
      out.write("\t\t\t\t<a href=\"\" id=\"logo\"><i class=\"fas fa-copyright\" style=\"font-size: 32px;\"></i></a>\r\n");
      out.write("\t\t\t\t<div class=\"divider\"></div>\r\n");
      out.write("\t\t\t\t<!-- 통합 검색창 -->\r\n");
      out.write("\t\t\t\t<div id=\"search-box\">\r\n");
      out.write("\t\t\t\t\t<div id=\"search-item\">\r\n");
      out.write("\t\t\t\t\t\t<i class=\"fas fa-search item\" style=\"width:15.3px; height:19px;\"> </i>\r\n");
      out.write("\t\t\t\t\t\t<input class=\"\" type=\"text\" style=\"height:19px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;\" placeholder=\"통합검색\">\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<!-- 우측 메뉴 -->\r\n");
      out.write("\t\t\t<div id=\"header-right-menu\">\r\n");
      out.write("\t\t\t\t<!-- 메인 메뉴 링크 -->\r\n");
      out.write("\t\t\t\t<div id=\"header-link-box\">\r\n");
      out.write("\t\t\t\t\t<a class=\"header-link\" href=\"/CodePeople/rehearsal/mainHr.html\">인재</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"header-link\" href=\"/CodePeople/rehearsal/company.html\">기업</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"header-link\" href=\"/CodePeople/rehearsal/mainJo.html\">채용</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"header-link\" href=\"/CodePeople/rehearsal/mainBoard.html\">커뮤니티</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"header-link\" href=\"");
      out.print(myPage);
      out.write("\">마이페이지</a>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"divider\"></div>\r\n");
      out.write("\t\t\t\t<!-- 로그인버튼 -->\r\n");
      out.write("\t\t\t\t<a href=\"/CodePeople/html/home.html\"><button id=\"header-login-btn\" class=\"btn btn-primary btn-sm\">로그아웃</button></a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<!-- 바디 -->\r\n");
      out.write("\t<div id=\"body\">\r\n");
      out.write("\r\n");
      out.write("\t\t<div id=\"body-container\">\r\n");
      out.write("\t\t\t<!-- 마이페이지 좌측 메뉴바 -->\r\n");
      out.write("\t\t\t<div class=\"nav-left-bar nav-my\">\r\n");
      out.write("\t\t\t\t<div class=\"nav-sticky\">\r\n");
      out.write("\t\t\t\t\t<ul class=\"list-group\">\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item \"><a class=\"nav-link\" href=\"#cv\">이력서</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\"\thref=\"#fav-company\">관심기업</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\"\thref=\"#fav-jo\">관심공고</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\" href=\"#\">캘린더</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\" href=\"#\">유료서비스</a></li>\r\n");
      out.write("\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link memInfo\">회원정보</a>\r\n");
      out.write("\t\t\t\t\t\t\t<ul class=\"infoList\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\thref=\"/CodePeople/html/memUpdate.jsp\">회원정보수정</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\thref=\"/CodePeople/html/memDelete.jsp\">회원탈퇴</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t<li class=\"list-group-item\"><a class=\"nav-link\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\thref=\"/CodePeople/html/memCertification.html\">재직증명신청</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t</ul></li>\r\n");
      out.write("\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<!-- 바디 콘텐츠 -->\r\n");
      out.write("\t\t\t<div id=\"content\">\r\n");
      out.write("\t\t\t\t<!-- 마이페이지 -->\r\n");
      out.write("\t\t\t\t<!-- 회원정보 수정 -->\r\n");
      out.write("\t\t\t\t<div id=\"cv\" class=\"content-box search-result jo my-main-cv\">\r\n");
      out.write("\t\t\t\t\t<div class=\"my-box-item\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"my-box-header\">\r\n");
      out.write("\t\t\t\t\t\t\t<h1 class=\"h1\">회원정보 수정</h1>\r\n");
      out.write("\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<p>수정할 내용을 아래 기재란에 입력해 주세요.</p>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<div class=\"card card-cv\" style=\"padding: 0px;\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<form class=\"card-body card-right\" id=\"memberUpdateForm\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 mt-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>아이디</label> <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t <input type=\"text\" class=\"form-control\" id=\"memId\" name=\"memId\" placeholder=\"");
      out.print(vo.getMemId() );
      out.write("\" value=\"");
      out.print(vo.getMemId() );
      out.write("\" readonly>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 mt-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>비밀번호</label> <br> \r\n");
      out.write("\t\t\t\t\t\t\t\t<label class=\"la2\" for=\"memPw\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t*&nbsp;비밀번호는 8~16자로 영문 대 소문자, 숫자, 특수문자로 이루어져야 합니다.\r\n");
      out.write("\t\t\t\t\t\t\t\t\t </label>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t <input type=\"password\" class=\"form-control\" id=\"pass\" name=\"memOrignlPw\" required>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t <span class=\"error_next_box green\" id=\"pswd1Msg-green\" style=\"display: none\" aria-live=\"assertive\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  나쁘지않네요.\r\n");
      out.write("\t\t\t\t\t\t\t\t\t   </span>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t <span class=\"error_next_box\" id=\"pswd1Msg\" style=\"display: none;\" aria-live=\"assertive\"> \r\n");
      out.write("\t\t\t\t\t\t\t\t\t 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.\r\n");
      out.write("\t\t\t\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 mt-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>비밀번호 재확인</label> <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t <input type=\"password\" class=\"form-control\" id=\"pass2\" required>\r\n");
      out.write("\t\t\t\t\t\t\t\t  <span class=\"error_next_box\" id=\"pswd2Msg\" style=\"display: none;\" aria-live=\"assertive\">\r\n");
      out.write("\t\t\t\t\t\t\t\t  비밀번호가 일치하지 않습니다.\r\n");
      out.write("\t\t\t\t\t\t\t\t  </span>\r\n");
      out.write("\t\t\t\t\t\t\t\t  <span class=\"error_next_box green\" id=\"pswd2Msg-green\" style=\"display: none\" aria-live=\"assertive\">\r\n");
      out.write("\t\t\t\t\t\t\t\t  비밀번호가 일치합니다!\r\n");
      out.write("\t\t\t\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>전화번호</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"tel\" class=\"form-control\" id=\"tel\" name=\"memTel\" required>\r\n");
      out.write("\t\t\t\t\t\t\t\t<span class=\"error_next_box\" id=\"telMsg\" style=\"display: none;\" aria-live=\"assertive\">\r\n");
      out.write("\t\t\t\t\t\t\t\t휴대폰 번호를 다시 확인해 주세요.\r\n");
      out.write("\t\t\t\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 mt-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>이메일 주소</label> <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"email\" class=\"form-control\" id=\"memEmail\" name=\"memEmail\" required>\r\n");
      out.write("\t\t\t\t\t\t\t\t<span class=\"error_next_box\" id=\"emailMsg\" style=\"display:none;\" aria-live=\"assertive\">이메일 주소를 다시 확인해 주세요.</span>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 mt-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>생년월일</label> <br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"date\" class=\"form-control\" id=\"memBir\" name=\"memBir\" required>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3 zip\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>우편번호</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"zipInput\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<input type=\"text\" class=\"form-control zip\" id=\"postCode\" readonly>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<input type=\"button\" onclick=\"proc();\" value=\"우편번호 검색\" />\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>주소1</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"text\" class=\"form-control\" id=roadAddress readonly>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label>주소2</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"text\" class=\"form-control\" id=\"detailAddress\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" class=\"form-control\" id=cityCodeNo name=\"cityCodeNo\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"hidden\" class=\"form-control\" id=\"provCodeNo\" name=\"provCodeNo\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"hidden\" class=\"form-control\" id=\"memCode\" name=\"memCode\" value=\"");
      out.print(vo.getMemCode() );
      out.write("\" readonly>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<button type=\"button\" class=\"btn btn-outline-primary\" id=\"memberUpdateBtn\">수정하기</button>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t<!--  풋터-->\r\n");
      out.write("\t<div id=\"footer\">\r\n");
      out.write("\t\t<div id=\"footer-container\"></div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
