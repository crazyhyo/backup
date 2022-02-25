/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2022-02-25 03:33:30 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import kr.or.ddit.cmm.vo.JobOpeningPagingVO;
import java.util.Map;
import kr.or.ddit.jobOpening.vo.JobOpeningVO;
import java.util.List;

public final class jobOpeningCardPagingList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("java.util.Map");
    _jspx_imports_classes.add("kr.or.ddit.cmm.vo.JobOpeningPagingVO");
    _jspx_imports_classes.add("kr.or.ddit.jobOpening.vo.JobOpeningVO");
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("jobOpeningCardPagingList");

	JobOpeningPagingVO pagingVO = (JobOpeningPagingVO) request.getAttribute("PagingVO");

      out.write("\r\n");
      out.write("{\r\n");
      out.write("\t\"joInfo\" :\t\t\r\n");
      out.write("\t\t\t[\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t");

				for(int i = 0; i < list.size(); i++){
					if(i > 0){
				out.print(",");
					}
					Map<String, Object> vo = list.get(i);
					
					String rnum = String.valueOf(vo.get("RNUM"));
					String comNm = String.valueOf(vo.get("COM_NM"));
					String comIntro = String.valueOf(vo.get("COM_INTRO"));
					String joTitle = String.valueOf(vo.get("JO_TITLE"));
					String joSdate = String.valueOf(vo.get("JO_SDATE"));
					String joEdate = String.valueOf(vo.get("JO_EDATE"));
					String jgCodeNm = String.valueOf(vo.get("JG_CODE_NM"));
					String jtCodeNm = String.valueOf(vo.get("JT_CODE_NM"));
					String joSalTypeNm = String.valueOf(vo.get("JO_SAL_TYPE_NM"));
					
			
      out.write("\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t{\t\r\n");
      out.write("\t\t\t\t\t\t\t\"rnum\" : \"");
      out.print(rnum);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"comNm\" : \"");
      out.print(comNm);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"comIntro\" : \"");
      out.print(comIntro);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"joTitle\" : \"");
      out.print(joTitle);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"joSdate\" : \"");
      out.print(joSdate);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"joEdate\" : \"");
      out.print(joEdate);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"jgCodeNm\" : \"");
      out.print(jgCodeNm);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"jtCodeNm\" : \"");
      out.print(jtCodeNm);
      out.write("\",\r\n");
      out.write("\t\t\t\t\t\t\t\"joSalTypeNm\" : \"");
      out.print(joSalTypeNm);
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t");
		
					
				}
			
      out.write("\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t],\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\"pageCount\" : \"");
      out.print(pagingVO.getPageSize() );
      out.write("\",\r\n");
      out.write("\t\t\"countPerPage\" : \"");
      out.print(pagingVO.getCountPerPage() );
      out.write("\",\r\n");
      out.write("\t\t\"firstPage\" : \"");
      out.print(pagingVO.getFirstPageNo() );
      out.write("\",\r\n");
      out.write("\t\t\"firstRecord\" : \"");
      out.print(pagingVO.getFirstRecNo() );
      out.write("\",\r\n");
      out.write("\t\t\"lastPage\" : \"");
      out.print(pagingVO.getLastPageNo() );
      out.write("\",\r\n");
      out.write("\t\t\"lastRecord\" : \"");
      out.print(pagingVO.getLastRecNo() );
      out.write("\",\r\n");
      out.write("\t\t\"totalCount\" : \"");
      out.print(pagingVO.getTotalCount() );
      out.write("\",\r\n");
      out.write("\t\t\"totalPageCount\" : \"");
      out.print(pagingVO.getTotalPageCount() );
      out.write("\",\r\n");
      out.write("\t\t\"currentPage\" : \"");
      out.print(pagingVO.getCurrentPageNo() );
      out.write("\"\r\n");
      out.write("}");
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
