<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ART Defense</title>
<script language="javascript">
	function replyCheck() {
		var form = document.replyform;
		if (!form.contents.value) {
			alert("������ �����ּ���");
			form.contents.focus();
			return;
		}
		form.submit();
	}
</script>
</head>
<jsp:useBean id="db" class="project.DBcon_bean" />
<body>
	<%
		String search = null;
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		String category = null;
		String cat_db = null;
		String cat_kor = null;
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pg = Integer.parseInt(request.getParameter("pg"));
		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		if (category.equals("free")) {
			cat_db = "free_board";
			cat_kor = "�����Խ���";
	%><link rel="stylesheet" type="text/css" href="write_free.css">
	<%
		} else if (category.equals("info")) {
			cat_db = "info_board";
			cat_kor = "�����Խ���";
	%><link rel="stylesheet" type="text/css" href="write_info.css">
	<%
		} else if (category.equals("discuss")) {
			cat_db = "discuss_board";
			cat_kor = "��аԽ���";
	%><link rel="stylesheet" type="text/css" href="write_discuss.css">
	<%
		} else if (category.equals("1vs1")) {
			cat_db = "customer_1vs1";
			cat_kor = "1:1����";
	%><link rel="stylesheet" type="text/css" href="write_free.css">
	<%
		} else if (category.equals("bug")) {
			cat_db = "customer_bug";
			cat_kor = "���׽Ű�";
	%><link rel="stylesheet" type="text/css" href="write_info.css">
	<%
		}
		String id = null;
		String pass = null;
		String name = null;
		String title = null;
		String contents = null;
		id = (String) session.getAttribute("sessionID");
		name = (String) session.getAttribute("sessionName");
		pass = (String) session.getAttribute("sessionPass");
		Statement stmt = null;
		try {
			Connection con = db.getConnection();
			stmt = con.createStatement();

			ResultSet result = stmt.executeQuery("select title from " + cat_db + " where no=" + idx + ";");

			if (result.next()) {
				title = result.getString(1);
			}
			result.close();
			stmt.close();
			con.close();
		} catch (SQLException e) {
			out.println(e.toString());
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
				<image src="real_start.png" width="250" height="250" />
			</button>
		</div>
		<div class="noticeline">
			<div class="notice">
				<table class="write">
					<%
						if (search == null) {
					%>
					<form name="replyform" method="post"
						action="reply_form_ok.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>">
						<%
							} else {
						%>
						<form name="replyform" method="post"
							action="reply_form_ok.jsp?category=<%=category%>&pg=<%=pg%>&idx=<%=idx%>&search=<%=search%>">
							<%
								}
							%>
							<tr>
								<th colspan="2">���</th>
							</tr>

							<tr>
								<td id="title">����</td>
								<td><input id="title" name="title" value="<%=title%>"
									readonly="readonly"></td>
							</tr>

							<tr>
								<td id="contents">����</td>
								<td><textarea id="contents" name="contents"></textarea></td>
							</tr>

							<tr>
								<td id="button" colspan="2"><input type="button" value="Ȯ��"
									onclick="javascript:replyCheck();"> <input
									type="button" value="���" onclick="javascript:history.back(-1)">
								</td>
							</tr>
						</form>
				</table>
			</div>

			<button id="login1"><%=name%>��
			</button>
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