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
<link rel="stylesheet" type="text/css" href="view_update.css">
<title>Insert title here</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<%
	String category = null;
	String cat_eng = null;
	String cat_db = null;
	String cat_kor = null;
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	if(category.equals("notice")){
		cat_db = "notice_title";
		cat_eng = "news.jsp";
		cat_kor = "공지사항";
	}
	else if(category.equals("update")){
		cat_db = "update_title";
		cat_eng = "update.jsp";
		cat_kor = "업데이트";
	}
	else{
		cat_db = "event_title";
		cat_eng = "event.jsp";
		cat_kor = "이벤트";
	}
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	//Connection con = null;
	Statement stmt = null;
	//String driverName = "com.mysql.jdbc.Driver";
	//String dbURL = "jdbc:mysql://localhost/project";
	
	try {
		//Class.forName(driverName);
		//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt
				.executeQuery("select title, hit, date, contents from " + cat_db + " where no=" + idx + ";");
		if (result.next()) {
			String title = result.getString(1);
			int hit = result.getInt(2);
			String date = result.getString(3);
			String contents = result.getString(4);
			hit++;
	
%>

<body>
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
				<li><a href="#">커뮤니티</a>
					<ul class="subMenu">
						<li><a href="#">자유게시판</a></li>
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
			<div class="title"><%=cat_kor %></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="#" width="250" height="250"/>
			</button>
		</div>
		<div class="noticeline">
		<table class="view">
			<tr>
				<th><%= title %></th>
			</tr>
			<tr>
				<td id="date"><image src="eye.png"> <%=hit %>&nbsp;&nbsp;&nbsp; <image src="clock.png"> <%=date %></td>
			</tr>
			<tr>
				<td id="contents"><%=contents %></td>
			</tr>
			<tr>
				<td id="list"><button id="list" onclick="window.location='<%=cat_eng%>?pg=<%=pg%>'">목록</button></td>
			</tr>
		</table>
		<%
		stmt.executeUpdate("UPDATE " + cat_db + " SET hit=" + hit + " where no=" + idx + ";");
			result.close();
			stmt.close();
			con.close();
		}
	} catch(SQLException e){
		out.print(e.toString());
	}
		%>
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