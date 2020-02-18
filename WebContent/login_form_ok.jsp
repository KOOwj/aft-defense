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

<jsp:useBean id="login" class="project.login_bean"/>
<jsp:useBean id="db" class="project.DBcon_bean"/>

<jsp:setProperty name="login" property="id"/>
<jsp:setProperty name="login" property="password"/>

<%
	String go = null;
	String category = null;
	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	if (category.equals("notice")){
		go = "news.jsp?category=notice";
	}
	else if (category.equals("update")){
		go = "news.jsp?category=update";
	}
	else if (category.equals("event")){
		go = "news.jsp?category=event";
	}
	else if (category.equals("free")){
		go = "news.jsp?category=free";
	}
	else if (category.equals("info")){
		go = "news.jsp?category=info";
	}
	else if (category.equals("discuss")){
		go = "news.jsp?category=discuss";
	}
	else{
		go = "main.jsp";
	}
	String id = login.getId();
	String password = login.getPassword();
	String pass = null;
	String name = null;
	boolean isid = false;

	request.setCharacterEncoding("euc-kr");
	//Connection con = null;
	Statement stmt = null;
	//String driverName = "com.mysql.jdbc.Driver";
	//String dbURL = "jdbc:mysql://localhost/project";

	try {
		//Class.forName(driverName);
		//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select passwd, name from member where id = '" + id + "';");

		if (result.next()) {
			pass = result.getString(1);
			name = result.getString(2);
			isid = true;
		} else {
			isid = false;
		}
		result.close();
		stmt.close();
		con.close();

		if (isid) {
			if (password.equals(pass)) {
				session.setAttribute("sessionID", id);
				session.setAttribute("sessionName", name);
				session.setAttribute("sessionPass", pass);
				%>
				
				<script language="javascript">
				self.window.alert("로그인 성공");
				location.href = "main.jsp";
				</script>
					
				
<%
	} else {
%>
<script language="javascript">
	self.window.alert("비밀번호를 틀렸습니다.");
	location.href = "login_form.jsp";
</script>
<%
	}
		} else {
%>
<script language="javascript">
	self.window.alert("아이디를 틀렸습니다.");
	location.href = "login_form.jsp";
</script>
<%
	}
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>

<body>

</body>
</html>