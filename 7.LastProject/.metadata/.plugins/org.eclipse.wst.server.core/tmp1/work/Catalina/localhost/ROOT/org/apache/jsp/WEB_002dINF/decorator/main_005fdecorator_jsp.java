/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2022-01-21 07:21:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.decorator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class main_005fdecorator_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(6);
    _jspx_dependants.put("/WEB-INF/decorator/../views/include/test_main_header.jsp", Long.valueOf(1642667025813L));
    _jspx_dependants.put("jar:file:/D:/A_TeachingMaterial/7.LastProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/covid_compass/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/decorator/../views/include/main_footer.jsp", Long.valueOf(1642667025813L));
    _jspx_dependants.put("jar:file:/D:/A_TeachingMaterial/7.LastProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/covid_compass/WEB-INF/lib/sitemesh-2.4.2.jar!/META-INF/sitemesh-decorator.tld", Long.valueOf(1123645892000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1642670665618L));
    _jspx_dependants.put("/WEB-INF/lib/sitemesh-2.4.2.jar", Long.valueOf(1642670632092L));
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

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdecorator_005ftitle_0026_005fdefault_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdecorator_005fhead_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fdecorator_005fbody_005fnobody;

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
    _005fjspx_005ftagPool_005fdecorator_005ftitle_0026_005fdefault_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdecorator_005fhead_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fdecorator_005fbody_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fdecorator_005ftitle_0026_005fdefault_005fnobody.release();
    _005fjspx_005ftagPool_005fdecorator_005fhead_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
    _005fjspx_005ftagPool_005fdecorator_005fbody_005fnobody.release();
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

      out.write("<!DOCTYPE html>\r\n");
      out.write("<!--\r\n");
      out.write("This is a starter template page. Use this page to start your new project from\r\n");
      out.write("scratch. This page gets rid of all links and provides the needed markup only.\r\n");
      out.write("-->\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"utf-8\">\r\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n");
      out.write("<title>");
      if (_jspx_meth_decorator_005ftitle_005f0(_jspx_page_context))
        return;
      out.write("</title>\r\n");
      out.write("<!-- Google Font: Source Sans Pro -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback\">\r\n");
      out.write("<!-- Font Awesome Icons -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/plugins/fontawesome-free/css/all.min.css\">\r\n");
      out.write("<!-- Theme style -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/dist/css/adminlte.min.css\">\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/plugins/jquery/jquery.min.js\"></script>\r\n");
      out.write("<!-- DataTables -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/plugins/datatables-responsive/css/responsive.bootstrap4.min.css\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath());
      out.write("/resources/bootstrap/plugins/datatables-buttons/css/buttons.bootstrap4.min.css\">\r\n");
      out.write("<style>\r\n");
      out.write("*{\r\n");
      out.write("\tfont-size:13px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      if (_jspx_meth_decorator_005fhead_005f0(_jspx_page_context))
        return;
      out.write("</head>\r\n");
      out.write("<body class=\"hold-transition\">\r\n");
      out.write("\t<div class=\"wrapper\" style=\"max-width: 1280px; margin: 0 auto;\">\r\n");
      out.write("\r\n");
      out.write("\t\t<nav class=\"main-header navbar navbar-expand navbar-white navbar-light\" style=\"margin-left:0px; width: 100%; padding-right: 0;\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t<!-- Left navbar links -->\r\n");
      out.write("\t\t\t<ul class=\"navbar-nav\">\r\n");
      out.write("\t\t\t\t<li class=\"nav-item\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t<div style=\"width: 200px;height: 80px; background-image: url(");
      out.print(request.getContextPath());
      out.write("/resources/image/logoblack.png);   background-size: cover; cursor:pointer;\" onclick=\"logo_go();\"></div>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<!-- Navbar -->\r\n");
      out.write("\r\n");
      out.write("\t\t\t<!-- Right navbar links -->\r\n");
      out.write("\t\t\t<ul class=\"navbar-nav ml-auto\">\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<div style=\"width: 200px; text-align: center; margin-right: 230px; align-self: flex-end; align-items: center;\">\r\n");
      out.write("\t\t\t\t\t<h2>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${loginInst.instNm }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</h2>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<li class=\"nav-item d-none d-sm-inline-block\" style=\"margin-right: 15px; margin-top: 18px;\">\r\n");
      out.write("\t\t\t\t\t<i class=\"fas fa-qrcode fa-3x\" style=\"color:#1a4f72;\"></i>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<!-- 로그인 확인  -->\r\n");
      out.write("\t\t\t\t<li class=\"nav-item\" style=\"margin-right: 25px;\">\r\n");
      out.write("\t\t\t\t\t<div class=\"user-panel mt-3 d-flex\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"media\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"media-body\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<p class=\"dropdown-item-title\">남은시간 10:00</p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<span class=\"float-right text-sm text-danger\"></span> <input class=\"btn btn-block btn-primary btn-xs\" style=\"background-color: #1a4f72; border-color: #1a4f72; width: 110px; width: 110px;\" type=\"button\" value=\"연장하기\" />\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t\t<li class=\"nav-item\">\r\n");
      out.write("\t\t\t\t\t<div class=\"user-panel mt-3 d-flex\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"media\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"media-body\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<p class=\"dropdown-item-title\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<b>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${loginUser.mberNm }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</b>님 안녕하세요.\r\n");
      out.write("\t\t\t\t\t\t\t\t</p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"input-group\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<div class=\"col-md-6 p-0\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<span class=\"float-right text-sm text-danger\"></span> <input class=\"btn btn-block btn-primary btn-xs\" style=\"width: 75px; background-color: #1a4f72; border-color: #1a4f72; margin-right: 5px;\" type=\"button\" value=\"내정보\" /> \r\n");
      out.write("\t\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<div class=\"col-md-6 p-0\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<span class=\"float-right text-sm text-danger\"></span> <input class=\"btn btn-block btn-primary btn-xs\" style=\"width: 75px; background-color: #1a4f72; border-color: #1a4f72;\" type=\"button\" value=\"로그아웃\" onclick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/common/logout.do';\" />\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t</li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</nav>\r\n");
      out.write("\t\t<nav class=\"main-header navbar navbar-expand navbar-white navbar-light\" style=\"width: 100%; margin-left:0px;\">\r\n");
      out.write("\t\t\t<!-- Left navbar links -->\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<ul class=\"navbar-nav\">\r\n");
      out.write("\t\t\t\t");
      //  c:forEach
      org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
      boolean _jspx_th_c_005fforEach_005f0_reused = false;
      try {
        _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
        _jspx_th_c_005fforEach_005f0.setParent(null);
        // /WEB-INF/decorator/../views/include/test_main_header.jsp(98,4) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
        _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/WEB-INF/decorator/../views/include/test_main_header.jsp(98,4) '${menuList }'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${menuList }",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
        // /WEB-INF/decorator/../views/include/test_main_header.jsp(98,4) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
        _jspx_th_c_005fforEach_005f0.setVar("submenu");
        int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
        try {
          int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
          if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            do {
              out.write("<li class=\"nav-item subMenu \" id=\"");
              out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${submenu.menuUrl }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
              out.write("\">\r\n");
              out.write("\t\t\t\t\t\t<a style=\"color: black;\" href=\"javascript:goPage('");
              out.print(request.getContextPath());
              out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${submenu.menuUrl }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
              out.write('\'');
              out.write(',');
              out.write('\'');
              out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${submenu.menuNo }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
              out.write("');\" class=\"nav-link\">\r\n");
              out.write("\t\t\t\t\t\t\t<span>");
              out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${submenu.menuNm }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
              out.write("</span>\r\n");
              out.write("\t\t\t\t\t\t</a>\r\n");
              out.write("\t\t\t\t\t</li>\r\n");
              out.write("\t\t\t\t");
              int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
          }
          if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            return;
          }
        } catch (java.lang.Throwable _jspx_exception) {
          while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
            out = _jspx_page_context.popBody();
          _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
        } finally {
          _jspx_th_c_005fforEach_005f0.doFinally();
        }
        _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
        _jspx_th_c_005fforEach_005f0_reused = true;
      } finally {
        org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fforEach_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fforEach_005f0_reused);
      }
      out.write("</ul>\r\n");
      out.write("\t\t</nav>\r\n");
      out.write("\t\t<!-- /.navbar -->\r\n");
      out.write("\r\n");
      out.write("\t\t<!-- Main Sidebar Container -->\r\n");
      out.write("\t\t<!-- Control Sidebar -->\r\n");
      out.write("\t\t<!-- /.control-sidebar -->\r\n");
      out.write("\t\t\r\n");
      out.write("\t<script>\r\n");
      out.write("\tfunction logo_go(){\r\n");
      out.write("\t\tvar renewURL = location.href;\r\n");
      out.write("\t\tvar former = renewURL.substring(0, renewURL.indexOf('='));\r\n");
      out.write("\t\tvar later = renewURL.substring(renewURL.indexOf('=')).substring(0,4)+\"0000\";\r\n");
      out.write("\t\tlocation.href = former + later;\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\t</script>\t");
      if (_jspx_meth_decorator_005fbody_005f0(_jspx_page_context))
        return;
      out.write("<!-- Control Sidebar -->\r\n");
      out.write("  <aside class=\"control-sidebar control-sidebar-dark\">\r\n");
      out.write("    Control sidebar content goes here\r\n");
      out.write("    <div class=\"p-3\">\r\n");
      out.write("      <h5>Title</h5>\r\n");
      out.write("      <p>Sidebar content</p>\r\n");
      out.write("    </div>\r\n");
      out.write("  </aside>\r\n");
      out.write("  <!-- /.control-sidebar -->\r\n");
      out.write("  <!-- Main Footer -->\r\n");
      out.write("  <footer class=\"main-footer\" style=\"max-width: 1280px; margin: 0 auto;\">\r\n");
      out.write("    <!-- To the right -->\r\n");
      out.write("    <div class=\"float-right d-none d-sm-inline\">\r\n");
      out.write("      Anything you want\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- Default to the left -->\r\n");
      out.write("    <strong>COVID-19 COMPASS</strong>\r\n");
      out.write("  </footer>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- ./wrapper -->\r\n");
      out.write("\r\n");
      out.write("<!-- REQUIRED SCRIPTS -->\r\n");
      out.write("\r\n");
      out.write("<!-- jQuery -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/jquery/jquery.min.js\"></script>\r\n");
      out.write("<!-- Bootstrap 4 -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("<!-- AdminLTE App -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/dist/js/adminlte.min.js\"></script>\r\n");
      out.write("<!-- common.jsa -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/js/common.js\"></script>\r\n");
      out.write("<!-- DataTables  & Plugins -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables/jquery.dataTables.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-responsive/js/dataTables.responsive.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-responsive/js/responsive.bootstrap4.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-buttons/js/dataTables.buttons.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-buttons/js/buttons.bootstrap4.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/jszip/jszip.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/pdfmake/pdfmake.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/pdfmake/vfs_fonts.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-buttons/js/buttons.html5.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-buttons/js/buttons.print.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/datatables-buttons/js/buttons.colVis.min.js\"></script>\r\n");
      out.write("<!-- Summernote -->\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/resources/bootstrap/plugins/summernote/summernote-bs4.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\t$('div.wrapper').css({\r\n");
      out.write("\t\t\"max-width\":\"1280\",\r\n");
      out.write("\t\t\"margin\":\"0 auto\"\t\t\r\n");
      out.write("\t});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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

  private boolean _jspx_meth_decorator_005ftitle_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  decorator:title
    com.opensymphony.module.sitemesh.taglib.decorator.TitleTag _jspx_th_decorator_005ftitle_005f0 = (com.opensymphony.module.sitemesh.taglib.decorator.TitleTag) _005fjspx_005ftagPool_005fdecorator_005ftitle_0026_005fdefault_005fnobody.get(com.opensymphony.module.sitemesh.taglib.decorator.TitleTag.class);
    boolean _jspx_th_decorator_005ftitle_005f0_reused = false;
    try {
      _jspx_th_decorator_005ftitle_005f0.setPageContext(_jspx_page_context);
      _jspx_th_decorator_005ftitle_005f0.setParent(null);
      // /WEB-INF/decorator/../views/include/test_main_header.jsp(14,7) name = default type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_decorator_005ftitle_005f0.setDefault("HeHe System");
      int _jspx_eval_decorator_005ftitle_005f0 = _jspx_th_decorator_005ftitle_005f0.doStartTag();
      if (_jspx_th_decorator_005ftitle_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fdecorator_005ftitle_0026_005fdefault_005fnobody.reuse(_jspx_th_decorator_005ftitle_005f0);
      _jspx_th_decorator_005ftitle_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_decorator_005ftitle_005f0, _jsp_getInstanceManager(), _jspx_th_decorator_005ftitle_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_decorator_005fhead_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  decorator:head
    com.opensymphony.module.sitemesh.taglib.decorator.HeadTag _jspx_th_decorator_005fhead_005f0 = (com.opensymphony.module.sitemesh.taglib.decorator.HeadTag) _005fjspx_005ftagPool_005fdecorator_005fhead_005fnobody.get(com.opensymphony.module.sitemesh.taglib.decorator.HeadTag.class);
    boolean _jspx_th_decorator_005fhead_005f0_reused = false;
    try {
      _jspx_th_decorator_005fhead_005f0.setPageContext(_jspx_page_context);
      _jspx_th_decorator_005fhead_005f0.setParent(null);
      int _jspx_eval_decorator_005fhead_005f0 = _jspx_th_decorator_005fhead_005f0.doStartTag();
      if (_jspx_th_decorator_005fhead_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fdecorator_005fhead_005fnobody.reuse(_jspx_th_decorator_005fhead_005f0);
      _jspx_th_decorator_005fhead_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_decorator_005fhead_005f0, _jsp_getInstanceManager(), _jspx_th_decorator_005fhead_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_decorator_005fbody_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  decorator:body
    com.opensymphony.module.sitemesh.taglib.decorator.BodyTag _jspx_th_decorator_005fbody_005f0 = (com.opensymphony.module.sitemesh.taglib.decorator.BodyTag) _005fjspx_005ftagPool_005fdecorator_005fbody_005fnobody.get(com.opensymphony.module.sitemesh.taglib.decorator.BodyTag.class);
    boolean _jspx_th_decorator_005fbody_005f0_reused = false;
    try {
      _jspx_th_decorator_005fbody_005f0.setPageContext(_jspx_page_context);
      _jspx_th_decorator_005fbody_005f0.setParent(null);
      int _jspx_eval_decorator_005fbody_005f0 = _jspx_th_decorator_005fbody_005f0.doStartTag();
      if (_jspx_th_decorator_005fbody_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fdecorator_005fbody_005fnobody.reuse(_jspx_th_decorator_005fbody_005f0);
      _jspx_th_decorator_005fbody_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_decorator_005fbody_005f0, _jsp_getInstanceManager(), _jspx_th_decorator_005fbody_005f0_reused);
    }
    return false;
  }
}
