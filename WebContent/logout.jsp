<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ART Defense</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<%
	session.invalidate();
	try{
		Statement stmt = null;
		Connection con = db.getConnection();
		stmt = con.createStatement();
		stmt.executeUpdate("truncate playing;");
		
		stmt.close();
		con.close();
	}catch(SQLException e){
		out.println(e.toString());
	}
%>
<script language="javascript">
self.window.alert("로그아웃 성공");
location.href="main.jsp";
</script>

<body>

</body>
</html>