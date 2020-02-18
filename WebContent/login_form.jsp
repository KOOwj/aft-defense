<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="login_form.css">
<title>ART Defense</title>
<script language="javascript">
	function loginCheck(){
		var form = document.loginform;
		if(!form.id.value){
			alert("���̵� �Է����ּ���.");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("��й�ȣ�� �Է����ּ���.");
			form.password.focus();
			return;
		}
		form.submit();
	}
</script>

<% 
String category = null;
if(request.getParameter("category") != null){
	category = request.getParameter("category");
}
%>


</head>
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
		<div class="login">
			<table>
				<form name="loginform" method="post" action="login_form_ok.jsp?category=<%=category%>">
					<tr>
						<th>�α���</th>
					</tr>
					<tr>
						<td><input type="text" name="id" placeholder="ID"></td>
					</tr>
					<tr>
						<td><input type="password" name="password" placeholder="PW"></td>
					</tr>
					<tr>
						<td><input id="login" type="button" value="�α���" onclick="javascript:loginCheck()"> <input
							id="member" type="button" value="ȸ������" onclick="window.location='join_form.jsp'"></td>
					</tr>

				</form>
			</table>
		</div>
	</div>
</body>
</html>