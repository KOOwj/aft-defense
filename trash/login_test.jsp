<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script language="javascript">
	function loginCheck(){
		var form = document.loginform;
		if(!form.id.value){
			alert("���̵� �����ּ���");
			form.id.focus();
			return;
		}
		if(!form.password.value){
			alert("��й�ȣ�� �����ּ���");
			form.password.focus();
			return;
		}
		form.submit();
	}
</script>

</head>
<body>
    <div id="wrap">
        <form name="loginform" method="post" action="login_test_ok.jsp">
        
            <!-- �̹��� �߰� -->
            <br><br>
            
            <table>
                <tr>
                    <td bgcolor="skyblue">���̵�</td>
                    <td><input type="text" name="id" maxlength="50"></td>
                </tr>
                <tr>
                    <td bgcolor="skyblue">��й�ȣ</td>
                    <td><input type="password" name="password" maxlength="50"></td>
                </tr>
            </table>
            <br>
            <input type="button" value="�α���"/ OnClick="javascript:loginCheck()">
            <input type="button" value="ȸ������" OnClick="window.location='join_test.jsp'" />
            <input type="button" value="���" OnClick="javascript:history.back(-1)">
        </form>
    </div> 
</body>
</html>