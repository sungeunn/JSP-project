<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

int num=Integer.parseInt(multi.getParameter("num"));
 String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//file
String file=multi.getFilesystemName("file");
if(file==null){
	// 새롭게 수정할 파일이 없으면 기존 파일이름 "oldfile" 저장
	file = multi.getParameter("oldfile");
}

BoardBean bb=new BoardBean();
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

BoardDAO bdao=new BoardDAO();

int check=bdao.numCheck(num, pass);
if(check==1){
	bdao.updateBoard(bb);
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