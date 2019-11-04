<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,com.DietDB"%>

<%
	request.setCharacterEncoding("UTF-8");
	int height = Integer.parseInt(request.getParameter("height"));
	int weight = Integer.parseInt(request.getParameter("weight"));
	int sugar = Integer.parseInt(request.getParameter("sugar"));
	int body_fat = Integer.parseInt(request.getParameter("body_fat"));
	int maxbp = Integer.parseInt(request.getParameter("max_blood_pressure"));
	int minbp = Integer.parseInt(request.getParameter("min_blood_pressure"));
	int cholesterol = Integer.parseInt(request.getParameter("cholesterol"));
	int usr_num = (int)session.getAttribute("UserId");

	int num = (int) (Math.random() * 1000 + 1);

	Connection conn = DietDB.connect();
	ResultSet rs = null;

	String sql = "select * from health where usr_num = ?"; //이미 저장된 유저의 건강상태 정보가 있는지 확인하기 위한 쿼리문
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setInt(1, usr_num);
	rs = pstmt.executeQuery();

	if (rs.next()) { //이미 저장된 건강상태 정보가 있을 경우(수정)
		String sql2 = "update health set hlt_height=?, hlt_weight=?, hlt_sugar=?, hlt_fat=?, hlt_maxbp=?, hlt_minbp=?, hlt_cholesterol=? where usr_num=?";
		//새로운 건강상태 정보를 수정	
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);

		pstmt2.setInt(1, height);
		pstmt2.setInt(2, weight);
		pstmt2.setInt(3, sugar);
		pstmt2.setInt(4, body_fat);
		pstmt2.setInt(5, maxbp);
		pstmt2.setInt(6, minbp);
		pstmt2.setInt(7, cholesterol);
		pstmt2.setInt(8, usr_num);

		pstmt2.executeUpdate();
		
	} else { //건강상태 정보를 처음 입력할 시(추가)
		out.println("<script language='javascript'>");
		out.println("alert('없습니다!');");
		out.println("</script>");
		String sql2 = "insert into health(hlt_num, hlt_height, hlt_weight, hlt_sugar, hlt_fat, hlt_maxbp, hlt_minbp, hlt_cholesterol, usr_num) values(?,?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);

		pstmt2.setInt(1, num);
		pstmt2.setInt(2, height);
		pstmt2.setInt(3, weight);
		pstmt2.setInt(4, sugar);
		pstmt2.setInt(5, body_fat);
		pstmt2.setInt(6, maxbp);
		pstmt2.setInt(7, minbp);
		pstmt2.setInt(8, cholesterol);
		pstmt2.setInt(9, usr_num);

		pstmt2.executeUpdate();
	}
	
	//건강상태로 사용자에게 필요한 요리 재료 분석 후 추천 테이블에 삽입
	
	String sql3 = "delete from recommend where usr_num=?";	//추천 테이블에 등록되어 있는 사용자의 목록 삭제
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	
	pstmt3.setInt(1, usr_num);
	pstmt3.executeUpdate();
	
	/*혈당수치가 100 이상일 경우 혈당을 내리는데 도움이 되는 재료의 목록 출력하기*/
	String sql4 = "insert into recommend select h.usr_num, h.hlt_num, i.igd_num from health as h, ingredient as i, component as c	where h.hlt_sugar>=120 and i.igd_num=c.igd_num and c.cpn_sgr=1 and h.usr_num=?";
	PreparedStatement pstmt4 = conn.prepareStatement(sql4);
	pstmt4.setInt(1, usr_num);
	pstmt4.executeUpdate();

	/*남자이고 체지방률(몸무게/키^2)이 20 이상일 경우/여자이고 체지방률이 24이상일 경우 체지방을 낮추는데 도움이 되는 재료의 목록 출력하기*/
	sql4 = "insert into recommend select h.usr_num, h.hlt_num, i.igd_num from health as h, ingredient as i, component as c, user u where (u.usr_sex='남'and h.hlt_weight/(h.hlt_height)^2>=20) or (u.usr_sex='여'and h.hlt_weight/(h.hlt_height)^2>=24) and i.igd_num=c.igd_num and c.cpn_fat=1 and h.usr_num=?";
	pstmt4 = conn.prepareStatement(sql4);
	pstmt4.setInt(1, usr_num);
	pstmt4.executeUpdate();

	/*최고 혈압이 120 이상이면서 최저 혈압이 80 이상일 경우 고혈압에 도움이 되는 재료의 목록 출력하기*/
	sql4 = "insert into recommend select h.usr_num, h.hlt_num, i.igd_num from health as h, ingredient as i, component as c where h.hlt_maxbp>=120 and h.hlt_minbp>=80 and i.igd_num=c.igd_num and c.cpn_hbp=1 and h.usr_num=?";
	pstmt4 = conn.prepareStatement(sql4);
	pstmt4.setInt(1, usr_num);
	pstmt4.executeUpdate();

	/*최저 혈압이 100 미만이면서 최저 혈압이 60 미만일 경우 저혈압에 도움이 되는 재료의 목록 출력하기*/
	sql4 = "insert into recommend select h.usr_num, h.hlt_num, i.igd_num from health as h, ingredient as i, component as c where h.hlt_maxbp<100 and h.hlt_minbp<60 and i.igd_num=c.igd_num and c.cpn_lbp=1 and h.usr_num=?";
	pstmt4 = conn.prepareStatement(sql4);
	pstmt4.setInt(1, usr_num);
	pstmt4.executeUpdate();

	/*콜레스테롤 수치가 240 이상일 경우 콜레스테롤 수치를 낮추는데 도움이 되는 재료의 목록 출력하기*/
	sql4 = "insert into recommend select h.usr_num, h.hlt_num, i.igd_num from health as h, ingredient as i, component as c where h.hlt_cholesterol>=240 and i.igd_num=c.igd_num and c.cpn_cls=1 and h.usr_num=?";
	pstmt4 = conn.prepareStatement(sql4);
	pstmt4.setInt(1, usr_num);
	pstmt4.executeUpdate();

	
	DietDB.disconnect(rs);
	DietDB.disconnect(pstmt);
	DietDB.disconnect(conn);

	response.sendRedirect("Main.jsp");
	%>