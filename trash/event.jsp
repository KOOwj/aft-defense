<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="event.css">
<title>Insert title here</title>

<script language="javascript">
	function searchCheck(){
		var form = document.seachform;
		if(!form.search.value){
			alert("검색어를 입력해주세요.");
			form.search.focus();
			return
		}

		form.submit();
	}
</script>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<body>

	<%
		String category = "event";
		String search = null;
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		final int ROWSIZE = 10;
		final int BLOCK = 5;

		int pg = 1;

		if (request.getParameter("pg") != null) {
			pg = Integer.parseInt(request.getParameter("pg"));
		}
		int start = (pg * ROWSIZE) - (ROWSIZE - 1);
		int end = (pg * ROWSIZE);

		int allPage = 0;

		int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;
		int total = 0;
		Date now = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String today = (String) simpleDate.format(now);

		//Connection con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet result = null;
		//String driverName = "org.gjt.mm.mysql.Driver";
		//String driverName = "com.mysql.jdbc.Driver";
		//String dbURL = "jdbc:mysql://localhost/project";

		try {
			request.setCharacterEncoding("euc-kr");
			//Class.forName(driverName);
			//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
			Connection con = db.getConnection();
			stmt = con.createStatement();
			stmt2 = con.createStatement();
			if (search == null) {
				result = stmt.executeQuery("select count(*) from event_title;");
			} else {
				result = stmt.executeQuery("select count(*) from event_title where title like '%" + search + "%';");
			}
			while (result.next()) {
				total = Integer.parseInt(result.getString(1));
			}
			result.close();
			int sort = 1;
			if (search == null) {
				result = stmt.executeQuery("select no from event_title order by no desc;");

			} else {
				result = stmt.executeQuery(
						"select no from event_title where title like '%" + search + "%' order by no desc;");
			}
			stmt2.executeUpdate("update event_title set step2 = 0;");
			while (result.next()) {
				int stepNum = result.getInt(1);
				stmt2.executeUpdate("update event_title set step2 = " + sort + " where no = " + stepNum + ";");
				sort++;
			}
			result.close();
			stmt2.close();

			allPage = (int) Math.ceil(total / (double) ROWSIZE);
			if (endPage > allPage) {
				endPage = allPage;
			}
			if (search == null) {
				result = stmt.executeQuery("select title, date, no from event_title where step2 >=" + start
						+ " and step2 <=" + end + " order by step2 asc;");
			} else {
				result = stmt.executeQuery("select title, date, no from event_title where title like '%" + search
						+ "%' and (step2 >=" + start + " and step2 <=" + end + ") order by step2 asc;");
			}
	%>
	<div class="all">
		<div class="header">
			<ul class="topMenu">
				<li><a href="main.jsp">ART Defense</a></li>
				<li><a href="news.jsp">새소식</a>
					<ul class="subMenu">
						<li><a href="news.jsp">공지사항</a></li>
						<li><a href="update.jsp">업데이트</a></li>
						<li><a href="event.jsp">이벤트</a></li>
					</ul></li>
				<li><a href="#">가이드</a>
					<ul class="subMenu">
						<li><a href="#">게임설명</a></li>
						<li><a href="#">타워정보</a></li>
						<li><a href="#">몬스터정보</a></li>
					</ul></li>
				<li><a href="#">랭킹</a></li>
				<li><a href="free_board.jsp">커뮤니티</a>
					<ul class="subMenu">
						<li><a href="free_board.jsp">자유게시판</a></li>
						<li><a href="#">정보게시판</a></li>
						<li><a href="#">토론게시판</a></li>
					</ul></li>
				<li><a href="#">고객지원</a>
					<ul class="subMenu">
						<li><a href="#">도움말/1:1문의</a></li>
						<li><a href="#">버그 신고</a></li>
					</ul></li>
				<li><a href="#">자료실</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title">이벤트</div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="#" width="250" height="250">
			</button>
		</div>

		<div class="searchloginline">
			<div class="searchline">
				<div class="search">
					<div>제목 검색</div>
					<form style="display: inline" name="seachform" method="get"
						action="event.jsp?search=<%=search%>">
						<input class="search" type="search" name="search">
						<button class="search" type="submit"
							onclick="javascript:searchCheck()">
							<img src="search_btn.png">
						</button>
					</form>
				</div>
			</div>
			<div class="loginline">
				<%
					String id = (String) session.getAttribute("sessionID");
						String name = (String) session.getAttribute("sessionName");
						if (id == null) {
				%>
				<button id="login" onclick="window.location='login_form.jsp'">로그인</button>
				<%
					} else {
				%>
				<button id="login1"><%=name%>님
				</button>
				<%
					}
				%>
			</div>
		</div>

		<div class="noticeline">
			<div class="notice">
				<table>
					<%
						while (result.next()) {
								int idx = result.getInt(3);
					%>
					<tr>
						<td id="title"><a
							href="view.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>"><%=result.getString(1)%></a>
							<%
								if (result.getString(2).equals(today)) {
							%> <img src="new.jpeg"> <%
 	}
 %></td>
						<td id="date"><image src="clock.png"> <%=result.getString(2)%></td>
					</tr>
					<%
						}
							result.close();
							stmt.close();
							con.close();
						} catch (SQLException e) {
							out.println(e.toString());
						}
					%>
					<tr id="list">
						<td colspan="2" id="list">
							<%
								if (pg > BLOCK) {
									if (search == null) {
							%> <a href="event.jsp?pg=1">◀◀</a> <a
							href="event.jsp?pg=<%=startPage - 1%>">◀</a> <%
 	} else {
 %> <a href="event.jsp?pg=1&search=<%=search%>">◀◀</a> <a
							href="event.jsp?pg=<%=startPage - 1%>&search=<%=search%>">◀</a> <%
 	}
 	}
 	for (int i = startPage; i <= endPage; i++) {
 		if (i == pg) {
 %> <b><%=i%></b> <%
 	} else {
 			if (search == null) {
 %> <a href="event.jsp?pg=<%=i%>"><%=i%></a> <%
 	} else {
 %> <a href="event.jsp?pg=<%=i%>&search=<%=search%>"><%=i%></a> <%
 	}
 		}
 	}
 %> <%
 	if (endPage < allPage) {
 		if (search == null) {
 %> <a href="event.jsp?pg=<%=endPage + 1%>">▶</a> <a
							href="news.jsp?pg=<%=allPage%>">▶▶</a> <%
 	} else {
 %> <a href="event.jsp?pg=<%=endPage + 1%>&search=<%=search%>">▶</a> <a
							href="event.jsp?pg=<%=allPage%>&search=<%=search%>">▶▶</a> <%
 	}
 	}
 %>
						</td>
					</tr>
				</table>
			</div>

			<div class="nav">
				<div class="section01">새소식</div>
				<ul>
					<li><a href="news.jsp">공지사항</a></li>
					<li><a href="update.jsp">업데이트</a></li>
					<li><a href="event.jsp">이벤트</a></li>
				</ul>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

</body>
</html>