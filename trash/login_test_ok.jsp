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
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String pass = null;
	String name = null;
	boolean isid =false;
	request.setCharacterEncoding("euc-kr");
	Connection con = null;
	Statement stmt = null;
	String driverName = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost/project";
	
	try{
		Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select passwd name from member where id =" + id + ";");
		
		if(result.next()){
			pass = result.getString(1);
			name = result.getString(2);
			isid = true;
		}
		else{
			isid = false;
		}
		result.close();
		stmt.close();
		con.close();
		
		if(isid){
			if(password.equals(pass)){
				%> 
				<script language="javascript">
				self.window.alert("로그인 성공");
				session.setAttribut("sessionID", id);
				</script>
				<%
			} else{
				%>
				<script language="javascript">
				self.window.alert("비밀번호를 틀렸습니다.");
				location.href="login_test.jsp";
				</script>
				<%
			}
		} else{
			%>
			<script language="javascript">
			self.window.alert("아이디를 틀렸습니다.");
			location.href="login_test.jsp";
			</script>
			<%
		}
		
	} catch(SQLException e){
		out.println(e.toString());
	}
	%>
</body>
</html>