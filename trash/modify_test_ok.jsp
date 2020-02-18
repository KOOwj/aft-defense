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
		//String driverName = "org.gjt.mm.mysql.Driver";
		String driverName = "com.mysql.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost/project";

		String password = null;
		String passw = request.getParameter("password");
		String title = request.getParameter("title");
		String memo = request.getParameter("memo");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pg = Integer.parseInt(request.getParameter("pg"));

		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("select passwd from free where no=" + idx + ";");

			if (result.next()) {
				password = result.getString(1);
			}

			if (password.equals(passw)) {
				stmt.executeUpdate(
						"update free set title='" + title + "', memo='" + memo + "' WHERE no=" + idx + ";");
	%>
	<script language=javascript>
		self.window.alert("수정되었습니다.");
		location.href="view.jsp?idx=<%=idx%>";
	</script>
	<%
		result.close();
				stmt.close();
				con.close();
			} else {
	%>
	<script language=javascript>
		self.window.alert("비밀번호를 틀렸습니다.");
		location.href = "javascript:history.back()";
	</script>
	<%
		}
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>
</body>
</html>