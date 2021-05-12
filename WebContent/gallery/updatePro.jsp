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

int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String file=multi.getFilesystemName("file");
if(file==null){
	file = multi.getParameter("oldfile");
}

GalleryBean gb=new GalleryBean();
gb.setNum(num);
gb.setName(name);
gb.setPass(pass);
gb.setSubject(subject);
gb.setFile(file);

GalleryDAO gdao=new GalleryDAO();

int check=gdao.numCheck(num, pass);
if(check==1){
	gdao.updateGallery(gb);
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