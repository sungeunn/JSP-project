<%@page import="review.ReviewDAO"%>
<%@page import="review.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String star=request.getParameter("star");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

ReviewBean rb=new ReviewBean();
rb.setNum(num);
rb.setName(name);
rb.setPass(pass);
rb.setStar(star);
rb.setSubject(subject);
rb.setContent(content);

ReviewDAO rdao=new ReviewDAO();

int check=rdao.numCheck(num, pass);
if(check==1){
	rdao.updateReview(rb);
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