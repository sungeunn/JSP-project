<%@ page import="web.mail.*"  %>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="mb" class="member.MemberBean">
	<jsp:setProperty name="mb" property="*" />
</jsp:useBean>

<%
mb.setDate(new Timestamp(System.currentTimeMillis()));
MemberDAO mdao = new MemberDAO();
mdao.insertMember(mb);
%>

<%
String email = request.getParameter("email");
MailSend ms = new MailSend();
ms.MailSend(email);
%>

<script>
	alert("회원가입 성공");
	location.href="login.jsp"
</script>
