<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		String logout = request.getParameter("logout");

		if (logout != null && logout.equals("yes")) {
			session.removeAttribute("id");
			session.removeAttribute("login");
		}
	%>
	<!-- Header -->
	<header id="header">
	<div class="table-wrapper">
		<form name="login" method="post" action="Login.jsp">
			<table>
				<tbody>
					<tr>
						<td>ID</td>
						<td><input type="text" name="id" id="text_box"
							style="width: 100%; color: black;" required /> <br /></td>
					</tr>
					<tr>
						<td>PASSWORD</td>
						<td><input type="text" name="pwd" id="text_box"
							style="width: 100%; color: black;" required /> <br /></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" value="Login" id="login" /> <input
				type="button" value="Join" id="join" />
		</form>
	</div>
	</header>

	<!-- Main -->
	<div id="main" style="margin-top: -100px;">
		<form name="join" method="post" action="Join.jsp">
			<table id="main_table">
				<tr>
					<td>ID</td>
					<td><input type="text" name="id" id="text_box"
						background-color="#7F7F7F" required /> <br /></td>
				</tr>
				<tr>
					<td>PASSWORD
					<td><input type="password" name="pwd" id="text_box" required />
						<br /></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><input type="text" name="name" id="text_box" required />
						<br /></td>
				</tr>
				<tr>
					<td>BIRTH</td>
					<td><input type="date" name="birth" id="text_box" required />
						<br /></td>
				</tr>
				<tr>
					<td>SEX(남/여)</td>
					<td><input type="text" name="sex" required></td>
				</tr>
				<tr>
					<td><input type="submit" name="submit" value="JOIN"></td>
					<td><input type="button" name="reset"
						onclick="location.href='BeforeMain.jsp?logout=yes'" value="RESET"></td>
				</tr>
			</table>
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
	</div>
	</footer>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>