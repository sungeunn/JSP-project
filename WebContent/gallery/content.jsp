<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allmovie GALLERY</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/gallery.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->

<!-- 게시판 -->
<%
int num=Integer.parseInt(request.getParameter("num"));

GalleryDAO gdao=new GalleryDAO();
gdao.updateReadcount(num);
GalleryBean gb=gdao.getGallery(num);
%>
<article>
<table id="notice">
<tr><td>영화제목</td><td colspan="3"><%=gb.getSubject() %></td><tr>
<tr><td>번호</td><td><%=gb.getNum() %></td><tr>
<tr><td>글쓴이</td><td><%=gb.getName() %></td><tr>
<tr><td>첨부파일</td>
      <td colspan="7">
      <img src="../upload/<%=gb.getFile() %>" width="100" height="100"></td><tr>
</table>
<div id="table_search">
<%
// 글수정, 글삭제  보이기 : 글쓴사람, 로그인사람 일치하면 
// String id 세션값 가져오기 
String id = (String)session.getAttribute("id");
// if 세션값이 있으면 
// if 세션   글쓴이 비교  일치하면 글수정 글삭제 버튼 보이기
if(id!=null){
	if(id.equals(gb.getName())){
	%>
<input type="button" value="수정" class="btn" 
        onclick="location.href='updateForm.jsp?num=<%=gb.getNum()%>'">
<input type="button" value="삭제" class="btn" 
        onclick="location.href='deleteForm.jsp?num=<%=gb.getNum()%>'">	
	<%
	}
}
%>
<input type="button" value="목록" class="btn"  onclick="location.href='notice.jsp'">
</div>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>