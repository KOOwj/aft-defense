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
		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		if (category.equals("free")) {
			cat_kor = "�����Խ���";
			cat_db = "free_board";
	%><link rel="stylesheet" type="text/css" href="board_free.css">
	<%
		} else if (category.equals("info")) {
			cat_kor = "�����Խ���";
			cat_db = "info_board";
	%><link rel="stylesheet" type="text/css" href="board_info.css">
	<%
		} else {
			cat_kor = "��аԽ���";
			cat_db = "discuss_board";
	%><link rel="stylesheet" type="text/css" href="board_discuss.css">
	<%
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
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
		String today = (String) simpleDate.format(now);

		//Connection con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet result = null;
		//String driverName = "org.gjt.mm.mysql.Driver";
		//String driverName = "com.mysql.jdbc.Driver";
		//String dbURL = "jdbc:mysql://localhost/project";

		try {

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
				result = stmt.executeQuery("select no from " + cat_db + " order by ref desc, step asc;");
			} else {
				result = stmt.executeQuery(
						"select no from " + cat_db + " where title like '%" + search + "%' order by ref desc, step asc;");
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
				result = stmt.executeQuery("select no, id, title, date, indent, image_path from " + cat_db + " where step2 >=" + start
						+ " and step2 <=" + end + " order by step2 asc;");
			} else {
				result = stmt.executeQuery("select no, id, title, date, indent, image_path from " + cat_db + " where title like '%"
						+ search + "%' and (step2 >=" + start + " and step2 <=" + end + ") order by step2 asc;");
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
			<div class="title"><%=cat_kor%></div>
			<button onclick="window.location='start.jsp?run=exe'">
				<image src="real_start.png" width="250" height="250">
			</button>
		</div>

		<div class="searchloginline">
			<div class="searchline">
				<div class="search">
					<div>���� �˻�</div>
					<form style="display: inline" name="searchform" method="post"
						action="board.jsp?category=<%=category%>">
						<input class="search" type="search" name="search"">
						<button class="search" type="submit">
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
					onclick="window.location='login_form.jsp?category=<%=category%>'">�α���</button>
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
				<%
					if (total == 0) {
				%>
				<table class="zero">
					<tr>
						<th>��ϵ� �Խù��� �����ϴ�.</th>
					</tr>
				</table>
				<%
					}
				%>


				<table>
					<%
						while (result.next()) {
								int idx = result.getInt(1);
								String time = result.getString(4);
								time = time.substring(0, 19);
								int indent = result.getInt(5);
								String fullpath = result.getString(6);
								
					%>
					<tr>
						<td id="title">
						<%
						for(int j = 0; j< indent; j++){
						%>&nbsp;&nbsp;&nbsp;
						<%
						}
						if(indent != 0){
						%>
						<image src="reply.gif"/>
						<%
						}
						%>
						
						<%
						if (search == null){
						%>
						<a href="view_board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>">
						<%
						} else{
						%>
						<a href="view_board.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>&search=<%=search%>">
						<%
						}
						%>
						<%=result.getString(3)%></a> <%
						if (fullpath != null){ %>
						<img src="img.png">
						<%}
 	if (time.substring(0, 10).equals(today.substring(0, 10))) {
 %> <img src="new.jpeg"> <%
 	}
 %></td>
						<td id="person"><image src="person.png"> <%=result.getString(2)%></td>
						<td id="date"><image src="clock.png"> <%=time%></td>

					</tr>
					<%
						}
							result.close();
							stmt.close();
							con.close();
						} catch (SQLException e) {
							out.println(e.toString());
						}
					%><tr id="write">
						<td id="list" colspan="2">
							<%
								if (pg > BLOCK) {
									if (search == null) {
							%> <a href="board.jsp?category=<%=category%>&pg=1">����</a> <a
							href="board.jsp?category=<%=category%>&pg=<%=startPage - 1%>">��</a>
							<%
								} else {
							%> <a href="board.jsp?category=<%=category%>&pg=1&search=<%=search%>">����</a>
							<a
							href="board.jsp?category=<%=category%>&pg=<%=startPage - 1%>&search=<%=search%>">��</a>
							<%
								}
								}
								for (int i = startPage; i <= endPage; i++) {
									if (i == pg) {
							%> <b><%=i%></b> <%
 	} else {
 			if (search == null) {
 %> <a href="board.jsp?category=<%=category%>&pg=<%=i%>"><%=i%></a> <%
 	} else {
 %> <a
							href="board.jsp?category=<%=category%>&pg=<%=i%>&search=<%=search%>"><%=i%></a>
							<%
								}
									}
								}
							%> <%
 	if (endPage < allPage) {
 		if (search == null) {
 %> <a href="board.jsp?category=<%=category%>&pg=<%=endPage + 1%>">��</a>
							<a href="update.jsp?pg=<%=allPage%>">����</a> <%
 	} else {
 %> <a
							href="board.jsp?category=<%=category%>&pg=<%=endPage + 1%>&search=<%=search%>">��</a>
							<a
							href="board.jsp?category=<%=category%>&pg=<%=allPage%>&search=<%=search%>">����</a>
							<%
								}
								}
							%>
						</td>
						<%
							if (total == 0) {
						%>
						<td id="write1"><button
								onclick="window.location='write_form.jsp?category=<%=category%>'">�۾���</button></td>
						<%
							} else {
						%>
						<td id="write"><button
								onclick="window.location='write_form.jsp?category=<%=category%>'">�۾���</button></td>
						<%
							}
						%>
					</tr>
				</table>

			</div>

			<div class="nav">
				<div class="section01">Ŀ�´�Ƽ</div>
				<ul>
					<li><a href="board.jsp?category=free">�����Խ���</a></li>
					<li><a href="board.jsp?category=info">�����Խ���</a></li>
					<li><a href="board.jsp?category=discuss">��аԽ���</a></li>
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