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

<jsp:useBean id="join" class="project.join_bean"></jsp:useBean>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>

<jsp:setProperty name="join" property="id"></jsp:setProperty>
<jsp:setProperty name="join" property="password"></jsp:setProperty>
<jsp:setProperty name="join" property="name"></jsp:setProperty>
<jsp:setProperty name="join" property="birthday"></jsp:setProperty>
<jsp:setProperty name="join" property="phone"></jsp:setProperty>
<jsp:setProperty name="join" property="email"></jsp:setProperty>



<%
	boolean ischeck = false;
	String id = join.getId();
	String password = join.getPassword();
	String name = join.getName();
	String birthday = join.getBirthday();
	String phone = join.getPhone();
	String email = join.getEmail();

	request.setCharacterEncoding("euc-kr");
	//Connection con = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	//String driverName = "com.mysql.jdbc.Driver";
	//String dbURL = "jdbc:mysql://localhost/project";
	int cnt = 0;

	try {
		//Class.forName(driverName);
		//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select count(*) from member;");
		if (result.next()) {
			cnt = result.getInt(1);
		}
		result.close();
		pstmt = con.prepareStatement(
				"insert into member(no, id, passwd, name, birthday, phone, email) values(?,?,?,?,?,?,?);");
		pstmt.setInt(1, cnt + 1);
		pstmt.setString(2, id);
		pstmt.setString(3, password);
		pstmt.setString(4, name);
		pstmt.setString(5, birthday);
		pstmt.setString(6, phone);
		pstmt.setString(7, email);
	
		pstmt2 = con.prepareStatement("insert into project.rank(no,id) values(?,?);");
		pstmt2.setInt(1, cnt+1);
		pstmt2.setString(2, id);
		
		pstmt2.execute();
		pstmt.execute();
		pstmt2.close();
		pstmt.close();
		stmt.close();
		con.close();
		ischeck = true;
	} catch (SQLException e) {
		ischeck = false;
		out.println(e.toString());
	}
	if (ischeck) {
%>
<script language=javascript>
	self.window.alert("가입되셨습니다.");
	location.href = "main.jsp";
</script>
<%
	} else {
%>
<script language=javascript>
	self.window.alert("아이디가 중복되었습니다.");
	javascript: history.back(-1);
</script>
<%
	}
%>

<body>

</body>
</html>