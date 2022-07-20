<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file = "/WEB-INF/views/inc/asset.jsp"%>
<link rel="stylesheet" href="/fanimal/asset/css/user/reshos.css">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
	<main>
		<%@ include file ="/WEB-INF/views/inc/userheader.jsp"%>
		<section>
            <div id="content">					
				
				<h3 style="margin-top: 0; padding-top: 30px">예약 내역</h3>
				<div id="resdiv">
				
					<c:forEach items="${reslist}" var="dto">
					<a href="예약번호${dto.rhseq}" style="color: black;">
					<table class="resbox">
						<tr>
							<td colspan="2">${dto.name}</td>	
						</tr>
						<tr>
							<td>${dto.hpname}</td>
							<td>${dto.resdate}</td>												
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="예약취소" class="btn btn-danger"></td>
						</tr>
					</table>
					</a>
					</c:forEach>
					<c:if test="${list.size() == 0}">
					<h4>예약내역이 없습니다.</h4>					
					</c:if>
					
				</div>		
				
				
				<h3 style="margin-top: 0; padding-top: 30px">지난 예약 내역</h3>
				<div id="beforediv">
					<c:forEach items="${beflist}" var="dto">
					<a href="예약번호${dto.rhseq}" style="color: black;" id="beforea">
					<table class="beforebox">
						<tr>
							<td colspan="2">${dto.name}</td>	
							<td>병원:  ${dto.hpname}</td>
							<td><span>증상:</span><span>  ${dto.uniqueness}</span></td>
							<td>예약날짜:  ${dto.resdate}</td>
						</tr>											
					</table>
					</a>
					</c:forEach>					
					<c:if test="${list.size() == 0}">
					<h4>예약내역이 없습니다.</h4>					
					</c:if>
					
					<div style="text-align: center">
				
						 ${pagebar}
					</div>
				</div>
            </div>
        </section>
       <footer>

       </footer>
    </main>
    <script>
    $('#pagebar').change(function() {
		
		location.href = '/fanimal/user/mypage/reshos.do?page=' + $(this).val();
		
	});
    </script>    
</body>
</html>