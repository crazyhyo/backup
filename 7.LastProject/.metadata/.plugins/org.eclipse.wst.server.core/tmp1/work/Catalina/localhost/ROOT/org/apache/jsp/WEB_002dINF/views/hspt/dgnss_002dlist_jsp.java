/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2022-01-21 10:32:06 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.hspt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class dgnss_002dlist_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(5);
    _jspx_dependants.put("jar:file:/D:/A_TeachingMaterial/7.LastProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/covid_compass/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./dgnss-detail-module-work.jsp", Long.valueOf(1642760526371L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./dgnss-list-module-work.jsp", Long.valueOf(1642752744583L));
    _jspx_dependants.put("jar:file:/D:/A_TeachingMaterial/7.LastProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/covid_compass/WEB-INF/lib/jstl-1.2.jar!/META-INF/fmt.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1642670665618L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
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

      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<style>\r\n");
      out.write(".pbht {\r\n");
      out.write("\tcolor: #f56954;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".ltct {\r\n");
      out.write("\tcolor: #3c8dbc\r\n");
      out.write("}\r\n");
      out.write(".on{\r\n");
      out.write("\tbackground-color: rgb(236, 236, 236);\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<title></title>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("  <section class=\"content\">\r\n");
      out.write("    <div class=\"row\" style=\"margin: 1px; margin-top: 7px;\">\r\n");
      out.write("      <div class=\"col-lg-6 pl-0\">\r\n");
      out.write("        <section class=\"content\">\r\n");
      out.write("          <div class=\"card\" style=\"margin: 1px; height: 763px; margin-top: 13px;\">\r\n");
      out.write("            <div class=\"card-header d-flex p-0\">\r\n");
      out.write("              <ul class=\"nav nav-pills ml-auto p-2\" role=\"tablist\">\r\n");
      out.write("                <li class=\"nav-item\"><div class=\"input-group float-right\" style=\"max-width: 600px; width: 300px;\">\r\n");
      out.write("                    <!-- search bar -->\r\n");
      out.write("\t\t\t\t\t<select class=\"form-control \" name=\"searchType\" id=\"searchType\">\r\n");
      out.write("\t\t\t\t\t\t<option value=\"\" ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageMaker.cri.searchType eq '' ? 'selected':''}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(">검색구분</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"n\"\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageMaker.cri.searchType eq 'n' ? 'selected':''}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(">성명</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"t\"\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageMaker.cri.searchType eq 't' ? 'selected':''}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(">연락처</option>\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\r\n");
      out.write("                    <!-- keyword -->\r\n");
      out.write("                    <input class=\"form-control\" type=\"text\" name=\"keyword\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageMaker.cri.keyword }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\" style=\"width: 18%; display: inline-block;\" /> <span class=\"input-group-append\">\r\n");
      out.write("                      <button class=\"btn btn-primary\" type=\"button\" id=\"searchBtn\" style=\"background: #1a4f72; color: #ffffff; border-color: #1a4f72; display: inline-block; margin-bottom: 4px; margin-left: -7px;\" data-card-widget=\"search\" onclick=\"\">\r\n");
      out.write("                        <i class=\"fa fa-fw fa-search\"></i>\r\n");
      out.write("                      </button>\r\n");
      out.write("                    </span>\r\n");
      out.write("                    <!-- end : search bar -->\r\n");
      out.write("                  </div></li>\r\n");
      out.write("              </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"card-body\">\r\n");
      out.write("              <div class=\"tab-content\" id=\"custom-tabs-three-tabContent\">\r\n");
      out.write("                <div class=\"tab-pane fade show active\" id=\"custom-psti-detail\" role=\"tabpanel\" aria-labelledby=\"custom-tabs-three-home-tab\">\r\n");
      out.write("                  ");
      out.write("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js\"></script>\r\n");
      out.write("<script type=\"text/x-handlebars-template\"  id=\"dgnss-list-template\" >\r\n");
      out.write("{{#each .}}\r\n");
      out.write("          <tr\r\n");
      out.write("\t\t\tdata-inst-no=\"{{instNo}}\" data-manage-no=\"{{manageNo}}\" data-dgnss-no=\"{{dgnssNo}}\" data-child-no=\"{{childNo}}\"\r\n");
      out.write("\t\t\tdata-type=\"{{type}}\"\r\n");
      out.write("            onclick=\"showDetail('{{manageNo}}', '{{dgnssNo}}')\"\r\n");
      out.write("            class=\"each-dgnss-element\">\r\n");
      out.write("            <td><span class=\"{{addClass pbhtNm ltctNm}}\" data-inst-nm=\"{{manageNo}}\">{{getInstNm pbhtNm ltctNm}}</span></td>\r\n");
      out.write("            <td>{{pstiNm}}</td>\r\n");
      out.write("            <td>{{age}}</td>\r\n");
      out.write("            <td>{{pstiTelno}}</td>\r\n");
      out.write("            <td>{{prettifyDate reqYmd}}</td>\r\n");
      out.write("            <td>{{vacType}}</td>\r\n");
      out.write("          </tr>\r\n");
      out.write("{{/each}}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/x-handlebars-template\"  id=\"inptnt-pagination-template\" >\r\n");
      out.write("    <li class=\"page-item each-inptnt-pagination-element\"><a class=\"page-link\" href=\"1\"> <i class=\"fas fa-angle-double-left\" style=\"color:#1a4f72;\"></i>\r\n");
      out.write("    </a></li>\r\n");
      out.write("    <li class=\"page-item each-inptnt-pagination-element\"><a class=\"page-link\" href=\"{{#if prev}}{{prevPageNum}}{{/if}}\"> <i class=\"fas fa-angle-left\" style=\"color:#1a4f72;\"></i>\r\n");
      out.write("    </a></li>\r\n");
      out.write("\r\n");
      out.write("{{#each pageNum}}\r\n");
      out.write("    <li class=\"page-item each-inptnt-pagination-element {{signActive this}}\" ><a class=\"page-link\" href=\"{{this}}\" >{{this}}</a></li>\r\n");
      out.write("{{/each}}\r\n");
      out.write("\r\n");
      out.write("    <li class=\"page-item each-inptnt-pagination-element\"><a class=\"page-link\" href=\"{{#if next}}{{nextPageNum}}{{/if}}\"> <i class=\"fas fa-angle-right\" style=\"color:#1a4f72;\"></i>\r\n");
      out.write("    </a></li>\r\n");
      out.write("    <li class=\"page-item each-inptnt-pagination-element\"><a class=\"page-link\" href=\"{{realEndPage}}\"> <i class=\"fas fa-angle-double-right\" style=\"color:#1a4f72;\"></i>\r\n");
      out.write("</a></li>\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("Handlebars.registerHelper({\r\n");
      out.write("\"prettifyDate\" : function(timeValue){\r\n");
      out.write("  var dateObj = new Date(timeValue);\r\n");
      out.write("  var year = dateObj.getFullYear();\r\n");
      out.write("  var month = dateObj.getMonth() + 1;\r\n");
      out.write("  var date = dateObj.getDate();\r\n");
      out.write("  return year + \"-\" + month + \"-\" + date;\r\n");
      out.write("},\r\n");
      out.write("\"signActive\" : function(pageNum){\r\n");
      out.write("  if(pageNum == page) return 'active';\r\n");
      out.write("},\r\n");
      out.write("\"getInstNm\" : function(pbhtNm, ltctNm){\r\n");
      out.write("\t\r\n");
      out.write("\treturn pbhtNm || ltctNm;\r\n");
      out.write("},\r\n");
      out.write("\"addClass\" : function(pbhtNm, ltctNm){\r\n");
      out.write("\tif(pbhtNm){\r\n");
      out.write("\t\treturn \"pbht\";\r\n");
      out.write("\t}\r\n");
      out.write("\tif(ltctNm){\r\n");
      out.write("\t\treturn \"ltct\";\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("var page = 1;\r\n");
      out.write("var myManageNo = '';\r\n");
      out.write("\r\n");
      out.write("window.onload = function(){\r\n");
      out.write("\r\n");
      out.write("  var url = '");
      out.print(request.getContextPath() );
      out.write("/rest-hspt/dgnss-list';\r\n");
      out.write("  \r\n");
      out.write("  list_go(page, url);\r\n");
      out.write("\t$('ul.pagination').on('click','li a',function(event){\r\n");
      out.write("\t\tif($(this).attr(\"href\")) {\r\n");
      out.write("\t\t\tpage=$(this).attr(\"href\");\r\n");
      out.write("\t\t\tgetPage(url, make_form(page));\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\treturn false;\r\n");
      out.write("\t});\r\n");
      out.write("}\r\n");
      out.write("function make_form(pageParam){\r\n");
      out.write("  var jobForm=$('#jobForm');\r\n");
      out.write("  \r\n");
      out.write("  if(!pageParam) page = 1;\r\n");
      out.write("  \r\n");
      out.write("  page = pageParam;\r\n");
      out.write("  \r\n");
      out.write("  jobForm.find(\"[name='page']\").val(page);\r\n");
      out.write("  jobForm.find(\"[name='perPageNum']\").val($('select[name=\"perPageNum\"]').val());\r\n");
      out.write("//  jobForm.find(\"[name='perPageNum']\").val(2);\r\n");
      out.write("  jobForm.find(\"[name='searchType']\").val($('select[name=\"searchType\"]').val());\r\n");
      out.write("  jobForm.find(\"[name='keyword']\").val($('div.input-group>input[name=\"keyword\"]').val());\r\n");
      out.write("  \r\n");
      out.write("  return jobForm;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function list_go(pageParam, url){\r\n");
      out.write("\t\r\n");
      out.write("  getPage(url, make_form(pageParam));\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function getPage(handelbarsProcessingURL, form){\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t$.ajax({\r\n");
      out.write("    url : handelbarsProcessingURL,\r\n");
      out.write("    type : 'get',\r\n");
      out.write("    dataType : 'json',\r\n");
      out.write("    data : form.serialize(),\r\n");
      out.write("    success : function(dataMap){\r\n");
      out.write("      printData(dataMap.dgnssList, $('#dgnss-list-table-tbody'), $('#dgnss-list-template'), '.each-dgnss-element');\r\n");
      out.write("      printPagination(dataMap.pageMaker, $('#inptnt-list-pagination-ul'), $('#inptnt-pagination-template'), '.each-inptnt-pagination-element');\r\n");
      out.write("    },\r\n");
      out.write("    error : function(error){\r\n");
      out.write("      alert('error' + error.status);\r\n");
      out.write("    }\r\n");
      out.write("  })\r\n");
      out.write(" }\r\n");
      out.write(" \r\n");
      out.write("//jsonArray는 ResponseEntity에서 넣어준 List가 들어가는 자리\r\n");
      out.write("//target은 handlebars로 생성한 마크업을 append할 대상으로 jquery객체이며 리스트에서 쓸 경우 보통 tbody에 id를 줘서 target으로 잡는다.\r\n");
      out.write("//templateObject는 handlebars를 이용하여 만든 템플릿으로 jquery객체이다.\r\n");
      out.write("//removeClass는 append하기전에 기존에 있던 리스트<여기서는 handlebars로 붙인 요소 목록>를 지우기 위해서 '.(클래스이름)'을 넣는다.\r\n");
      out.write("//이를 위하여 templateObject에서 handlebars로 붙인 요소 목록를 지칭할 class를 주어야 한다. 여기서는 .each-inptnt-element이며,\r\n");
      out.write("//tr태그에 붙어있다.\r\n");
      out.write("function printData(jsonArray, target, templateObject, removeClass){\r\n");
      out.write("\r\n");
      out.write("\t// templateObject를 json data를 받으면 마크업을 return하는 function template로 반환한다.\r\n");
      out.write("\tvar template = Handlebars.compile(templateObject.html());\r\n");
      out.write("\t\r\n");
      out.write("\t// 함수 template에 파라미터 jsonArray를 넣어서 실행하여 html을 생성한다.\r\n");
      out.write("\tvar html = template(jsonArray);\r\n");
      out.write("\t\r\n");
      out.write("\t// 해당 html요소를 append하기 전에 기존에 있던 내용을 지운다. (안그러면 리스트 목록이 10개씩만 보이는 게 아니라 10개, 20개, 30개 등 페이지 클릭할 때마다 10개씩 추가되므로)\r\n");
      out.write("\t$(removeClass).remove();\r\n");
      out.write("\t\r\n");
      out.write("\t// html요소를 append한다.\r\n");
      out.write("\ttarget.append(html);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function printPagination(pageMaker, target, templateObject, removeClass){\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tvar pageNum = new Array(pageMaker.endPage-pageMaker.startPage+1);\r\n");
      out.write("\t\r\n");
      out.write("\tfor(var i=0;i<pageMaker.endPage-pageMaker.startPage+1;i++){\r\n");
      out.write("\t\tpageNum[i]=pageMaker.startPage+i;\r\n");
      out.write("\t}\t\r\n");
      out.write("\tpageMaker.pageNum=pageNum;  \r\n");
      out.write("\tpageMaker.prevPageNum=pageMaker.startPage-1;\r\n");
      out.write("\tpageMaker.nextPageNum=pageMaker.endPage+1;\r\n");
      out.write("\t\r\n");
      out.write("\tvar template=Handlebars.compile(templateObject.html());\t\r\n");
      out.write("\tvar html = template(pageMaker);\t\r\n");
      out.write("\ttarget.html(\"\").html(html);\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<section class=\"content\">\r\n");
      out.write("  <div style=\"height: 640px;\">\r\n");
      out.write("    <div class=\"table-responsive\">\r\n");
      out.write("      <table class=\"table table-hover text-nowrap\" style=\"text-align: center;\">\r\n");
      out.write("\r\n");
      out.write("        <thead>\r\n");
      out.write("          <tr role=\"row\">\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-label=\"\">요청기관</th>\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-label=\"\">성명</th>\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-sort=\"ascending\" aria-label=\"\">나이</th>\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-sort=\"ascending\" aria-label=\"\">연락처</th>\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-label=\"\">진료요청일자</th>\r\n");
      out.write("            <th tabindex=\"0\" aria-controls=\"example2\" rowspan=\"1\" colspan=\"1\" aria-label=\"\">백신접종여부</th>\r\n");
      out.write("          </tr>\r\n");
      out.write("        </thead>\r\n");
      out.write("        <tbody id=\"dgnss-list-table-tbody\">\r\n");
      out.write("\r\n");
      out.write("          <tr class=\"each-dgnss-element\">\r\n");
      out.write("            <td colspan=\"6\">페이지를 로딩중입니다.</td>\r\n");
      out.write("          </tr>\r\n");
      out.write("        </tbody>\r\n");
      out.write("      </table>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"card-footer clearfix\" style=\"background-color: white;\">\r\n");
      out.write("    <ul class=\"pagination justify-content-center m-0\" id=\"inptnt-list-pagination-ul\">\r\n");
      out.write("    </ul>\r\n");
      out.write("  </div>\r\n");
      out.write("<form id=\"jobForm\">\r\n");
      out.write("  <input type='hidden' name=\"page\" value=\"\" />\r\n");
      out.write("  <input type='hidden' name=\"perPageNum\" value=\"\"/>\r\n");
      out.write("  <input type='hidden' name=\"searchType\" value=\"\" />\r\n");
      out.write("  <input type='hidden' name=\"keyword\" value=\"\" />\r\n");
      out.write("</form>\r\n");
      out.write("</section>\r\n");
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <!-- /.card -->\r\n");
      out.write("          </div>\r\n");
      out.write("\r\n");
      out.write("        </section>\r\n");
      out.write("\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"col-lg-6 pr-0\">\r\n");
      out.write("        <section class=\"content\">\r\n");
      out.write("          <div class=\"card\" style=\"margin: 1px; height: 763px; margin-top: 13px;\">\r\n");
      out.write("            <div class=\"card-header d-flex p-0\">\r\n");
      out.write("              <ul class=\"nav nav-pills ml-auto p-2\" role=\"tablist\">\r\n");
      out.write("                <li class=\"nav-item\"><a class=\"nav-link active\" id=\"psti-detail-tab\" data-toggle=\"pill\" href=\"#custom-dgnss-detail\" role=\"tab\" aria-controls=\"custom-tabs-three-home\" aria-selected=\"true\" style=\"cursor: default; background-color: #1a4f72;\">환자 상세</a></li>\r\n");
      out.write("              </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"card-body\">\r\n");
      out.write("              <div class=\"tab-content\" id=\"custom-tabs-three-tabContent\">\r\n");
      out.write("                <div class=\"tab-pane fade show active\" id=\"custom-dgnss-detail\" role=\"tabpanel\" aria-labelledby=\"custom-tabs-three-home-tab\">\r\n");
      out.write("                  ");
      out.write("<script type=\"text/x-handlebars-template\" id=\"dgnss-detail-template\">\r\n");
      out.write("<table class=\"table table-bordered dgnss-detail-info\">\r\n");
      out.write("    <thead>\r\n");
      out.write("      <tr style=\"text-align: center;\">\r\n");
      out.write("        <th>성명</th>\r\n");
      out.write("        <td>{{pstiNm}}</td>\r\n");
      out.write("        <th>국적</th>\r\n");
      out.write("        <td>{{nlty}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("    </thead>\r\n");
      out.write("    <tbody>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>진료요청일자</th>\r\n");
      out.write("        <td>{{prettifyDate reqYmd}}</td>\r\n");
      out.write("        <th>백신접종</th>\r\n");
      out.write("        <td>{{vacType}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>성별</th>\r\n");
      out.write("        <td>{{gender}}</td>\r\n");
      out.write("        <th>나이</th>\r\n");
      out.write("        <td>{{age}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>확정일자</th>\r\n");
      out.write("        <td>{{prettifyDate resYmd}}</td>\r\n");
      out.write("        <th>결과</th>\r\n");
      out.write("        <td>{{pstvYn}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>발열여부</th>\r\n");
      out.write("        <td>{{feverYn}}</td>\r\n");
      out.write("        <th>임신여부</th>\r\n");
      out.write("        <td>{{pregnYn}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>주민/외국인등록번호</th>\r\n");
      out.write("        <td>{{rrn}}</td>\r\n");
      out.write("        <th>연락처</th>\r\n");
      out.write("        <td>{{pstiTelno}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>주소</th>\r\n");
      out.write("        <td colspan=\"3\">{{pstiAdres}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("        <th>증상</th>\r\n");
      out.write("        <td colspan=\"3\">{{symptms}}</td>\r\n");
      out.write("      </tr>\r\n");
      out.write("    </tbody>\r\n");
      out.write("  </table>\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("var dgnssResultForm = '';\r\n");
      out.write("\r\n");
      out.write("function disableButton(){\r\n");
      out.write("// \tconsole.log($('button[name=\"inptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"sckbdreq-inptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"sckbdreq-isoptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"slfptnt-button\"]')[0]);\r\n");
      out.write("\t$('select[name=\"statusCode\"]').val(\"\");\r\n");
      out.write("\t$('button[name=\"inptnt-button\"]').attr('disabled', true);\r\n");
      out.write("\t$('button[name=\"sckbdreq-inptnt-button\"]').attr('disabled', true);\r\n");
      out.write("\t$('button[name=\"sckbdreq-isoptnt-button\"]').attr('disabled', true);\r\n");
      out.write("\t$('button[name=\"slfptnt-button\"]').attr('disabled', true);\r\n");
      out.write("}\r\n");
      out.write("function enableButton(value){\r\n");
      out.write("// \tconsole.log($('button[name=\"inptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"sckbdreq-inptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"sckbdreq-isoptnt-button\"]')[0]);\r\n");
      out.write("// \tconsole.log($('button[name=\"slfptnt-button\"]')[0]);\r\n");
      out.write("\tif(value){\r\n");
      out.write("\t\t$('button[name=\"inptnt-button\"]').attr('disabled', false);\r\n");
      out.write("\t\t$('button[name=\"sckbdreq-inptnt-button\"]').attr('disabled', false);\r\n");
      out.write("\t\t$('button[name=\"sckbdreq-isoptnt-button\"]').attr('disabled', false);\r\n");
      out.write("\t\t$('button[name=\"slfptnt-button\"]').attr('disabled', false);\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\tdisableButton();\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function showDetail(manageNo, dgnssNo){\r\n");
      out.write("\t\r\n");
      out.write("\tdisableButton();\r\n");
      out.write("\t\r\n");
      out.write("\tvar trs = $('tr.each-dgnss-element');\r\n");
      out.write("\t\r\n");
      out.write("\ttrs.removeClass('on');\r\n");
      out.write("\t\r\n");
      out.write("\tvar target = $('tr[data-manage-no=\"'+manageNo+'\"]');\r\n");
      out.write("\t\r\n");
      out.write("\ttarget.addClass('on');\r\n");
      out.write("\t\r\n");
      out.write("\tvar instNm = $('span[data-inst-nm=\"'+manageNo+'\"]').html();\r\n");
      out.write("\t\r\n");
      out.write("\tvar childNo = target.attr('data-child-no');\r\n");
      out.write("\tvar type = target.attr('data-type');\r\n");
      out.write("\tvar dgnssNo = target.attr('data-dgnss-no');\r\n");
      out.write("\tvar manageNo = target.attr('data-manage-no');\r\n");
      out.write("\t\r\n");
      out.write("\t//alert($('input[name=\"instNm\"]'));\r\n");
      out.write("\t\r\n");
      out.write("\t$('form[name=\"dgnssResultForm\"] input[name=\"childNo\"]').val(childNo);\r\n");
      out.write("\t$('form[name=\"dgnssResultForm\"] input[name=\"type\"]').val(type);\r\n");
      out.write("\t$('form[name=\"dgnssResultForm\"] input[name=\"dgnssNo\"]').val(dgnssNo);\r\n");
      out.write("\t$('form[name=\"dgnssResultForm\"] input[name=\"manageNo\"]').val(manageNo);\r\n");
      out.write("\t\r\n");
      out.write("\tvar url = '");
      out.print(request.getContextPath());
      out.write("/rest-hspt/dgnss-detail';\r\n");
      out.write("\t$.ajax({\r\n");
      out.write("\t    url : url,\r\n");
      out.write("\t    type : 'post',\r\n");
      out.write("\t    data : {\r\n");
      out.write("\t    \t\t'manageNo' : manageNo\r\n");
      out.write("\t    \t\t},\r\n");
      out.write("\t    dataType : 'json',\r\n");
      out.write("\t    success : function(dgnssDetailCommand){\r\n");
      out.write("\t    \tprintData(dgnssDetailCommand, $('#dgnss-detail-info-module'), $('#dgnss-detail-template'), '.dgnss-detail-info');\r\n");
      out.write("\t    \t$('#req-inst-nm').html();\r\n");
      out.write("\t    },\r\n");
      out.write("\t    error : function(error){\r\n");
      out.write("\t      alert('error' + error.status);\r\n");
      out.write("\t    }\r\n");
      out.write("\t  });\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function inptnt_go(){\r\n");
      out.write("\t\r\n");
      out.write("\t$('input[name=\"dgnssResultCode\"]').val($('select[name=\"statusCode\"]').val());\r\n");
      out.write("\t$('form[name=\"dgnssResultForm\"] input[name=\"dgnssNote\"]').val($('textarea[name=\"dgnssNote\"]').val());\r\n");
      out.write("\t\r\n");
      out.write("\tdgnssResultForm = $('form[name=\"dgnssResultForm\"]');\r\n");
      out.write("\t\r\n");
      out.write("\tvar inptnt_go_url = '");
      out.print(request.getContextPath());
      out.write("/rest-hspt/process-dgnss-inptnt';\r\n");
      out.write("\t\r\n");
      out.write("\tdgnssResultForm.attr({\r\n");
      out.write("\t\t'action' : inptnt_go_url,\r\n");
      out.write("\t\t'method' : 'post'\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\tconsole.log(dgnssResultForm[0]);\r\n");
      out.write("\t\r\n");
      out.write("\tdgnssResultForm.submit();\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<div>\r\n");
      out.write("\t<div class=\"\" id=\"dgnss-detail-info-module\">\r\n");
      out.write("\t\t<table class=\"table table-bordered dgnss-detail-info\">\r\n");
      out.write("\t\t\t<thead>\r\n");
      out.write("\t\t\t\t<tr style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>성명</th>\r\n");
      out.write("\t\t\t\t\t<td>홍길동</td>\r\n");
      out.write("\t\t\t\t\t<th>국적</th>\r\n");
      out.write("\t\t\t\t\t<td>KOR</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</thead>\r\n");
      out.write("\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>진료요청일자</th>\r\n");
      out.write("\t\t\t\t\t<td>2021-01-12</td>\r\n");
      out.write("\t\t\t\t\t<th>백신접종</th>\r\n");
      out.write("\t\t\t\t\t<td>3차 이상</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>성별</th>\r\n");
      out.write("\t\t\t\t\t<td>남</td>\r\n");
      out.write("\t\t\t\t\t<th>나이</th>\r\n");
      out.write("\t\t\t\t\t<td>27</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>확정일자</th>\r\n");
      out.write("\t\t\t\t\t<td>2022-01-01</td>\r\n");
      out.write("\t\t\t\t\t<th>결과</th>\r\n");
      out.write("\t\t\t\t\t<td>양성</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>발열여부</th>\r\n");
      out.write("\t\t\t\t\t<td>Y</td>\r\n");
      out.write("\t\t\t\t\t<th>임신여부</th>\r\n");
      out.write("\t\t\t\t\t<td>N</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>주민/외국인등록번호</th>\r\n");
      out.write("\t\t\t\t\t<td>960101-1111111</td>\r\n");
      out.write("\t\t\t\t\t<th>연락처</th>\r\n");
      out.write("\t\t\t\t\t<td>010-5678-1234</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>주소</th>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"3\">대전광역시 서구 둔산동 1032 70호8</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>증상</th>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"3\">기침, 두통, 복통, 어지러움</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</tbody>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div>\r\n");
      out.write("\t\t<table class=\"table table-bordered\">\r\n");
      out.write("\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t<tr class=\"shittr\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t\t<th>진료 결과</th>\r\n");
      out.write("\t\t\t\t\t<td style=\"padding-top: 4px; padding-botton: 4px;\"><select\r\n");
      out.write("\t\t\t\t\t\tclass=\"form-control col-sm-12\" name=\"statusCode\" onchange=\"enableButton(this.value);\">\r\n");
      out.write("\t\t\t\t\t\t\t<option value=\"\">진단</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=\"D101\">중증 및 중등증</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=\"D102\">미중증 및 경증</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=\"D103\">무증상</option>\r\n");
      out.write("\t\t\t\t\t</select></td>\r\n");
      out.write("\t\t\t\t\t<th>요청기관</th>\r\n");
      out.write("\t\t\t\t\t<td id=\"req-inst-nm\">대덕보건소</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"4\" style=\"padding-bottom: 0px; text-align: center;\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-sm-2\">\r\n");
      out.write("\t\t\t\t\t\t\t<label for=\"inputPassword3\"\r\n");
      out.write("\t\t\t\t\t\t\t\tclass=\"control-label text-center\"\r\n");
      out.write("\t\t\t\t\t\t\t\tstyle=\"padding-top: 7px;\">진료 메모</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"col-sm-10 row\" style=\"margin-top : 5px;\" align=\"right\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<div class=\"col-md-3\">\r\n");
      out.write("\t\t\t\t\t\t\t<button\r\n");
      out.write("\t\t\t\t\t\t\t\t\tstyle=\"background-color: #1a4f72; border-color: #1a4f72;\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\ttype=\"button\" name=\"inptnt-button\" class=\"btn btn-block btn-primary btn-sm\" onclick=\"inptnt_go();\">입원</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-md-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<button\r\n");
      out.write("\t\t\t\t\t\t\t\t\tstyle=\"background-color: #1a4f72; border-color: #1a4f72;\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\ttype=\"button\" name=\"sckbdreq-inptnt-button\" class=\"btn btn-block btn-primary btn-sm\" onclick=\"OpenWindow('sckbd-request', '병원 조회', 1200,800)\">이원</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-md-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<button\r\n");
      out.write("\t\t\t\t\t\t\t\t\tstyle=\"background-color: #1a4f72; border-color: #1a4f72;\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\ttype=\"button\" name=\"sckbdreq-isoptnt-button\" class=\"btn btn-block btn-primary btn-sm\" onclick=\"OpenWindow('sckbd-ltct-request', '센터 조회', 1200,800)\">생활치료센터</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-md-3\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<button\r\n");
      out.write("\t\t\t\t\t\t\t\t\tstyle=\"background-color: #1a4f72; border-color: #1a4f72;\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\ttype=\"button\" name=\"slfptnt-button\" class=\"btn btn-block btn-primary btn-sm\">자가격리</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group row\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-sm-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<textarea name=\"dgnssNote\" class=\"form-control\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tid=\"inputPassword3\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tstyle=\"height: 207px; width: 97%; margin: 10px; margin-top: 0; margin-bottom: 0;\"></textarea>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</tbody>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<form name=\"dgnssResultForm\">\r\n");
      out.write("\tchildNo<input type=\"text\" name=\"childNo\">\r\n");
      out.write("\ttype<input type=\"text\" name=\"type\">\r\n");
      out.write("\tdgnssResultCode<input type=\"text\" name=\"dgnssResultCode\">\r\n");
      out.write("\tdgnssNote<input type=\"text\" name=\"dgnssNote\">\r\n");
      out.write("\tmanageNo<input type=\"text\" name=\"manageNo\">\r\n");
      out.write("\tdgnssNo<input type=\"text\" name=\"dgnssNo\">\r\n");
      out.write("\ttoLtctNo<input type=\"text\" name=\"toLtctNo\">\r\n");
      out.write("\ttoHsptNo<input type=\"text\" name=\"toHsptNo\">\r\n");
      out.write("</form>\r\n");
      out.write("</div>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <!-- /.card -->\r\n");
      out.write("          </div>\r\n");
      out.write("          <!-- search bar -->\r\n");
      out.write("        </section>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- /.card-body -->\r\n");
      out.write("  </section>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
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
