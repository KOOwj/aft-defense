<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script language = "javascript">
	function joinCheck(){
		var form = document.joinform;
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
		if(!form.repassword.value || (form.password.value != form.repassword.value)){
			alert("��й�ȣ�� Ȯ�����ּ���");
			form.repassword.focus();
			return;
		}
		
		if(!form.name.value){
			alert("�̸��� �����ּ���");
			form.name.focus();
			return;
		}
		if(!form.birthday.value){
			alert("��������� �����ּ���");
			form.birthday.focus();
			return;
		}
		if(!form.email.value){
			alert("�̸����� �����ּ���");
			form.email.focus();
			return;
		}
		if(!form.phone.value){
			alert("�޴���ȭ�� �����ּ���");
			form.phone.focus();
			return;
		}
		form.submit();
	}
</script>

</head>
<body>
    <!-- ����, ������ �ٱ������� auto�� �ָ� �߾����ĵȴ�.  -->
    <div id="wrap">
        <br><br>
        <b><font size="6" color="gray">ȸ������</font></b>
        <br><br><br>
        <form name="joinform" method="post" action="join_test_ok.jsp">
            <table>
                <tr>
                    <td id="title">���̵�</td>
                    <td>
                        <input type="text" name="id" maxlength="20">
                        <input type="button" value="�ߺ�Ȯ��" >    
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">��й�ȣ</td>
                    <td>
                        <input type="password" name="password" maxlength="15">
                    </td>
                </tr>
                
                <tr>
                    <td id="title">��й�ȣ Ȯ��</td>
                    <td>
                        <input type="password" name="repassword" maxlength="15">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�̸�</td>
                    <td>
                        <input type="text" name="name" maxlength="40">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">����</td>
                    <td>
                        <input type="radio" name="gender" value="��" checked>��
                        <input type="radio" name="gender" value="��" >��
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�������</td>
                    <td>
                    	<input type="date" name="birthday" placeholder="ex)000000" maxlength="6">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�̸���</td>
                    <td>
                        <input type="email" name="email" placeholder="ex)example@xxxxx.com" maxlength="30">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">�޴���ȭ</td>
                    <td>
                        <input type="tel" name="phone" placeholder="ex)000-0000-0000"/>
                    </td>
                </tr>
            </table>
            <br>
            <input type="button" value="����"/ OnClick="javascript:joinCheck()">  <input type="button" value="���" onclick="javascript:history.back(-1)">
        </form>
    </div>
</body>
</html>