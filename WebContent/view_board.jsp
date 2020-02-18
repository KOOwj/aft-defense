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
	String id = "";
	String pass = "";
	String name = null;
	String idid = null;
	String passpass = null;
	String fullpath = null;
	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	if (category.equals("free")) {
		cat_db = "free_board";
		cat_kor = "�����Խ���";
%><link rel="stylesheet" type="text/css" href="view_free.css">
<%
	} else if (category.equals("info")) {
		cat_db = "info_board";
		cat_kor = "�����Խ���";
%><link rel="stylesheet" type="text/css" href="view_info.css">
<%
	} else if (category.equals("discuss")) {
		cat_db = "discuss_board";
		cat_kor = "��аԽ���";
%><link rel="stylesheet" type="text/css" href="view_discuss.css">
<%
	} else if (category.equals("1vs1")) {
		cat_db = "customer_1vs1";
		cat_kor = "1:1����";
%><link rel="stylesheet" type="text/css" href="view_free.css">
<%
	} else if (category.equals("bug")) {
		cat_db = "customer_bug";
		cat_kor = "���׽Ű�";
%><link rel="stylesheet" type="text/css" href="view_info.css">
<%
	}
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	id = (String) session.getAttribute("sessionID");
	pass = (String) session.getAttribute("sessionPass");
	name = (String) session.getAttribute("sessionName");
	if (id == null) {
		id = "";
	}
	if (pass == null) {
		pass = "";
	}
	//Connection con = null;
	Statement stmt = null;
	//String driverName = "com.mysql.jdbc.Driver";
	//String dbURL = "jdbc:mysql://localhost/project";

	try {
		//Class.forName(driverName);
		//con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		Connection con = db.getConnection();
		stmt = con.createStatement();
		ResultSet result = stmt.executeQuery(
				"select title, hit, date, contents, id, passwd, image_path from " + cat_db + " where no=" + idx + ";");
		if (result.next()) {
			String title = result.getString(1);
			int hit = result.getInt(2);
			String date = result.getString(3);
			date = date.substring(0, 19);
			String contents = result.getString(4);
			hit++;
			idid = result.getString(5);
			passpass = result.getString(6);
			fullpath = result.getString(7);
%>

<body>
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
				<image src="real_start.png" width="250" height="250" />
			</button>
		</div>
		<div class="noticeline">
			<table class="view">
				<tr>
					<th><%=title%></th>
				</tr>
				<tr>
					<td id="date"><image src="person.png"> <%=idid%>&nbsp;&nbsp;&nbsp;
						<image src="eye.png"> <%=hit%>&nbsp;&nbsp;&nbsp; <image
							src="clock.png"> <%=date%></td>
				</tr>
				<tr>
				<%if(fullpath != null){ 
				//out.println(fullpath);
				%>
					<td id="contents"><img src="<%=fullpath %>" width=512 height=384></img><br><%=contents%></td>
					<%} else{ %>
					<td id="contents"><br><%=contents%></td>
					<%} %>
				</tr>
				<tr>
					<td id="list">
						<%
							if (id.equals(idid) && pass.equals(passpass)) {
						%>
						<button id="list" onclick="javascript:deleteCheck();">����</button>
						<%
							if (search == null) {
						%>
						<button id="list"
							onclick="window.location='modify_form.jsp?category=<%=category%>&idx=<%=idx%>&pg=<%=pg%>'">����</button>
						<%
							} else {
						%>
						<button id="list"
							onclick="window.location='modify_form.jsp?category=<%=category%>&idx=<%=idx%>&pg=<%=pg%>&search=<%=search%>'">����</button>
						<%
							}
									}
						%> <%
 	if (name != null) {
 				if (search == null) {
 %>
						<button id="list"
							onclick="window.location='reply_form.jsp?category=<%=category%>&idx=<%=idx%>&pg=<%=pg%>'">���</button>
						<%
							} else {
						%>
						<button id="list"
							onclick="window.location='reply_form.jsp?category=<%=category%>&idx=<%=idx%>&pg=<%=pg%>&search=<%=search%>'">���</button>
						<%
							}
									}
						%> <%
 	if (search == null) {
 		if (category.equals("free") || category.equals("info") || category.equals("discuss")) {%>
						<button id="list"
							onclick="window.location='board.jsp?category=<%=category%>&pg=<%=pg%>'">���</button>
							<%} else{ %>
							<button id="list"
							onclick="window.location='customer.jsp?category=<%=category%>&pg=<%=pg%>'">���</button>
							<%} %>
					</td>

					<%
						} else {
							if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
					%>
					<button id="list"
						onclick="window.location='board.jsp?category=<%=category%>&pg=<%=pg%>&search=<%=search%>'">���</button>
						<%} else{ %>
													<button id="list"
							onclick="window.location='customer.jsp?category=<%=category%>&pg=<%=pg%>&search=<%=search%>'">���</button>
							<%} %>
					</td>
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
				} catch (SQLException e) {
					out.print(e.toString());
				}

				if (name == null) {
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
			<div class="nav">
				<%
					if (category.equals("free") || category.equals("info") || category.equals("discuss")) {
				%>
				<div class="section01">Ŀ�´�Ƽ</div>
				<ul>
					<li><a href="board.jsp?category=free">�����Խ���</a></li>
					<li><a href="board.jsp?category=info">�����Խ���</a></li>
					<li><a href="board.jsp?category=discuss">��аԽ���</a></li>
				</ul>
				<%
					} else {
				%>
				<div class="section01">������</div>
				<ul>
					<li><a href="customer.jsp?category=1vs1">1:1����</a></li>
					<li><a href="customer.jsp?category=bug">���׽Ű�</a></li>
				</ul>
				<%
					}
				%>
			</div>
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
</body>
<script language="javascript">
function deleteCheck(){
	if(confirm("�����Ͻðڽ��ϱ�?")){
		window.location = "delete_form_ok.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>";
		} else {
			return;
		}
	}
</script>
</html>