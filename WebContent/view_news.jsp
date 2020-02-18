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

<title>ART Defense</title>
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<%
	String search = null;
	if (request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	String category = null;
	String cat_db = null;
	String cat_kor = null;
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	if(category.equals("notice")){
		cat_db = "notice_title";
		cat_kor = "공지사항";
		%><link rel="stylesheet" type="text/css" href="view_notice.css"><%
	}
	else if(category.equals("update")){
		cat_db = "update_title";
		cat_kor = "업데이트";
		%><link rel="stylesheet" type="text/css" href="view_update.css"><%
	}
	else{
		cat_db = "event_title";
		cat_kor = "이벤트";
		%><link rel="stylesheet" type="text/css" href="view_event.css"><%
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
				<li><a href="news.jsp?category=notice">새소식</a>
					<ul class="subMenu">
						<li><a href="news.jsp?category=notice">공지사항</a></li>
						<li><a href="news.jsp?category=update">업데이트</a></li>
						<li><a href="news.jsp?category=event">이벤트</a></li>
					</ul></li>
				<li><a href="guide_game.jsp?category=game">가이드</a>
					<ul class="subMenu">
						<li><a href="guide_game.jsp?category=game">게임설명</a></li>
						<li><a href="guide_tower.jsp?category=tower">타워정보</a></li>
						<li><a href="guide_monster.jsp?category=monster">몬스터정보</a></li>
					</ul></li>
				<li><a href="rank.jsp?category=rank">랭킹</a></li>
				<li><a href="board.jsp?category=free">커뮤니티</a>
					<ul class="subMenu">
						<li><a href="board.jsp?category=free">자유게시판</a></li>
						<li><a href="board.jsp?category=info">정보게시판</a></li>
						<li><a href="board.jsp?category=discuss">토론게시판</a></li>
					</ul></li>
				<li><a href="customer.jsp?category=1vs1">고객지원</a>
					<ul class="subMenu">
						<li><a href="customer.jsp?category=1vs1">도움말/1:1문의</a></li>
						<li><a href="customer.jsp?category=bug">버그 신고</a></li>
					</ul></li>
				<li><a href="data.jsp?category=data">자료실</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title"><%=cat_kor %></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250"/>
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
				<%
				if(search==null){
				%>
				<td id="list"><button id="list" onclick="window.location='news.jsp?category=<%=category%>&pg=<%=pg%>'">목록</button></td>
				<%
				} else{
				%>
				<td id="list"><button id="list" onclick="window.location='news.jsp?category=<%=category%>&pg=<%=pg%>&search=<%=search%>'">목록</button></td>
				<%
				}
				%>
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
	String id = (String) session.getAttribute("sessionID");
	String name = (String) session.getAttribute("sessionName");
	if (id == null) {
		%>
		<button id="login" onclick="window.location='login_form.jsp?category=<%=category%>'">로그인</button>
		<%
					} else {
				%>
				<button id="login1"><%=name%>님
				</button>
				<%
					}
				%>
		<div class="nav">
		
				
				
				<div class="section01">새소식</div>
				<ul>
					<li><a href="news.jsp?category=notice">공지사항</a></li>
					<li><a href="news.jsp?category=update">업데이트</a></li>
					<li><a href="news.jsp?category=event">이벤트</a></li>
				</ul>
			</div>
		</div>
		<div class="footer">
			<br>
			<ul class="footer">
				<li><a href="#">저작권정책｜</a></li>
				<li><a href="#">이용안내｜</a></li>
				<li><a href="#">게임이용등급안내｜</a></li>
				<li><a href="#">개인정보처리방침｜</a></li>
				<li><a href="#">청소년보호정책｜</a></li>
				<li><a href="#">회원서비스약관｜</a></li>
				<li><a href="#">홈페이지 오류신고</a></li>
			</ul>
			<br />

			<ul class="footer">
				<li>강원도 춘천시 교동 삭주로80번지-16 원철민준/ TEL: 010-2944-4455/ FAX:
					010-8243-6780</li>
				<br>
				<li>Copyright(c) ART Defense All. rights Reserved.</li>
			</ul>
			<br>
		</div>
	</div>
</body>
</html>