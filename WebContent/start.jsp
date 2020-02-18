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
</head>
<jsp:useBean id="db" class="project.DBcon_bean"></jsp:useBean>
<body>

	<%
	
	String s1 = request.getParameter("run");
	String id = null;
	String name = null;
	id = (String) session.getAttribute("sessionID");
	name = (String) session.getAttribute("sessionName");
	int cnt = 0;
	if(id != null && s1 != null){
		try{
			Statement stmt = null;
			Connection con = db.getConnection();
			stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("select count(*) from playing");
			if(result.next()){
				cnt = result.getInt(1);
			}
			if(cnt != 0){
				stmt.executeUpdate("truncate playing;");
			}
			
			PreparedStatement pstmt = con.prepareStatement("insert into playing(id, name) values(?,?);");
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			
			Runtime.getRuntime().exec("C:\\Users\\koo\\Downloads\\project\\project\\WebContent\\game.exe");
			
			stmt.close();
			pstmt.execute();
			pstmt.close();
			result.close();
			con.close();
		} catch(SQLException e){
			out.println(e.toString());
		} catch(Exception ex){
			
		}
	} else{
		%>
			<script language="javascript">
				self.window.alert("로그인 해주세요.");
			</script>
		<%
	}
	%>
	<script language=javascript>
	history.back(-1);
	</script>
</body>
</html>