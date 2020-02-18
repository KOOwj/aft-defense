<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		final int ROWSIZE = 10;
		final int BLOCK = 5;
			
		int pg = 1;
		
		if(request.getParameter("pg")!=null){
			pg = Integer.parseInt(request.getParameter("pg"));
		}
		
		int start = (pg * ROWSIZE ) - (ROWSIZE - 1);
		int end = (pg*ROWSIZE);
		
		int allPage = 0;
		
		int startPage = ((pg-1)/BLOCK*BLOCK) + 1;
		int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	%>


	<%
		request.setCharacterEncoding("euc-kr");
		Connection con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		//String driverName = "org.gjt.mm.mysql.Driver";
		String driverName = "com.mysql.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost/project";
		int total = 0;

		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			stmt = con.createStatement();
			stmt2 = con.createStatement();
			ResultSet result = stmt.executeQuery("select count(*) from free");
			if(result.next()){
				total = result.getInt(1);
			}
			
			int sort = 1;
			result = stmt.executeQuery("select no from free order by ref desc, step asc;");

			while(result.next()){
				int stepNum = result.getInt(1);
				stmt2.executeUpdate("update free set step2 = " + sort + " where no=" + stepNum +  ";" );
				sort++;
			}
			result.close();
			stmt2.close();
			
			allPage = (int)Math.ceil(total/(double)ROWSIZE);
			if(endPage > allPage){
				endPage = allPage;
			}
			out.print("총 게시물 : " + total + "개");
			
			result = stmt.executeQuery("select no, id, title, time, hit, indent from free where step2 >=" + start + " and step2 <=" + end + " order by step2 asc;");
	%>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="5">
			<td width="5"></td>
		</tr>
		<tr style="text-align: center;">
			<td width="5"></td>
			<td width="73">번호</td>
			<td width="379">제목</td>
			<td width="73">작성자</td>
			<td width="164">작성일</td>
			<td width="58">조회수</td>
			<td width="7"></td>
		</tr>

		<%
			if (total == 0) {
		%>
		<tr align="center" bgcolor="#ffffff" height="30">
			<td colspan="6">등록된 글이 없습니다.</td>
		</tr>
		<%
			} else {
					while (result.next()) {
						int idx = result.getInt(1);
						String name = result.getString(2);
						String title = result.getString(3);
						String time = result.getString(4);
						int hit = result.getInt(5);
						int indent = result.getInt(6);
						
						Date date = new Date();
						SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
						String year = (String)simpleDate.format(date);
						String yea = time.substring(0,10);
		%>

		<tr height="25" align="center">
			<td>&nbsp;</td>
			<td><%=idx%></td>
			<td align="left">
				<%
					for(int j=0;j<indent;j++){
				%>&nbsp;&nbsp;&nbsp;<%
					}
				if(indent!=0){
					 %>	<img src="reple.gif">
					 <%
				}
				 %>
			<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=title%></a>
			<% if(year.equals(yea)) { 
				%>
				<img src="new.jpeg"> 
				<%
			}
			 %>
			 </td>
			<td align="center"><%=name%></td>
			<td align="center"><%=yea%></td>
			<td align="center"><%=hit%></td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>

		<%
			}
				}
				result.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
		<tr height="1" bgcolor="#82B5DF">
			<td colspan="6" width="752"></td>
		</tr>
	</table>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		 <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			[<a href="free.jsp?pg=1">◀◀</a>]
			[<a href="free.jsp?pg=<%=startPage-1%>">◀</a>]
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<= endPage; i++){
				if(i==pg){
		%>
					<u><b>[<%=i %>]</b></u>
		<%
				}else{
		%>
					[<a href="free.jsp?pg=<%=i %>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			[<a href="free.jsp?pg=<%=endPage+1%>">▶</a>]
			[<a href="free.jsp?pg=<%=allPage%>">▶▶</a>]
		<%
			}
		%>
		</td>
		</tr>
		<tr align="center">
			<td><input type=button value="글쓰기" OnClick="window.location='write.jsp'"></td>
		</tr>

	</table>
</body>
</html>