<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file = "/WEB-INF/views/inc/asset.jsp"%>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/fanimal/asset/css/hospitalReservation.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

 <style>
.hospital-reservation-title {
	padding: 50px 0 30px 0;
}
.reservation-sel-animal#ui-id-2{
	padding : 20px 70px;
} 
.hospital-reservation h3 {
	height: 45px;
	background-color: gold;
	border: white;
	border-radius: 10px;
	color: black;
}
.hospital-reservation .ui-accordion-header {
	font-size: 180%;
	font-family: 'CookieRun-Regular';
}
.hospital-reservation .card:hover {
	border: 3px solid black;
}   
a.reserv-ani-complete {
	font-family: 'CookieRun-Regular';
	
	width: 150px;
	float: right;
	font-size: 15px;
	padding: 5px;
	display: none;
	margin-right: 600px;
	border: 2px solid #F6C30F;
	color:black;
}
  
 </style>

</head>

<body>
	<main>
		<%@ include file ="/WEB-INF/views/inc/header.jsp"%>
		<section>
        	<div id="content">
        	
        	<h1 class="hospital-reservation-title">${hosname}</h1>
        	
			<form method="POST" action="/reservation/reservationadd.do">
			<div id="accordion" class="hospital-reservation">
				<!-- 반려동물 선택 -->
				<h3>진료 동물 <span></span>
					<a type="button" onclick="moveNext();" class="badge badge-success badge-pill reserv-ani-complete">선택 완료</a>
				</h3>
  				<div class="reservation-sel-animal">
    
					<div class="row">
						<c:forEach items="${animals}" var="animal">
				        <div class="col-sm-4">
				        <div class="card">
				          	<div class="card-header" 
								style="background: url('/fanimal/files/${animal.pic}'); background-size: 100% 280px; background-repeat: no-repeat;">
								<div class = "card-header-is_closed"></div>
							</div>
				            <div class="card-body">
								<h1><i class="fa-solid fa-paw"></i> ${animal.name}</h1>
								<p class="card-body-hashtag">
									${animal.kind} / <c:if test="${animal.gender == 'm'}">수컷</c:if><c:if test="${animal.gender == 'f'}">암컷</c:if> / ${animal.age}살
								</p>
				            </div>
				        </div>
				        </div>
				        </c:forEach> 
				     </div>
			  	</div>
			  
			  	<!-- 날짜시간 선택 -->
			  	<h3>예약 날짜 <span></span></h3>
	      		<div class="reservation-sel-date">
	        		Some placeholder content for the second accordion panel. This panel is hidden by default.
	     	 	</div>
 				
				<!-- 그외 선택 -->
  				<h3>진료 목적</h3>
    			<div class="reservation-sel-other">
      
		      		<h4>방문목적</h4>
			  		<c:forEach items="${purposes}" var="p">
			  		<input type="checkbox" name="purpose${p.pseq}" value="${p.pseq}">${p.purpose}
			  		</c:forEach>
			  		
			  		<h4>특이사항</h4>
			  		<textarea rows="" cols="" placeholder="특이사항이 있을 시 반드시 작성해주세요."></textarea>
					  	
      			</div>
			</div>
			
			</form>
			</div>
        </section>
        
        
        <footer>

		</footer>
    </main>
	
	<script>
		$( function() {
			$( "#accordion" ).accordion();
		});
		
		$('.hospital-reservation .card').click(function(){
			$('.card').css('border', '0px');
			$(event.target).parents('.card').css('border', '3px solid black');
			let name = $(event.target).parents('.card').children('.card-body').find('h1').text();
			$('.hospital-reservation h3:nth-child(1) > span').text(': ' + name );
		
			$('.reserv-ani-complete').css('display','block');
		});
		
		
		function moveNext() {
			$('.hospital-reservation h3:nth-child(1)').attr('aria-selected', 'false');
			$('.hospital-reservation h3:nth-child(2)').attr('aria-selected', 'true');
		}
		
	</script>
</body>
</html>