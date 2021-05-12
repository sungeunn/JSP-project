<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String file=multi.getFilesystemName("file");
 
GalleryBean gb=new GalleryBean();
gb.setName(name);
gb.setPass(pass);
gb.setSubject(subject);
gb.setFile(file);

GalleryDAO gdao=new GalleryDAO();
gdao.insertGallery(gb);
 
 response.sendRedirect("notice.jsp");
%>