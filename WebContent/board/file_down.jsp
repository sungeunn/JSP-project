<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils"%>
<%
request.setCharacterEncoding("utf-8");

   String fileName = request.getParameter( "file_name" );
   System.out.println(fileName);
 
   String uploadPath=request.getRealPath("/upload");
   String sFilePath = uploadPath + "\\" + fileName;  
   System.out.println(sFilePath);

   byte b[] = new byte[4096];
     
   File oFile = new File(sFilePath);
   FileInputStream in = new FileInputStream(oFile);

   String sMimeType = getServletContext().getMimeType(sFilePath);
   System.out.println("sMimeType>>>"+sMimeType );

   // octet-stream은  8비트로 된 일련의 데이터
   // 지정되지 않은 파일 형식을 의미
   // 파일 타입이 없는 경우 기본으로 설정
   if(sMimeType == null) sMimeType = "application/octet-stream";

   // 서버에서 클라이언트로 응답할때  확인한 타입으로 설정
   response.setContentType(sMimeType);

   // 브라우저별로 한글처리
   // 브라우저 확인 
   String userAgent = request.getHeader("User-Agent");
   // 익스플로러 브라우저이면 true/ 나머지 브라우저 false
   boolean ie = (userAgent.indexOf("MSIE") > -1) || (userAgent.indexOf("Trident") > -1);
   String sEncoding=null;
   if(ie) {
	  // 익스플로러 브라우저 => 한글처리 해서  sEncoding 변수에 저장
	  sEncoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
	  System.out.println(sEncoding);
   }else{
	  // 나머지 브라우저
      // 한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지)
	  sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
	  System.out.println(sEncoding);
   }

   // 서버에서 클라이언트에 보낼때  파일을 브라우저에서 바로 실행하지 않고 첨부(다운) 되게 설정
   response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);
   
   // ServletOutputStream 자바 API 응답 출력 하기위한 객체생성
   ServletOutputStream out2 = response.getOutputStream();
   int numRead;

   // 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
   // FileInputStream로  입력받은 파일을 =>   ServletOutputStream 이용해서 출력  
   while((numRead = in.read(b, 0, b.length)) != -1) {
     out2.write(b, 0, numRead);
   }
   out2.flush(); 
   out2.close();
   in.close();

   out.clear();
   out = pageContext.pushBody();
   // ServletUtils.returnFile( PdsMisc.UPLOAD_DIRECTORY + File.separator + StringMisc.uniToEuc( fileName ), response.getOutputStream() );
%>
