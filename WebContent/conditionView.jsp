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
</head>
<body class="is-preload">
	<%
		request.setCharacterEncoding("UTF-8");
		String name = (String) session.getAttribute("name");
		int num = (int) session.getAttribute("UserId");
		int isNull;

		String logout = request.getParameter("logout");

		if (logout != null && logout.equals("yes")) {
			session.removeAttribute("id");
			session.removeAttribute("login");
		}

		Connection conn = DietDB.connect();
		ResultSet rs = null;

		String sql = "select * from health where usr_num = ?"; //이미 저장된 유저의 건강상태 정보가 있는지 확인하기 위한 쿼리문
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();

		if (rs.next()) { //저장되어 있는 건강상태 정보가 있다면(불러오기)
			isNull = 0;
		} else { //저장되어 있는 건강상태 정보가 없다면
			isNull = 1;
		}
	%>
	<!-- Header -->
	<header id="header">
	<div class="table-wrapper">
		<h1>
			I am
			<%=name%></h1>
	</div>
	</header>

	<!-- Main -->
	<div id="main">
		<form name="condition" method="post" action="conditionPage.jsp">
			<c:set var="isNull" value="<%=isNull%>"></c:set>
			<c:if test="${isNull==1}">
				<h3>없습니다!</h3>
				<table>
					<tr>
						<td><input type="submit" name="" value="INSERT"></td>
						<td><input type="button" name="reset"
							onclick="location.href='Main.jsp'" value="CANCEL"></td>
					</tr>
				</table>
			</c:if>
			<c:if test="${isNull==0}">
				<%
					int height = rs.getInt("hlt_height");
						int weight = rs.getInt("hlt_weight");
						int sugar = rs.getInt("hlt_sugar");
						int fat = rs.getInt("hlt_fat");
						int maxbp = rs.getInt("hlt_maxbp");
						int minbp = rs.getInt("hlt_minbp");
						int cholesterol = rs.getInt("hlt_cholesterol");
				%>
				<table id="main_table">
				<caption>건강상태 확인하기</caption>
					<tr>
						<td>Height</td>
						<td><input type="number" name="height" id="text_box"
							background-color="#7F7F7F" value="<%=height%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Weight
						<td><input type="number" name="weight" id="text_box"
							value="<%=weight%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Sugar_lv(empty stomach)</td>
						<td><input type="number" name="sugar" id="text_box"
							value="<%=sugar%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Body_fat(Percentage)</td>
						<td><input type="number" name="body_fat" id="text_box"
							value="<%=fat%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Max_Blood_pressure</td>
						<td><input type="number" name="max_blood_pressure"
							id="text_box" value="<%=maxbp%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Min_Blood_pressure</td>
						<td><input type="number" name="min_blood_pressure"
							id="text_box" value="<%=minbp%>" disabled /> <br /></td>
					</tr>
					<tr>
						<td>Cholesterol(mg/dL)</td>
						<td><input type="number" name="cholesterol" id="text_box"
							value="<%=cholesterol%>" disabled /> <br /></td>
					</tr>

					<tr>
						<td><input type="submit" name="" value="MODIFY"></td>
						<td><input type="button" name="reset"
							onclick="location.href='Main.jsp'" value="CANCEL"></td>
					</tr>
				</table>
			</c:if>
		</form>
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