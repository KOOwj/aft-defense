<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

 <script language = "javascript">

function modifyCheck()
  {
   var form = document.modifyform;
   
   if( !form.password.value )
   {
    alert( "��й�ȣ�� �����ּ���" );
    form.password.focus();
    return;
   }
   
  if( !form.title.value )
   {
    alert( "������ �����ּ���" );
    form.title.focus();
    return;
   }
 
  if( !form.memo.value )
   {
    alert( "������ �����ּ���" );
    form.memo.focus();
    return;
   }  
 		form.submit();
  } 
</script>

</head>
<body>

<%
request.setCharacterEncoding("euc-kr");
Connection con = null;
Statement stmt = null;
//String driverName = "org.gjt.mm.mysql.Driver";
String driverName = "com.mysql.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost/project";

String name = "";
String password = "";
String title = "";
String memo = "";
int idx = Integer.parseInt(request.getParameter("idx"));
int pg = Integer.parseInt(request.getParameter("pg"));
try {
	Class.forName(driverName);
	con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
	stmt = con.createStatement();
	
	ResultSet result = stmt.executeQuery("select id, passwd, title, memo from free where no="+idx+";");
	
	if(result.next()){
		name=result.getString(1);
		password = result.getString(2);
		title = result.getString(3);
		memo = result.getString(4);
	}
	result.close();
	stmt.close();
	con.close();
} catch(SQLException e){
	out.println(e.toString());
}
%>

<table>
<form name="modifyform" method="post" action="modify_ok.jsp?idx=<%=idx%>&pg=<%=pg%>">
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="text-align:center;">
      <td width="5"></td>
      <td>����</td>
      <td width="5"></td>
     </tr>
    </table>
   <table>
     <tr>
      <td>&nbsp;</td>
      <td align="center">����</td>
      <td><input type="text" name="title" size="50" maxlength="100" value="<%=title%>"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">�̸�</td>
      <td><input type="text" name="name" size="50" maxlength="50" value="<%=name%>" disabled></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">��й�ȣ</td>
      <td><input type="password" name="password" id="pass" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">����</td>
      <td><textarea name="memo" cols="50" rows="13"><%=memo %></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"><input type=button value="����" OnClick="javascript:modifyCheck()">
       <input type=button value="���" OnClick="javascript:history.back(-1)">
      <td>&nbsp;</td>
     </tr>
    </table>
   </td>
  </tr>
 </table>

</body>
</html>