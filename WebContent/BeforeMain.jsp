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
						<td><input type="password" name="pwd" id="text_box"
							style="width: 100%; color: black;" required /> <br /></td>
					</tr>
					
				</tbody>
			</table>
			<input type="submit" value="Login" id="login" /> <input
				type="button" onclick="location.href='JoinPage.jsp'" value="Join">
		</form>
	</div>
	</header>

	<!-- Main -->
	<div id="main">
		<h1>Recommend Diet food</h1>
		<h2>by Web Application</h2>
		<h5>다이어트(Diet)란 식이 요법으로서 '체중이나 영양 섭취를 조절하기위한 고의적인 음식 선택'이라는 뜻도
			있지만 '전반적인 건강을 유지하거나 향상시키는 것을 돕는 과정'이라는 뜻도 있습니다. 저희는 사용자의 건강 상태를 입력하면,
			부족하거나 과한 영양을 보충할 수 있는 음식 재료와 식단 선택에 있어 도움을 주는 웹 어플리케이션을 제공합니다.</h5>
		<img
			src="https://natashaskitchen.com/wp-content/uploads/2017/07/Avocado-Chicken-Salad-2-600x900.jpg">
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