<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO();

int check=mdao.userCheck(id, pass);

if(check==1){
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
} else if(check==0) {
	%>
	<script>
		alert("잘못된 비밀번호 입니다.");
		history.back();
	</script>
	<%
} else {
	%>
	<script>
		alert("아이디를 입력하세요.");
		history.back();
	</script>
	<%
}
%>
