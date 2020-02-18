<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%
    request.setCharacterEncoding("euc-kr");
    %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="join_form.css">
<title>ART Defense</title>
<script language = "javascript">
	
	function joinCheck(){
		var form = document.joinform;
		if(!form.id.value){
			alert("���̵� �Է����ּ���.");
			form.id.focus();
			return;
		}
		var idRule = /^[A-Za-z0-9]{4,18}$/;
		if(!(idRule.test(form.id.value))){
			alert("���̵�� ����/���� 4~18�ڸ� �Դϴ�.");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("��й�ȣ�� �Է����ּ���.");
			form.password.focus();
			return;
		}
		var passwordRule = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		if(!(passwordRule.test(form.password.value))){
			alert("��й�ȣ�� ����/����/Ư������ 8~16�ڸ� �Դϴ�.")
			form.password.focus();
			return;
		}
		if(!form.repassword.value || (form.password.value != form.repassword.value)){
			alert("��й�ȣ�� Ȯ�����ּ���.");
			form.repassword.focus();
			return;
		}
		if(!form.name.value){
			alert("�̸��� �����ּ���.");
			form.name.focus();
			return;
		}	
		if(!form.birthday.value){
			alert("��������� �Է����ּ���.");
			form.birthday.focus();
			return;
		}

		if(!form.phone.value){
			alert("�ڵ����� �Է����ּ���.");
			form.phone.focus();
			return;
		}
		var phoneRule = /^\d{3}-\d{3,4}-\d{4}$/;
		if(!(phoneRule.test(form.phone.value))){
			alert("�ڵ��� ������ �����ּ���.");
			form.phone.focus();
			return;
		}
		if(!form.email.value){
			alert("�̸����� �Է����ּ���.");
			form.email.focus();
			return;
		}
		var emailRule = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!(emailRule.test(form.email.value))){
			alert("�̸��� ������ �����ּ���.");
			form.email.focus();
			return;
		}
		form.submit();
	}
</script>

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
		<div class="join">
			<table>
			<form name="joinform" method="post" action="join_form_ok.jsp">
			<tr><th>ȸ������</th></tr>
			<tr><td><input id = "idform" type="text" name="id" placeholder="ID"/></td></tr>
			<tr><td><input type="password" name="password" placeholder="PW"></td></tr>
			<tr><td><input type="password" name="repassword" placeholder="PW"></td></tr>
			<tr><td><input type="text" name="name" placeholder="�̸�"></td></tr>
			<tr><td><input type="text" name="birthday" placeholder="951109"></td></tr>
			<tr><td><input type="tel" name="phone" placeholder="010-0000-0000"></td></tr>
			<tr><td><input type="email" name="email" placeholder="example@xxxxx.com"></td></tr>
			<tr><td><input id="login" type="button" value="Ȯ��" onclick="javascript:joinCheck()"> <input id="member" type="button" value="���" onclick="javascript:history.back(-1)"></td></tr>
		
			</form>
			</table>
		</div>
	</div>
</body>
</html>