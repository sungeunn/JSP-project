<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
Timestamp date=new Timestamp(System.currentTimeMillis());
int readcount=0;
String file=multi.getFilesystemName("file");
 
BoardBean bb=new BoardBean();
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setDate(date);
bb.setReadcount(readcount);
bb.setFile(file);

 BoardDAO bdao=new BoardDAO();
 bdao.insertBoard(bb);
 
 response.sendRedirect("notice.jsp");
%>