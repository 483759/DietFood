<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,com.DietDB"%>

<%
	request.setCharacterEncoding("UTF-8");
	String username = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String birth = request.getParameter("birth");
	String tel = request.getParameter("tel");

	Connection conn = DietDB.connect();

	String sql ="insert into user(usr_name, usr_id, usr_pwd, usr_birth, usr_phone) values(?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, username);
	pstmt.setString(2, id);
	pstmt.setString(3, pwd);
	pstmt.setString(4, birth);
	pstmt.setString(5, tel);

	pstmt.executeUpdate();

	DietDB.disconnect(pstmt);
	DietDB.disconnect(conn);

	pageContext.forward("BeforeMain.jsp");
%>