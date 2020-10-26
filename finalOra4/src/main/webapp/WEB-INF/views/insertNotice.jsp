<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}
header {
	width: 1000px;
	height: 100px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	margin: 20px auto;
}
#logo {
	float: left; 
}
li{
	list-style-type: none;  
}
#top {
	margin: 50px 0 0 0;
	font-size: 15px;
	float: right;
}
#top li {
	display: inline;
}
.menu{
	margin: 0 20px 0 20px;
}
#login {
	font-size: 13px;
	text-align: right;
	margin: 0 20px 0 0;
}

/* 헤더 끝 -------------------------------------------------- */

h2 {
	padding: 20px;
	width: 120px;
	margin: 40px auto;
	color: #c8572d;
	text-align: center;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	text-decoration: none;
}

a{
	text-decoration: none;
	color: black;
}

section {
	width: 900px;
	height: 700px;
	margin: 20px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 14pt;
	margin-top: 50px;
	margin-bottom: 100px;
}

#title{
	width: 700px;
	height: 30px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 15px;
	padding-left: 5px;
	margin-left: 5px;
}

select {
	width:70px;
	height: 30px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 13pt;
}

#content{
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 13pt;
	padding: 8px;
}

button,#btn_insert {
	width:50px;
	height: 30px;
    background-color: #eccb6a;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font-family: 'NEXON Lv1 Gothic Low OTF';
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0 5px 0 0;
    cursor: pointer;
    float: right;
}

#btn_insert{
	background-color: #88bea6;
}

   /*float 초기화 아이디*/
#clear{
	clear: both; 
}
</style> 
</head>
<body>
	<jsp:include page="header.jsp"/>
   
	<a href="listNotice"><h2>공지사항</h2></a>
	<section>
		<form action="insertNotice" method="post">
			<select name="code_value" size="1">
	     		<option value="0">전체</option>
	     		<c:forEach var="c" items="${category }">
	     			<option value="${c.code_value }">${c.code_name }</option>
	     		</c:forEach>
	        </select>
	        <br>
			<br>
			<input type="hidden" name="n_no" value="${n_no }">
			글 제목  <input type="text" name="n_title" id="title" placeholder="제목을 입력하세요" >
			<br>
			<br>
			<textarea rows="20" cols="95" name="n_content" id="content" placeholder="내용을 입력하세요"></textarea>
			<br>
			<br>
			<button>취소</button>
			<button id="btn_insert">등록</button>
			
		</form>
	</section>	
	<br>
	<jsp:include page="footer.jsp"/>
</body>
</html>