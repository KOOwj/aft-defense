 <%@page import="java.io.File"%>
 <%@page import="java.io.*"%>
 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 <title>ART Defense</title>
 </head>
 <body>

 <% 
  // �ٿ���� ������ �̸��� ������
  //String fileName = request.getParameter("app1.zip");
   String fileName= "ART Defense.zip";
  // �ٿ���� ������ ����Ǿ� �ִ� ���� �̸�
  String saveFolder = "img";
  
  // Context�� ���� ������ �˾ƿ�
  ServletContext context = getServletContext(); // ������ ���� ȯ�������� ������
  
  // ���� ������ ����Ǿ� �ִ� ������ ���
  String realFolder = context.getRealPath(saveFolder);
  // �ٿ���� ������ ��ü ��θ� filePath�� ����
  String filePath = realFolder + "\\" + fileName;
  
  out.println(filePath);

  try{
   // �ٿ���� ������ �ҷ���
   File file = new File(filePath);
   byte b[] = new byte[4096];
   
   // page�� ContentType���� �������� �ٲٱ� ���� �ʱ�ȭ��Ŵ
   response.reset();
   response.setContentType("application/octet-stream");
   
   // �ѱ� ���ڵ�
   String Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
   // ���� ��ũ�� Ŭ������ �� �ٿ�ε� ���� ȭ���� ��µǰ� ó���ϴ� �κ�
   response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
  
   // ������ ���� ������ �о���� ���ؼ� ����
   FileInputStream in = new FileInputStream(filePath);
  
   // ���Ͽ��� �о�� ���� ������ �����ϴ� ���Ͽ� ���ֱ� ���ؼ� ����
   ServletOutputStream out2 = response.getOutputStream();
   
   int numRead;
   // ����Ʈ �迭 b�� 0�� ���� numRead�� ���� ���Ͽ� ���� (���)
   while((numRead = in.read(b, 0, b.length)) != -1){
    out2.write(b, 0, numRead);
   }
   
   out2.flush();
   out2.close();
   in.close();
   
  } catch(Exception e){
  }
 %>
 </body>
 </html>