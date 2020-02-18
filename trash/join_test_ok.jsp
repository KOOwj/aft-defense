<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("euc-kr");
	Connection con = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	String driverName = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost/project";
	int cnt = 0;
	String sex = null;
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String[] gender = request.getParameterValues("gender");
	for(String g : gender){
		sex = g;
	}
	String birthday = request.getParameter("birthday");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	
	try{
		Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select count(*) from member;");
		if(result.next()){
			cnt = result.getInt(1);
		}
		result.close();
		pstmt = con.prepareStatement("insert into member(no, id, passwd, name, gender, birthday, email, phone) values(?,?,?,?,?,?,?,?);");
		pstmt.setInt(1, cnt+1);
		pstmt.setString(2, id);
		pstmt.setString(3, password);
		pstmt.setString(4, name);
		pstmt.setString(5, sex);
		pstmt.setString(6, birthday);
		pstmt.setString(7, email);
		pstmt.setString(8, phone);
		
		pstmt.execute();
		pstmt.close();
		stmt.close();
		con.close();
	} catch(SQLException e){
		out.println(e.toString());
	}
	%>
	<script language=javascript>
	self.window.alert("가입되셨습니다.");
	location.href="join_test.jsp";
	</script>

</body>
</html>