<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file = "/WEB-INF/views/inc/asset.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<main>
		<c:if test="${type == '0'}">
		<%@ include file ="/WEB-INF/views/inc/companyheader.jsp"%>
		</c:if>
		<c:if test="${type == '1'}">
		<%@ include file ="/WEB-INF/views/inc/userheader.jsp"%>
		</c:if>
		<c:if test="${type == '2'}">
		<%@ include file ="/WEB-INF/views/inc/header.jsp"%>
		</c:if>
		<section>
	    	<div id="content">
	    		<table class="table table-stripped">
	    			<tr>
	    				<th>${qdto.title}</th>
	    			</tr>
	    			<tr>
	    				<td>${qdto.content}</td>
	    			</tr>
	    			<tr>
	    				<td>${qdto.attachFile}</td>
	    			</tr>
	    			<tr>
	    				<td>
	    					<span>${qdto.nickname}</span>
	    					<span>${qdto.postdate}</span>
	    				</td>
	    			</tr>
	    		</table>
	    		
	    		<div>답변</div>
	    		<table class="table table-stripped">
	    			<tr>
	    				<td></td>
	    			</tr>
	    		</table>
	    		
           	</div>
       </section>
       <footer>

       </footer>
	</main>
</body>
</html>