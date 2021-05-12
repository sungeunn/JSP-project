<%@page import="review.ReviewDAO"%>
<%@page import="review.ReviewBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String name=request.getParameter("name");
String pass=request.getParameter("pass");
String star=request.getParameter("star");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
Timestamp date=new Timestamp(System.currentTimeMillis());
 
ReviewBean rb=new ReviewBean();
rb.setName(name);
rb.setPass(pass);
rb.setStar(star);
rb.setSubject(subject);
rb.setContent(content);
rb.setDate(date);

ReviewDAO rdao=new ReviewDAO();
rdao.insertReview(rb);
 
// notice.jsp 이동
response.sendRedirect("notice.jsp");
%>
