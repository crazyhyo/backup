/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2022-01-21 07:21:58 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.hspt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class main_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(5);
    _jspx_dependants.put("/WEB-INF/views/hspt/./main-dgnss-module.jsp", Long.valueOf(1642667025251L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./main-reqsckbd-module.jsp", Long.valueOf(1642667025251L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./main-sckbd-module.jsp", Long.valueOf(1642667025251L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./main-inptnt-module.jsp", Long.valueOf(1642667025251L));
    _jspx_dependants.put("/WEB-INF/views/hspt/./main-chart-module.jsp", Long.valueOf(1642667025251L));
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
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js\"></script>\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js\"></script>\r\n");
      out.write("<style>\r\n");
      out.write(".card-title {\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("\tcolor: #333333;\r\n");
      out.write("\tfont-size: 16px;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<title></title>\r\n");
      out.write("\r\n");
      out.write("<body id=\"myPage\" data-spy=\"scroll\" data-target=\".navbar\"\r\n");
      out.write("\tdata-offset=\"50\">\r\n");
      out.write("\t<div style=\"box-sizing: content-box; padding: 16px; margin-top: 6px;\">\r\n");
      out.write("\t\t<div class=\"#\">\r\n");
      out.write("\t\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t\t");
      out.write("<div class=\"card\"\r\n");
      out.write("\tstyle=\"position: relative; margin-left: 0px; left: 0px; top: 0px; width: 412px;\">\r\n");
      out.write("\t<div class=\"card-header ui-sortable-handle\">\r\n");
      out.write("\t\t<h3 class=\"card-title\">\r\n");
      out.write("\t\t\t<i class=\"ion ion-clipboard mr-1\"></i>????????????\r\n");
      out.write("\t\t</h3>\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"card-tools\">\r\n");
      out.write("\t\t\t<ul class=\"pagination pagination-sm\">\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">1</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">2</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">3</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div class=\"card-body\" style=\"padding: 0px;\">\r\n");
      out.write("\t\t<div class=\"table-responsive\">\r\n");
      out.write("\t\t\t<table class=\"table m-0 \" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t<thead>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">????????????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">????????????</th>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</thead>\r\n");
      out.write("\t\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</tbody>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
      out.write("<div class=\"card\"\r\n");
      out.write("\tstyle=\"position: relative; left: 15px; top: 0px; width: 850px;\">\r\n");
      out.write("\t<div class=\"card-header ui-sortable-handle\">\r\n");
      out.write("\t\t<h3 class=\"card-title\">\r\n");
      out.write("\t\t\t<i class=\"ion ion-clipboard mr-1\"></i>???????????? ????????????\r\n");
      out.write("\t\t</h3>\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"card-tools\">\r\n");
      out.write("\t\t\t<ul class=\"pagination pagination-sm\">\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">1</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">2</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">3</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div class=\"card-body\" style=\"padding: 0px;\">\r\n");
      out.write("\t\t<div class=\"table-responsive\">\r\n");
      out.write("\t\t\t<table class=\"table m-0\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t<thead>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"width: 10%; text-align: center;\">????????????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"width: 10%; text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">?????????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">?????????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">????????????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"width: 10%; text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"width: 10%; text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</thead>\r\n");
      out.write("\t\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td><a href=\"pages/examples/invoice.html\"></a></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\t<td><button style=\"width: 70px; margin-left: 18px;\"\r\n");
      out.write("\t\t\t\t\t\t\t\ttype=\"button\" class=\"btn btn-block btn-success btn-xs\">??????</button></td>\r\n");
      out.write("\t\t\t\t\t\t<td><button style=\"width: 70px; margin-left: 18px;\"\r\n");
      out.write("\t\t\t\t\t\t\t\ttype=\"button\" class=\"btn btn-block btn-warning btn-xs\">??????</button></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td><a href=\"pages/examples/invoice.html\">?????????</a></td>\r\n");
      out.write("\t\t\t\t\t\t<td>27</td>\r\n");
      out.write("\t\t\t\t\t\t<td>010-7777-7777</td>\r\n");
      out.write("\t\t\t\t\t\t<td>2021/01/10</td>\r\n");
      out.write("\t\t\t\t\t\t<td>????????????</td>\r\n");
      out.write("\t\t\t\t\t\t<td><button style=\"width: 70px; margin-left: 18px;\"\r\n");
      out.write("\t\t\t\t\t\t\t\ttype=\"button\" class=\"btn btn-block btn-success btn-xs\">??????</button></td>\r\n");
      out.write("\t\t\t\t\t\t<td><button style=\"width: 70px; margin-left: 18px;\"\r\n");
      out.write("\t\t\t\t\t\t\t\ttype=\"button\" class=\"btn btn-block btn-warning btn-xs\">??????</button></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t</tbody>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
      out.write("</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"#\">\r\n");
      out.write("\t\t\t<div class=\"row\" style=\"position: relative; margin-top: 13px;\">\r\n");
      out.write("\t\t\t\t");
      out.write("<div class=\"card\"\r\n");
      out.write("\tstyle=\"position: relative; margin-left: 0px; left: 0px; top: 0px; width: 412px;\">\r\n");
      out.write("\t<div class=\"card-header ui-sortable-handle\">\r\n");
      out.write("\t\t<h3 class=\"card-title\">\r\n");
      out.write("\t\t\t<i class=\"ion ion-clipboard mr-1\"></i>????????????\r\n");
      out.write("\t\t</h3>\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"card-tools\">\r\n");
      out.write("\t\t\t<ul class=\"pagination pagination-sm\">\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">1</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">2</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">3</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div class=\"card-body\" style=\"padding: 0px;\">\r\n");
      out.write("\t\t<div class=\"table-responsive\">\r\n");
      out.write("\t\t\t<table class=\"table m-0\" style=\"text-align: center;\">\r\n");
      out.write("\t\t\t\t<thead>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">??????</th>\r\n");
      out.write("\t\t\t\t\t\t<th style=\"text-align: center;\">?????????</th>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</thead>\r\n");
      out.write("\t\t\t\t<tbody>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>?????????</td>\r\n");
      out.write("\t\t\t\t\t\t<td>27</td>\r\n");
      out.write("\t\t\t\t\t\t<td>???</td>\r\n");
      out.write("\t\t\t\t\t\t<td>2021/07/31</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td>?????????</td>\r\n");
      out.write("\t\t\t\t\t\t<td>27</td>\r\n");
      out.write("\t\t\t\t\t\t<td>???</td>\r\n");
      out.write("\t\t\t\t\t\t<td>2021/07/31</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</tbody>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
      out.write("<div class=\"card\" style=\"position: relative; left: 15px; top: 0px; width: 850px;\">\r\n");
      out.write("          <div class=\"card-header ui-sortable-handle\">\r\n");
      out.write("            <h3 class=\"card-title\">\r\n");
      out.write("              <i class=\"ion ion-clipboard mr-1\"></i>????????????\r\n");
      out.write("            </h3>\r\n");
      out.write("\r\n");
      out.write("            <div class=\"card-tools\">\r\n");
      out.write("              <ul class=\"pagination pagination-sm\">\r\n");
      out.write("                <li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("                <li class=\"page-item\"><a href=\"#\" class=\"page-link\">1</a></li>\r\n");
      out.write("                <li class=\"page-item\"><a href=\"#\" class=\"page-link\">2</a></li>\r\n");
      out.write("                <li class=\"page-item\"><a href=\"#\" class=\"page-link\">3</a></li>\r\n");
      out.write("                <li class=\"page-item\"><a href=\"#\" class=\"page-link\">??</a></li>\r\n");
      out.write("              </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"card-body\" style=\"padding: 0px;\">\r\n");
      out.write("            <div class=\"table-responsive\">\r\n");
      out.write("              <table class=\"table m-0\" style=\"text-align: center;\">\r\n");
      out.write("                <thead>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                    <th style=\"width: 10%; text-align: center;\">????????????</th>\r\n");
      out.write("                    <th style=\"width: 10%; text-align: center;\">????????????</th>\r\n");
      out.write("                    <th style=\"text-align: center;\">?????????</th>\r\n");
      out.write("                    <th style=\"text-align: center;\">????????????</th>\r\n");
      out.write("                    <th style=\"text-align: center;\">????????????</th>\r\n");
      out.write("                    <th style=\"width: 10%; text-align: center;\">??????</th>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                </thead>\r\n");
      out.write("                <tbody>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                    <td><span class=\"badge badge-success\">??????</span></td>\r\n");
      out.write("                    <td><a href=\"pages/examples/invoice.html\">?????????</a></td>\r\n");
      out.write("                    <td>010-7777-7777</td>\r\n");
      out.write("                    <td>????????????</td>\r\n");
      out.write("                    <td>01/12 00:11</td>\r\n");
      out.write("                    <td><button style=\"width: 70px; margin-left: 18px;\" type=\"button\" class=\"btn btn-block btn-success btn-xs\">??????</button></td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                    <td><span class=\"badge badge-success\">????????????</span></td>\r\n");
      out.write("                    <td><a href=\"pages/examples/invoice.html\">?????????</a></td>\r\n");
      out.write("                    <td>010-7777-7777</td>\r\n");
      out.write("                    <td>????????????</td>\r\n");
      out.write("                    <td>01/11 15:21</td>\r\n");
      out.write("                    <td><button style=\"width: 70px; margin-left: 18px;\" type=\"button\" class=\"btn btn-block btn-success btn-xs\" disabled>??????</button></td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                </tbody>\r\n");
      out.write("              </table>\r\n");
      out.write("            </div>\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>");
      out.write("</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"#\">\r\n");
      out.write("\t\t\t<div class=\"row\" style=\"position: relative; margin-top: 13px;\">\r\n");
      out.write("\t\t\t\t");
      out.write("<div class=\"card\"\r\n");
      out.write("\tstyle=\"position: relative; left: 0px; top: 0px; width: 850px;\">\r\n");
      out.write("\t<div id=\"myCarousel\" class=\"carousel slide\" data-interval=\"false\">\r\n");
      out.write("\t\t<!-- Indicators -->\r\n");
      out.write("\r\n");
      out.write("\t\t<!-- Wrapper for slides -->\r\n");
      out.write("\t\t<div class=\"carousel-inner\" role=\"listbox\">\r\n");
      out.write("\t\t\t<div class=\"item active\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<canvas id=\"barChart\"\r\n");
      out.write("\t\t\t\t\tstyle=\"min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 644px;\"\r\n");
      out.write("\t\t\t\t\twidth=\"644\" height=\"250\" class=\"chartjs-render-monitor\"></canvas>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<div class=\"item\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<canvas id=\"pieChart\"\r\n");
      out.write("\t\t\t\t\tstyle=\"min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 644px;\"\r\n");
      out.write("\t\t\t\t\twidth=\"644\" height=\"250\" class=\"chartjs-render-monitor\"></canvas>\r\n");
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t<!-- Left and right controls -->\r\n");
      out.write("\t\t<a class=\"left carousel-control\" href=\"#myCarousel\" role=\"button\"\r\n");
      out.write("\t\t\tstyle=\"background-image: none;\"prev\"> <span\r\n");
      out.write("\t\t\tclass=\"glyphicon glyphicon-chevron-left\" aria-hidden=\"true\"></span> <span\r\n");
      out.write("\t\t\tclass=\"sr-only\">Previous</span>\r\n");
      out.write("\t\t</a> <a class=\"right carousel-control\" href=\"#myCarousel\" role=\"button\"\r\n");
      out.write("\t\t\tstyle=\"background-image: none;\" data-slide=\"next\"> <span\r\n");
      out.write("\t\t\tclass=\"glyphicon glyphicon-chevron-right\" aria-hidden=\"true\"></span>\r\n");
      out.write("\t\t\t<span class=\"sr-only\">Next</span>\r\n");
      out.write("\t\t</a>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("    var context = document.getElementById('barChart').getContext('2d');\r\n");
      out.write("    var myChart = new Chart(context, {\r\n");
      out.write("      type : 'bar', // ????????? ??????\r\n");
      out.write("      data : { // ????????? ????????? ?????????\r\n");
      out.write("        labels : [\r\n");
      out.write("        //x ???\r\n");
      out.write("        '1???', '2???', '3???', '4???', '5???', '6???', '7???' ],\r\n");
      out.write("        datasets : [\r\n");
      out.write("            { //?????????\r\n");
      out.write("              label : 'test1', //?????? ??????\r\n");
      out.write("              fill : false, // line ????????? ???, ??? ????????? ???????????? ???????????????\r\n");
      out.write("              data : [ 21, 19, 25, 20, 51, 26, 25 //x??? label??? ???????????? ????????? ???\r\n");
      out.write("              ],\r\n");
      out.write("              backgroundColor : [\r\n");
      out.write("              //??????\r\n");
      out.write("              'rgba(255, 99, 132, 0.2)',\r\n");
      out.write("                  'rgba(54, 162, 235, 0.2)',\r\n");
      out.write("                  'rgba(255, 206, 86, 0.2)',\r\n");
      out.write("                  'rgba(75, 192, 192, 0.2)',\r\n");
      out.write("                  'rgba(153, 102, 255, 0.2)',\r\n");
      out.write("                  'rgba(255, 159, 64, 0.2)' ],\r\n");
      out.write("              borderColor : [\r\n");
      out.write("              //????????? ??????\r\n");
      out.write("              'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',\r\n");
      out.write("                  'rgba(255, 206, 86, 1)',\r\n");
      out.write("                  'rgba(75, 192, 192, 1)',\r\n");
      out.write("                  'rgba(153, 102, 255, 1)',\r\n");
      out.write("                  'rgba(255, 159, 64, 1)' ],\r\n");
      out.write("              borderWidth : 1\r\n");
      out.write("            //????????? ??????\r\n");
      out.write("            }, {\r\n");
      out.write("              label : 'test2',\r\n");
      out.write("              fill : false,\r\n");
      out.write("              data : [ 8, 34, 12, 24 ],\r\n");
      out.write("              backgroundColor : 'rgb(157, 109, 12)',\r\n");
      out.write("              borderColor : 'rgb(157, 109, 12)'\r\n");
      out.write("            } ]\r\n");
      out.write("      },\r\n");
      out.write("      options : {\r\n");
      out.write("        scales : {\r\n");
      out.write("          yAxes : [ {\r\n");
      out.write("            ticks : {\r\n");
      out.write("              beginAtZero : true\r\n");
      out.write("            }\r\n");
      out.write("          } ]\r\n");
      out.write("        }\r\n");
      out.write("      }\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    const data = {\r\n");
      out.write("      labels : [ 'Red', 'Orange', 'Yellow', 'Green', 'Blue' ],\r\n");
      out.write("      datasets : [ {\r\n");
      out.write("        label : 'Dataset 1',\r\n");
      out.write("        data : [ 21, 19, 25, 20, 51 ], //x??? label??? ???????????? ????????? ???\r\n");
      out.write("\r\n");
      out.write("        backgroundColor : [\r\n");
      out.write("        //??????\r\n");
      out.write("        'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 1)',\r\n");
      out.write("            'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)',\r\n");
      out.write("            'rgba(153, 102, 255, 1)' ],\r\n");
      out.write("        borderColor : [\r\n");
      out.write("        //????????? ??????\r\n");
      out.write("        'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)',\r\n");
      out.write("            'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)',\r\n");
      out.write("            'rgba(153, 102, 255, 1)', ],\r\n");
      out.write("        borderWidth : 1\r\n");
      out.write("      } ]\r\n");
      out.write("    };\r\n");
      out.write("\r\n");
      out.write("    var context1 = document.getElementById('pieChart').getContext('2d');\r\n");
      out.write("    var pieChart = new Chart(context1, {\r\n");
      out.write("      type : 'pie',\r\n");
      out.write("      data : data,\r\n");
      out.write("      options : {\r\n");
      out.write("        responsive : true,\r\n");
      out.write("        plugins : {\r\n");
      out.write("          legend : {\r\n");
      out.write("            position : 'right',\r\n");
      out.write("          },\r\n");
      out.write("          title : {\r\n");
      out.write("            display : true,\r\n");
      out.write("            text : 'Chart.js Pie Chart'\r\n");
      out.write("          }\r\n");
      out.write("        }\r\n");
      out.write("      },\r\n");
      out.write("    });\r\n");
      out.write("  </script>");
      out.write("<div class=\"card\"\r\n");
      out.write("\t\t\t\t\tstyle=\"position: relative; left: 15px; top: 0px; width: 412px;\">\r\n");
      out.write("\t\t\t\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "./main-rmdsckbd-module.jsp", out, false);
      out.write("</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("\r\n");
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
