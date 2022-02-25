<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><decorator:title default="HeHe System" /></title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js"></script>
<decorator:head />
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper" style="max-width: 1280px; margin: 0 auto;">

		<!-- Navbar -->
		<nav class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links -->
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" data-widget="pushmenu" href="#" role="button">
						<i class="fas fa-bars"></i>
					</a>
				</li>



			</ul>

			<!-- Right navbar links -->
			<ul class="navbar-nav ml-auto">

				<!-- 로그인 확인  -->
				<li class="nav-item">
					<div class="user-panel mt-3 d-flex">
						<div class="media">
							<img src="https://source.unsplash.com/random" alt="User Avatar" style="width: 40px;height: 40px;" class="img-size-50 img-circle mr-3">
							<div class="media-body">
								<p class="dropdown-item-title"><b>테스트</b>님 안녕하세요.</p>
									 <span class="float-right text-sm text-danger"></span>
								
								<input class="btn btn-block btn-primary btn-xs" style="background-color:#5b6f90; border-color:#5b6f90;" type="button" value="로그아웃"/>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</nav>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4" style="background-color: #5b6f90;">
			<!-- Brand Logo -->
			<div class="brand-link mt-2 pb-3 mb-3 d-flex" style="
			background:url(<%=request.getContextPath()%>/resources/bootstrap/dist/img/compass.jpg);
			background-size:cover;
			background-position:center;
			background-repeat:no-repeat;
			height:97px;
			"
			></div>

			<!-- Sidebar -->
			<div class="sidebar">
				<!-- Sidebar user panel (optional) -->
				<c:if test="${!empty loginUser }">
					<div class="user-panel mt-3 pb-3 mb-3 d-flex">
						<div class="image">
							<img src="<%=request.getContextPath() %>/member/getPicture.do?picture=${loginUser.picture}" class="img-circle elevation-2" alt="User Image">
						</div>

						<div class="info">
							<div class="row">
								<a href="javascript:OpenWindow('<%=request.getContextPath() %>/member/detail.do?id=${loginUser.id }','내정보', '800', '700');" class="d-block">${loginUser.name}</a>
								&nbsp;&nbsp;
								<button onclick="location.href='<%=request.getContextPath()%>/common/logout.do';" class="btn btn-xs btn-primary col-xs-3" type="button">LOGOUT</button>
							</div>
							<a href="tel:${loginUser.phone}">tel : ${loginUser.phone }</a>
							<br>

							<a href="mailto:${loginUser.email }">email : ${loginUser.email }</a>
						</div>
					</div>
				</c:if>
				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column subMenuList" data-widget="treeview" role="menu" data-accordion="false">
						<!-- Add icons to the links using the .nav-icon classwith font-awesome or any other icon font library -->
						<li class="nav-item subMenu">
							<a href="javascript:goPage('<%=request.getContextPath()%>{{murl}}','{{mcode}}');" class="nav-link">
								<i class="{{micon}}"></i>
								<p>또잉~!</p>
							</a>
						</li>
						<li class="nav-item subMenu">
							<a href="javascript:goPage('<%=request.getContextPath()%>{{murl}}','{{mcode}}');" class="nav-link">
								<i class="{{micon}}"></i>
								<p>또잉~@</p>
							</a>
						</li>
						<li class="nav-item subMenu">
							<a href="javascript:goPage('<%=request.getContextPath()%>{{murl}}','{{mcode}}');" class="nav-link">
								<i class="{{micon}}"></i>
								<p>또잉~#</p>
							</a>
						</li>
					</ul>
				</nav>
				<!-- /.sidebar-menu -->
			</div>
			<!-- /.sidebar -->
		</aside>
		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
			<div class="p-3">
				<h5>Title</h5>
				<p>Sidebar content</p>
			</div>
		</aside>
		<!-- /.control-sidebar -->