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

<script language="javascript">
	function searchCheck(){
		var form = document.seachform;
		if(!form.search.value){
			alert("�˻�� �Է����ּ���.");
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
		String cat_kor = null;
		String cat_db = null;

		if (request.getParameter("category") != null){
			category = request.getParameter("category");
		}
		if (category.equals("notice")){
			cat_kor = "��������";
			cat_db = "notice_title";
			%><link rel="stylesheet" type="text/css" href="news_notice.css"><%
		}
		else if (category.equals("update")){
			cat_kor = "������Ʈ";
			cat_db = "update_title";
			%><link rel="stylesheet" type="text/css" href="news_update.css"><%
		}
		else{
			cat_kor = "�̺�Ʈ";
			cat_db = "event_title";
			%><link rel="stylesheet" type="text/css" href="news_event.css"><%
		}
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
				result = stmt.executeQuery("select count(*) from " + cat_db + ";");
			} else {
				result = stmt
						.executeQuery("select count(*) from " + cat_db + " where title like '%" + search + "%';");
			}
			while (result.next()) {
				total = Integer.parseInt(result.getString(1));
			}
			result.close();
			int sort = 1;
			if (search == null) {
				result = stmt.executeQuery("select no from " + cat_db + " order by no desc;");

			} else {
				result = stmt.executeQuery(
						"select no from " + cat_db + " where title like '%" + search + "%' order by no desc;");
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
				result = stmt.executeQuery("select title, date, no from " + cat_db + " where step2 >=" + start
						+ " and step2 <=" + end + " order by step2 asc;");
			} else {
				result = stmt.executeQuery("select title, date, no from " + cat_db + " where title like '%" + search
						+ "%' and (step2 >=" + start + " and step2 <=" + end + ") order by step2 asc;");
			}
	%>
	<div class="all">
		<div class="header">
			<ul class="topMenu">
				<li><a href="main.jsp">ART Defense</a></li>
				<li><a href="news.jsp?category=notice">���ҽ�</a>
					<ul class="subMenu">
						<li><a href="news.jsp?category=notice">��������</a></li>
						<li><a href="news.jsp?category=update">������Ʈ</a></li>
						<li><a href="news.jsp?category=event">�̺�Ʈ</a></li>
					</ul></li>
				<li><a href="guide_game.jsp?category=game">���̵�</a>
					<ul class="subMenu">
						<li><a href="guide_game.jsp?category=game">���Ӽ���</a></li>
						<li><a href="guide_tower.jsp?category=tower">Ÿ������</a></li>
						<li><a href="guide_monster.jsp?category=monster">��������</a></li>
					</ul></li>
				<li><a href="rank.jsp?category=rank">��ŷ</a></li>
				<li><a href="board.jsp?category=free">Ŀ�´�Ƽ</a>
					<ul class="subMenu">
						<li><a href="board.jsp?category=free">�����Խ���</a></li>
						<li><a href="board.jsp?category=info">�����Խ���</a></li>
						<li><a href="board.jsp?category=discuss">��аԽ���</a></li>
					</ul></li>
				<li><a href="customer.jsp?category=1vs1">������</a>
					<ul class="subMenu">
						<li><a href="customer.jsp?category=1vs1">����/1:1����</a></li>
						<li><a href="customer.jsp?category=bug">���� �Ű�</a></li>
					</ul></li>
				<li><a href="data.jsp?category=data">�ڷ��</a></li>
			</ul>
		</div>
		<div class="titleline">
			<div class="title"><%=cat_kor %></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250">
			</button>
		</div>

		<div class="searchloginline">
			<div class="searchline">
				<div class="search">
					<div>���� �˻�</div>
					<form style="display: inline" name="seachform" method="post" action="news.jsp?category=<%= category%>">
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
				<button id="login" onclick="window.location='login_form.jsp?category=<%= category%>'">�α���</button>
				<%
					} else {
				%>
				<button id="login1"><%=name%>��
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
						<td id="title">
						<%
						if (search == null){
						%>
						<a href="view_news.jsp?category=<%=category%>&pg=<%=pg %>&idx=<%=idx%>">
						<%
						} else{
							%>
						<a href="view_news.jsp?category=<%=category%>&pg=<%=pg %>&idx=<%=idx%>&search=<%=search%>">
							<%
						}
						%>
						<%=result.getString(1)%></a> <%
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
					%> <a href="news.jsp?category=<%=category %>&pg=1">����</a> <a
					href="news.jsp?category=<%=category %>&pg=<%=startPage - 1%>">��</a> <%
 	} else {
 %> <a href="news.jsp?category=<%=category %>&pg=1&search=<%=search%>">����</a> <a
					href="news.jsp?category=<%=category %>&pg=<%=startPage - 1%>&search=<%=search%>">��</a> <%
 	}
 	}
 	for (int i = startPage; i <= endPage; i++) {
 		if (i == pg) {
 %> <b><%=i%></b> <%
 	} else {
 			if (search == null) {
 %> <a href="news.jsp?category=<%=category %>&pg=<%=i%>"><%=i%></a> <%
 	} else {
 %> <a href="news.jsp?category=<%=category %>&pg=<%=i%>&search=<%=search%>"><%=i%></a> <%
 	}
 		}
 	}
 %> <%
 	if (endPage < allPage) {
 		if (search == null) {
 %> <a href="news.jsp?category=<%=category %>&pg=<%=endPage + 1%>">��</a> <a
					href="news.jsp?category=<%=category %>&pg=<%=allPage%>">����</a> <%
 	} else {
 %> <a href="news.jsp?category=<%=category %>&pg=<%=endPage + 1%>&search=<%=search%>">��</a> <a
					href="news.jsp?category=<%=category %>&pg=<%=allPage%>&search=<%=search%>">����</a> <%
 	}
 	}
 %>
				</td>
				</tr>
				</table>
			</div>

			<div class="nav">
				<div class="section01">���ҽ�</div>
				<ul>
					<li><a href="news.jsp?category=notice">��������</a></li>
					<li><a href="news.jsp?category=update">������Ʈ</a></li>
					<li><a href="news.jsp?category=event">�̺�Ʈ</a></li>
				</ul>
			</div>
		</div>
		<div class="footer">
			<br>
			<ul class="footer">
				<li><a href="#">���۱���å��</a></li>
				<li><a href="#">�̿�ȳ���</a></li>
				<li><a href="#">�����̿��޾ȳ���</a></li>
				<li><a href="#">��������ó����ħ��</a></li>
				<li><a href="#">û�ҳ⺸ȣ��å��</a></li>
				<li><a href="#">ȸ�����񽺾����</a></li>
				<li><a href="#">Ȩ������ �����Ű�</a></li>
			</ul>
			<br />

			<ul class="footer">
				<li>������ ��õ�� ���� ���ַ�80����-16 ��ö����/ TEL: 010-2944-4455/ FAX:
					010-8243-6780</li>
				<br>
				<li>Copyright(c) ART Defense All. rights Reserved.</li>
			</ul>
			<br>
		</div>
	</div>
</body>
</html>