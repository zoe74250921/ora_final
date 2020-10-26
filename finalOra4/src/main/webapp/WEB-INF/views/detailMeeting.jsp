<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		/* 공통 */
		* {
	   		padding : 0px;
	   		margin : 0px;
	   		font-family: 'NEXON Lv1 Gothic Low OTF';
		}
		li {
    		list-style-type: none;
	    }
		a {
			text-decoration: none;
			color: black;
		}
		header {
			width: 1000px;
	      	height: 100px;
			margin-top: 10px;
			margin: 10px auto;
		}
		#address {
			margin: 10px 0 0 0;
			font-size: 11px;
		}
		#logo {
			float: left; 
		}
		#top {
			margin: 30px 20px 0 0;
			font-size: 12px;
			float: right;
			text-align: right;   
		}
		#top li {
			display: inline;
			margin-left: 18px;
		}
		#login {
			font-size: 11px;
			text-align: right;
		}
		section {
			margin: 0 auto;
			padding: 10px;
			width: 1000px;
			text-align: left;
		}
		footer {
			width: 1000px;
			height: 150px;
			margin-top: 100px;
			margin: 10px auto;
		}
		#footer_box {
	       width: 1000px;
	       height: 150px;
	       margin: 0 auto;
	       text-align: center;
		}
		#footer_icon{
			margin: 0 auto;
		}
	
		/* 개별 */
		.btnImg {
			height: 30px;
			float: right;
		}
		#reply {
			padding-bottom: 3px;
		}
		#comment {
			display:inline-block;
			position:relative;
		}
		#btnImg {
			position:absolute;
			bottom:30px;
			right:10px;
			border-style: none;
			background-color: transparent;
			width: 50px;
		}
		textarea {
			display:block;
		}
		#contents {
			border: 1px solid #D5D5D5;
			padding: 60px;
			margin: 50px 0 100px;
		}
		.repInfo {
			margin-left: 25px;
			font-size: 13px;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#loadComment").empty();
			$.ajax("/detailMRep",{function(arr){
				$.each(arr,function(idx, mr){
					var rank_icon = $("<img/>").attr("src","../meetingFile/"+mr.rank_icon);
					var nickName = $("<p></p>").html(mr.nickName);
					var mr_content = $("<p></p>").html(mr.mr_content);
					var mr_file1 = $("<img/>").attr("src","../meetingFile/"+mr.mr_file1);
					var regdate = $("<p></p>").html(mr.regdate);
					$("#loadComment").append(rank_icon, nickName, mr_content, mr_file1, regdate);
				});
			}});
		});
	</script>
</head>
<body>
	<header>
		<div id="logo">
			<a href="/mainPage"><img src='headerImg/logo.png' height="100"></a>
		</div>
	    <nav>
		    <div id="login">
				<c:choose>
					<c:when test="${m == null }">
			      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
			      	</c:when>
			      	<c:when test="${m != null }">
			      		<a href="modify">${m.nickName } 라이더!</a> &nbsp;&nbsp;<a href="/logout">로그아웃</a>
			      	</c:when>
     			 </c:choose>
			</div>
			<ul id="top">
				<li>오늘의 라이딩</li>
				<li>자전거 길</li>
				<li><a href="listReview">후기게시판</a></li>
				<li><a href="/listMeeting?pageNo=1">번개게시판</a></li>
				<li>정보게시판</li>
			</ul>
		</nav>
	</header>
	<section>
		<br><br>
		<p style="font-size: 20px;"><a href="/listMeeting">번개 게시판</a>&nbsp;&gt;&nbsp;<font color="#c85725">번개 상세</font></p>
		<p style="font-size: 15px; padding-top: 2px;">만나서 같이 라이딩 해요.</p>
		<br><br>
	
		<div id="contents">
			<p style="font-size: 30px; padding: 30px 0 20px;">${mt.m_title }</p><br>	
			<img src="rank/${mt.rank_icon }" height="25" style="float: left; margin-right: 5px;">
			<div style="padding-top: 5px;">
				<p style="margin-right: 15px; float: left;">${mt.nickName }</p>
				<p style="float: left; font-size: 13px;">${mt.m_regdate }</p>
				<p style="float: right; font-size: 13px;">조회수 ${mt.m_hit }</p>
			</div>
			<br>
			<hr style="margin: 10px 0 10px;">
			<div style="padding: 3px; font-size: 20px;">코스 : ${mt.c_name }</div>
			<hr style="margin: 10px 0 10px;">
			<!-- 
			위도 : ${mt.m_latitude }<br>
			경도 : ${mt.m_longitude }<br>
			모임장소 : ${mt.m_locname }<br>
			모임시간 : ${mt.m_time }<br>
			모임인원 : ${mt.m_numpeople }
			 -->
			<br>
			
			<c:if test="${mf!=null }">
				<c:forEach var="mf" items="${mf}">
					<img src="${mf.mf_path }/${mf.mf_savename }" width="400">
				</c:forEach> 
			</c:if>
			<br><br><br>
			${mt.m_content }
			<br><br><br><br>
			
			<!-- 수정,삭제 버튼 -->
			<a href="deleteMeeting?m_no=${mt.m_no }"><img src="meetingImg/delete.png" class="btnImg"></a>
			<a href="updateMeeting?m_no=${mt.m_no }"><img src="meetingImg/edit.png" class="btnImg"></a>
			<br><br>
			<img src="meetingImg/speech.png" style="size: 20px; float: left; padding-right: 10px;">
			<h3>댓글&nbsp;${cntRep }</h3>
			<hr style="margin: 10px 0 10px;">
			<!-- 댓글출력 -->
			<div id="reply">
				<c:forEach var="mr" items="${mr }">
					<c:if test="${mr.mr_step==0 }">
						<img src="rank/${mr.rank_icon }" height="25">${mr.nickName }<br>
						<p style="margin-left: 25px;">${mr.mr_content }</p>
						<c:if test="${mr.mr_file1!=null }">
							<p style="margin-left: 25px;"><img src="meetingFile/${mr.mr_file1 }" height="100"></p>
						</c:if>
						<p class="repInfo" style="float: left;">${mr.mr_regdate }<p>
						<a class="repInfo">[답글달기]</a>
					</c:if>
					<div style="margin: 0 0 0 20px;">
						<c:if test="${mr.mr_step>0 }">
							<img src="rank/${mr.rank_icon }" height="25">${mr.nickName }<br>
								<p style="margin-left: 25px;">${mr.mr_content }</p>
							<c:if test="${mr.mr_file1!=null }">
								<p style="margin-left: 25px;"><img src="meetingFile/${mr.mr_file1 }" height="100"></p>
							</c:if>
							<p class="repInfo" style="float: left;">${mr.mr_regdate }<p>
							<a class="repInfo">[답글달기]</a>	
						</c:if>
					</div>
				</c:forEach>
			</div>
			
			
			<!-- jQuery -->
			<!-- 여기에 댓글출력 -->
			<!-- <div id="loadComment">
			</div>
			<button>[답글달기]</button>
			
			<img>rank_icon
			<p>nickName</p>
			<p>mr_content</p><br>
			<img>mr_file1
			<p>regdate</p> -->
			
			<br>
			댓글등록<br>
			<form id="comment">
				<input type="hidden" name="rank_icon" id="rank_icon">
				<input type="hidden" name="nickname" id="nickname">
				<input type="hidden" name="regdate" id="regdate">
				<textarea rows="10" cols="80" name="mr_content" id="mr_content"></textarea>
				<input type="file" name="mr_file1" id="mr_file1">
				<button id="btnAdd"><img src="meetingImg/add.png" id="btnImg"></button>
			</form>
			

		</div>
	</section>
	<footer>
		<hr style="width: 100%; color: gray;">
		<br>
		<div id='footer_box'>
			<div id="footer_icon" >
				<img src='footerImg/instagram.png' height="50px">
				<img src='footerImg/facebook.png' height="50px">
				<img src='footerImg/twitter.png' height="50px">
				<ul id="address">
					<li>04108 | 서울시 마포구 백범로 23 구프라자 3층</li>
					<li>TEL: 02-707-1480 | Email: ora@bit.com</li>
					<li>COPYRIGHT (C)2020 오늘의 라이딩 ALL RIGHTS RESERVED</li>
				</ul>
			</div>
		</div>
	</footer>
</body>
</html>