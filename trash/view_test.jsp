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
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pg = Integer.parseInt(request.getParameter("pg"));

		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			stmt = con.createStatement();
			ResultSet result = stmt
					.executeQuery("select id, title, memo, time, hit from free where no=" + idx + ";");
			if (result.next()) {
				String name = result.getString(1);
				String title = result.getString(2);
				String memo = result.getString(3);
				String time = result.getString(4);
				int hit = result.getInt(5);
				hit++;
	%>

	<table>
		<tr>
			<td>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr
						style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
						<td width="5"><img src="img/table_left.gif" width="5"
							height="30" /></td>
						<td>내 용</td>
						<td width="5"><img src="img/table_right.gif" width="5"
							height="30" /></td>
					</tr>
				</table>
				<table width="413">
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">글번호</td>
						<td width="319"><%=idx%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">조회수</td>
						<td width="319"><%=hit%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">이름</td>
						<td width="319"><%=name%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">작성일</td>
						<td width="319"><%=time%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">제목</td>
						<td width="319"><%=title%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td width="399" colspan="2" height="200"><%=memo %>
					</tr>

					<%
						stmt.executeUpdate("UPDATE free SET hit=" + hit + " where no=" + idx + ";");
								result.close();
								stmt.close();
								con.close();
							}
						} catch (SQLException e) {
						}
					%>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="4" width="407"></td>
					</tr>
					<tr align="center">
						<td width="0">&nbsp;</td>
						<td colspan="2" width="399">
						<input type=button value="글쓰기" OnClick="window.location='write.jsp'"> 
						<input type=button value="답글" OnClick="window.location='reply.jsp?idx=<%=idx%>&pg=<%=pg%>'"> 
						<input type=button value="목록" OnClick="window.location='free.jsp?&pg=<%=pg%>'"> 
						<input type=button value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>&pg=<%=pg%>'"> 
						<input type=button value="삭제" OnClick="window.location='delete.jsp?idx=<%=idx%>&pg=<%=pg%>'">
						<td width="0">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

</body>
</html>