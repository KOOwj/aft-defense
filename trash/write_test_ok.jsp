<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
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
		Statement stmt_c = null;
		//String driverName = "org.gjt.mm.mysql.Driver";
		String driverName = "com.mysql.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost/project";
		int cnt = 0;
		
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String memo = request.getParameter("memo");
		int max = 0;
		
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			stmt = con.createStatement();
			stmt_c = con.createStatement();
			ResultSet result = stmt.executeQuery("select min(no+1) from free where (no+1) not in (select no from free);");
			ResultSet result_c = stmt_c.executeQuery("select max(no) from free;");
			if(result.next()){
				cnt = result.getInt(1);
			}
			result.close();
			if(result_c.next()){
				max = result_c.getInt(1);
			}
			result_c.close();
			
			PreparedStatement pstmt = con.prepareStatement("insert into free(no, id, passwd, title, memo,ref) values(?,?,?,?,?,?);");
			pstmt.setInt(1, cnt);
			pstmt.setString(2, name);
			pstmt.setString(3, password);
			pstmt.setString(4, title);
			pstmt.setString(5, memo);
			pstmt.setInt(6, max+1);
			
			pstmt.execute();
			pstmt.close();
			stmt.close();
			con.close();
		} catch(SQLException e){
			out.println(e.toString());
		}
	%>
	<script language=javascript>
	self.window.alert("등록되었습니다.");
	location.href="free.jsp";
	</script>
</body>
</html>