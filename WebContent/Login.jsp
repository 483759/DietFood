<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,com.DietDB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	Connection conn = DietDB.connect();

	String sql = "select * from user where usr_id = ?";

	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		String password;
		String name;
		int num;
		rs.next();
		num = rs.getInt("usr_num");
		name = rs.getString("usr_name");
		password = rs.getString("usr_pwd");

		DietDB.disconnect(rs);
		DietDB.disconnect(pstmt);

		if (password.equals(pwd)) { //로그인에 성공했을 때
			response.sendRedirect("Main.jsp");
			session.setAttribute("UserId", num);
			session.setAttribute("name", name);
			session.setAttribute("login", "yes");
		} else {
			out.println("<script language='javascript'>");
			out.println("alert('비밀번호가 틀렸습니다!');");
			out.println("location.href = 'BeforeMain.jsp';");
			out.println("</script>");
		}
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("<script language='javascript'>");
		out.println("alert('계정이 존재하지 않습니다');");
		out.println("location.href = 'BeforeMain.jsp';");
		out.println("</script>");
	} finally {
		DietDB.disconnect(conn);
	}
%>