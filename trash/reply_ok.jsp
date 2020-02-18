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
	String driverName = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost/project";
	
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	try{
		int ref=0;
		int indent = 0;
		int step = 0;
		
		Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery("select ref, indent, step from free where no = " + idx + ";");
		
		if(result.next()){
			ref = result.getInt(1);
			indent = result.getInt(2);
			step = result.getInt(3);
		}
		stmt.executeUpdate("update free set step=step+1 where ref = " + ref + " and step > " + step + ";");
		
		PreparedStatement pstmt = con.prepareStatement("insert into free(id, passwd, title, memo, ref, indent, step)" +  "values(?,?,?,?,?,?,?);");
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, title);
		pstmt.setString(4, memo);
		pstmt.setInt(5, ref);
		pstmt.setInt(6, indent+1);
		pstmt.setInt(7, step+1);
		
		pstmt.execute();
		result.close();
		stmt.close();
		pstmt.close();
		con.close();
	} catch(SQLException e){
		out.println(e.toString());
	}
%>

<script language=javascript>
	self.window.alert("저장되었습니다.");
	location.href="free.jsp";
</script>

</body>
</html>