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
<link rel="stylesheet" type="text/css" href="rank.css">
<title>ART Defense</title>

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
		String category = null;
		String cat_kor = "랭킹";
		String cat_db = "rank";

		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		String search = null;
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		final int ROWSIZE = 5;
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
				result = stmt.executeQuery("select count(*) from " + cat_db + ";");
			} else {
				result = stmt
						.executeQuery("select count(*) from " + cat_db + " where id like '%" + search + "%';");
			}
			while (result.next()) {
				total = Integer.parseInt(result.getString(1));
			}
			result.close();
			int sort = 1;
			if (search == null) {
				result = stmt.executeQuery("select no from " + cat_db + " order by score asc;");

			} else {
				result = stmt.executeQuery(
						"select no from " + cat_db + " where id like '%" + search + "%' order by score asc;");
			}
			stmt2.executeUpdate("update " + cat_db + " set step2 = 0;");
			while (result.next()) {
				int stepNum = result.getInt(1);
				stmt2.executeUpdate("update " + cat_db + " set step2 = " + sort + " where no = " + stepNum + ";");
				sort++;
			}
			result.close();
			stmt2.close();

			allPage = (int) Math.ceil(total / (double) ROWSIZE);
			if (endPage > allPage) {
				endPage = allPage;
			}
			if (search == null) {
				result = stmt.executeQuery("select step2, id, score from " + cat_db + " where step2 >=" + start
						+ " and step2 <=" + end + " order by step2 asc;");
			} else {
				result = stmt.executeQuery("select step2, id, score from " + cat_db + " where id like '%"
						+ search + "%' and (step2 >=" + start + " and step2 <=" + end + ") order by step2 asc;");
			}
	%>
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
			<div class="title"><%=cat_kor%></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250">
			</button>
		</div>

		<div class="searchloginline">
			<div class="searchline">
				<div class="search">
					<div>아이디 검색</div>
					<form style="display: inline" name="seachform" method="post"
						action="rank.jsp?category=<%=category%>">
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
				<button id="login"
					onclick="window.location='login_form.jsp?category=<%=category%>'">로그인</button>
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
				<table style="font-size: 18px;">
				<tr>
					<th>순위</th>
					<th>아이디</th>
					<th id="score">시간초</th>
				</tr>
					<%
						while (result.next()) {
							String tt;
							tt = String.format("%02d:%02d:%02d",result.getInt(3)/3600,(result.getInt(3)%3600)/60,(result.getInt(3)%3600)%60);
					%>
					<tr>
				
						<td id="rank">
							<%=result.getInt(1)%>
						</td>
						<td id="id">
							<%=result.getString(2)%>
						</td>
						<td id="score">
							<%=tt %>
						</td>
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
						<td colspan="3" id="list">
							<%
								if (pg > BLOCK) {
									if (search == null) {
							%> <a href="rank.jsp?category=<%=category%>&pg=1">◀◀</a> <a
							href="rank.jsp?category=<%=category%>&pg=<%=startPage - 1%>">◀</a>
							<%
								} else {
							%> <a href="rank.jsp?category=<%=category%>&pg=1&search=<%=search%>">◀◀</a>
							<a
							href="rank.jsp?category=<%=category%>&pg=<%=startPage - 1%>&search=<%=search%>">◀</a>
							<%
								}
								}
								for (int i = startPage; i <= endPage; i++) {
									if (i == pg) {
							%> <b><%=i%></b> <%
 	} else {
 			if (search == null) {
 %> <a href="rank.jsp?category=<%=category%>&pg=<%=i%>"><%=i%></a> <%
 	} else {
 %> <a
							href="rank.jsp?category=<%=category%>&pg=<%=i%>&search=<%=search%>"><%=i%></a>
							<%
								}
									}
								}
							%> <%
 	if (endPage < allPage) {
 		if (search == null) {
 %> <a href="rank.jsp?category=<%=category%>&pg=<%=endPage + 1%>">▶</a>
							<a href="rank.jsp?category=<%=category%>&pg=<%=allPage%>">▶▶</a>
							<%
								} else {
							%> <a
							href="rank.jsp?category=<%=category%>&pg=<%=endPage + 1%>&search=<%=search%>">▶</a>
							<a
							href="rank.jsp?category=<%=category%>&pg=<%=allPage%>&search=<%=search%>">▶▶</a>
							<%
								}
								}
							%>
						</td>
					</tr>
				</table>
			</div>

			<div class="nav">
				<div class="section01">랭킹</div>
				<ul>
					<li><a href="rank.jsp?category=rank">랭킹</a></li>
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