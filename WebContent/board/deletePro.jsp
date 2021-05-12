<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String pass=request.getParameter("pass");

BoardDAO bdao=new BoardDAO();

int check=bdao.numCheck(num, pass);
if(check==1){
	bdao.deleteBoard(num);
	response.sendRedirect("notice.jsp");
}else if(check==0){
	%>
	<script>
		alert("잘못된 비밀번호 입니다.");
		history.back();
	</script>
	<%
}else{
	%>
	<script>
		alert("num없음");
		history.back();
	</script>
	<%
}
%>