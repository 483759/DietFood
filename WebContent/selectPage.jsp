<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,com.DietDB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Recommend Diet food</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<style>
#igd_name {
	color: black;
	text-decoration: none !important;
}
</style>
</head>
<body class="is-preload">
	<%
		request.setCharacterEncoding("UTF-8");
		String name = (String) session.getAttribute("name");
		int num = (int) session.getAttribute("UserId");

		String logout = request.getParameter("logout");

		if (logout != null && logout.equals("yes")) {
			session.removeAttribute("id");
			session.removeAttribute("login");
		}
	%>
	<!-- Header -->
	<header id="header">
	<div class="inner">
		<a href="#" class="image avatar"><img src="images/avatar.jpg"
			alt="" /></a>
		<h1>
			I am
			<%=name%></h1>
		<!-- 건강상태 테이블 만들어놧으니까 건강상태 정보 세션으로 받아와서 여기서 나타나게 하면 됨-->
		<h3></h3>

	</div>
	</header>

	<!-- Main -->
	<div id="main">

		<!-- One -->
		<section id="one"> <header class="major"> <a
			href="#" class="button" onclick="location.href='conditionView.jsp'"
			value="submit">나의 건강상태 보기 </a> <a href="#" class="button"
			onclick="location.href='recommendPage.jsp'" value="submit">추천재료/음식
			보기 </a> <a href="#" class="button"
			onclick="location.href='selectPage.jsp'" value="submit">재료 선택하기 </a>
		<ul class="actions">
			<li></li>
		</ul>

		</header> </section>

		<!-- Two -->
		<section id="two">
		<table>
		<h5>재료를 선택하면 그 재료로 구성된 음식의 목록을 제공합니다.</h5>
			<%
				Connection conn = DietDB.connect();
				ResultSet rs = null;
				

				String sql = "select i.*, im.igd_img from ingredient i join igdimg im on i.igd_num=im.igd_num;";
				//모든 재료 목록 및 사진을 불러오기 위한 쿼리문
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int igd_num = rs.getInt("igd_num");
					String igd_name = rs.getString("igd_name");
					String igd_img = rs.getString("igd_img");
					out.println("<tr>");
					out.println("<td><a>" + igd_num + "</a></td>");
					out.println("<td><img src='"+igd_img+"' width='120' height='100'></td>");
					out.println("<td><a href='selectFoodPage.jsp?igd_num=" + igd_num + "'id='igd_name'>" + igd_name	+ "</a></td>");
					out.println("</tr>");
				}
			%>
		</table>
		</section>
	</div>

	<!-- Footer -->
	<footer id="footer">
	<div class="inner">
		<ul class="icons">
			<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
			<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
			<li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
			<li><a href="#" class="icon fa-envelope-o"><span
					class="label">Email</span></a></li>
		</ul>
		<ul class="copyright">
			<li>&copy; Untitled</li>
			<li>Design: <a href="http://html5up.net">이진&치호</a></li>
		</ul>
		<ul>
			<li><input type="button" class="btn btn-dark" value="로그아웃"
				onclick="location.href='BeforeMain.jsp?logout=yes'"></li>
		</ul>
	</div>
	</footer>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
	<%
		DietDB.disconnect(rs);
		DietDB.disconnect(pstmt);
		DietDB.disconnect(conn);
	%>

</body>
</html>