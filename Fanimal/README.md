# :dog: Fanimal, 반려동물 케어 통합 관리 및 커뮤니티 

## 1. 제작 기간 & 참여 인원
- 2022.07.11 ~ 2022.07.22
- 팀 프로젝트 (6명)

## 2. 사용 기술 및 협업 툴
- Java 11 
- Oracle 11g
- HTML5, CSS, JavaScript 
- JSP, Servlet

## 3. ERD 설계
![](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/3.%20ERD.png)

## 4. 핵심 기능
### 📌  1.	동물 병원 정보 조회 및 진료 예약
- <b>목적</b> 
    - 보호자의 주소로 부터 가까운 순으로 병원정보를 조회하고, 등록된 반려동물의 진료를 예약할 수 있다.
- <b>기능</b> 
    1. 동물 병원 정보를 필터를 적용하여 조회할 수 있다.
    2. 동물 병원을 선택하여 상세정보를 확인한 후 예약을 할 수 있다.
    3. 반려동물과 예약날짜, 진료정보 등을 입력하여 예약한다.
    

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1.  request get parameter를 이용한 동물병원 조회

- View
~~~html
<form method="GET" action="/fanimal/diagnosis/hospitallist.do" id="hospitallist">
    <div class="hospitallist-align">
        <select name="align" class="form-control col-3">
            <option value="distance">거리순</option>
            <option value="avgstar">별점순</option>
        </select>
    </div>
</form>	
~~~

- Controller
~~~ java
@WebServlet("/diagnosis/hospitallist.do")
public class HospitalList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO auth = (UserDTO)session.getAttribute("auth");

        HospitalListDTO dto = new HospitalListDTO();
        String align = req.getParameter("align");

        if (align == null) { align = "distance"; }
        dto.setAlign(align);


        //거리순 정렬
        if (auth != null) {
            dto.setXcoor(auth.getXcoor());
            dto.setYcoor(auth.getYcoor());
        } else {
            dto.setXcoor(203469.119368);
            dto.setYcoor(443500.904043);
        }

        ArrayList<HospitalDTO> list = dao.getList(dto);

        req.setAttribute("list", list);
   
         RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/main/user/diagnosis/hospitallist.jsp");

	dispatcher.forward(req, resp);
    }
}
~~~

- Model
~~~java
public ArrayList<HospitalDTO> getList(HospitalListDTO dto) {
		
		try {
			String sql = "{ call procHospitalList(?, ?, ?, ?, ?, ?, ?, ?) }";
			
			conn = DBUtil.open();
			cstat = conn.prepareCall(sql);
			
			cstat.setString(1, dto.getBegin());
			cstat.setString(2, dto.getEnd());
			cstat.setString(3, dto.getSigu());
			cstat.setDouble(4, dto.getXcoor());
			cstat.setDouble(5, dto.getYcoor());
			cstat.setString(6, dto.getSearch());
			cstat.setString(7, dto.getAlign());
			cstat.registerOutParameter(8, OracleTypes.CURSOR);
		
			cstat.executeQuery();
			
			rs = (ResultSet)cstat.getObject(8);
			
			ArrayList<HospitalDTO> list = new ArrayList<HospitalDTO>();

			while (rs.next()) {
				HospitalDTO hdto = new HospitalDTO();
				
				hdto.setHpseq(rs.getString("hpseq"));
				hdto.setHosname(rs.getString("hosname"));
				hdto.setTel(rs.getString("tel"));
				hdto.setAddress(rs.getString("address"));
				hdto.setAvgStar(String.format("%.1f", rs.getDouble("avgstar")));
				list.add(hdto);
			}
			
			rs.close();
			cstat.close();
			conn.close();
			
			return list;
		
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return null;
	}
~~~

- DB
~~~sql
create or replace procedure procHospitalList(
    pBegin  in number,
    pEnd    in number,
    pSigu   in tblcompany.address%type,
    pXcoor  in number,
    pYcoor  in number, 
    pSearch in tblhospital.hosname%type,
    pAlign  in varchar2,
    pResult out sys_refcursor
)
is
begin

    if pAlign = 'distance' then
        
        open pResult for 
        select hpseq, hosname, tel, address, avgstar from
            (select rownum as rnum, hpseq, hosname, tel, address, avgstar from (select h.hpseq, h.hosname, c.tel, c.address, 
                (select avg(star) from tblHosReview where hpseq = h.hpseq) as avgstar
                    from tblHospital h inner join tblCompany c on h.cseq = c.cseq
                        where h.statseq = 1 and c.address like (pSigu || '%') and h.hosname like ('%' || pSearch ||'%')
                            order by (select sqrt(power(pXcoor-c.xcoor,2) + power(pYcoor-c.ycoor,2)) from dual) asc NULLS last)) 
            where rnum between pBegin and pEnd;
                
    elsif pAlign = 'avgstar' then
        
        open pResult for 
        select hpseq, hosname, tel, address, avgstar from
            (select rownum as rnum, hpseq, hosname, tel, address, avgstar from (select h.hpseq, h.hosname, c.tel, c.address, 
                (select avg(star) from tblHosReview where hpseq = h.hpseq) as avgstar
                    from tblHospital h inner join tblCompany c on h.cseq = c.cseq
                        where h.statseq = 1 and c.address like (pSigu || '%') and h.hosname like ('%' || pSearch || '%')
                            order by avgstar desc NULLS last)) 
            where rnum between pBegin and pEnd;
    else 
    
    open pResult for select null as hpseq, null as hosname, null as tel, null as address, null as avgstar from dual;
         
    end if;
end;
~~~

#### 2. ajax를 사용하여 동물병원 예약하기

- Controller 
~~~java

@WebServlet("/reservation/reservation.do")
public class Reservation extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		UserDTO auth = (UserDTO)session.getAttribute("auth");
	
		String hpseq = req.getParameter("hpseq");
		
		
		//반려동물 리스트 
		ReservationDAO dao = new ReservationDAO();
		ArrayList<AnimalListDTO> animals = dao.getAnimal(auth.getId());
		
		//오늘기준 한달 내의 일정 중 예약 가능한 일정
		ArrayList<String> days = dao.getDay(hpseq); 
		HospitalDTO time = dao.getTime(hpseq);
		
		//방문 목적 종류
		ArrayList<PurposeDTO> purposes = dao.getPurpose();
		
		//요일
		String[] opendays = new String[7];
		
		for (String d : days) {
			switch(d) {
				case "일" : opendays[0] = d;  break;
				case "월" : opendays[1] = d;  break;
				case "화" : opendays[2] = d;  break;
				case "수" : opendays[3] = d;  break;
				case "목" : opendays[4] = d;  break;
				case "금" : opendays[5] = d;  break;
				case "토" : opendays[6] = d;  break;
			}
		}
		
		String restdays = "";
		
		for(int i=0; i<opendays.length; i++) {
			if (opendays[i] == null) {
				restdays += "day != " + i + " && ";
			}
		}
		restdays = restdays.substring(0, restdays.length()-3);
		
		
		//시간
		int starthour = Integer.parseInt(time.getStarttime().split(":")[0]);
		int startmin =  Integer.parseInt(time.getStarttime().split(":")[1]);
		int endhour =  Integer.parseInt(time.getEndtime().split(":")[0]);
		int endmin =  Integer.parseInt(time.getEndtime().split(":")[1]);
		
		ArrayList<String> restime = new ArrayList<String>();
		
		Calendar temp = Calendar.getInstance(); //시작시간 부터 30분씩 증가
		
		if (startmin == 0) {
			temp.set(Calendar.HOUR_OF_DAY, starthour);
			temp.set(Calendar.MINUTE, 0);
		} else if (startmin <= 30) {
			temp.set(Calendar.HOUR_OF_DAY, starthour);
			temp.set(Calendar.MINUTE, 30);
		} else {
			temp.set(Calendar.HOUR_OF_DAY, starthour + 1);
			temp.set(Calendar.MINUTE, 30);
		} 
		
		Calendar end = Calendar.getInstance(); //종료시간
		
		if (endmin < 30) {
			end.set(Calendar.HOUR_OF_DAY, endhour - 1);
			end.set(Calendar.MINUTE, 30);
		} else {
			end.set(Calendar.HOUR_OF_DAY, endhour);
			end.set(Calendar.MINUTE, 00);
		}
		
		
		while(temp.compareTo(end) <= 0) {

			//휴게시간이 아니면 예약시간으로 출력
			if(temp.get(Calendar.HOUR_OF_DAY) != 13) { 
				restime.add(String.format("%tH:%tM", temp, temp));
			}
			
			temp.add(Calendar.MINUTE, 30);
		}
		
		req.setAttribute("hpseq", hpseq);
		req.setAttribute("animals", animals);
		req.setAttribute("purposes", purposes);
		req.setAttribute("hosname", time.getHosname());
		req.setAttribute("restdays", restdays);
		req.setAttribute("restime", restime);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/main/user/diagnosis/reservation/reservation.jsp");

		dispatcher.forward(req, resp);
	}

}

~~~

- View
~~~java
	<main>
		<%@ include file ="/WEB-INF/views/inc/header.jsp"%>
		<section>
        	<div id="content">
        	
        	<h1 class="hospital-reservation-title">${hosname}</h1>
        	
        <form  enctype="multipart/form-data" class="hospital-reservation">
			<div id="reservation-accordion" >
				<!-- 반려동물 선택 -->
                 // . . .    
			  	<!-- 날짜시간 선택 -->
			  	<h3>예약 날짜 <span></span></h3>
	      		<div class="reservation-sel-date">
	      		
	      			<div id="reservation-datepicker"></div>
 					<div class="reservation-sel-time">
 					<c:forEach items="${restime}" var="time">
 						<c:if test="${time == '14:00'}"> <!-- 점심시간 전후 구분 -->
 						<hr>
 						</c:if>
 						<span type="button" class="badge badge-pill badge-light" onclick="setTime('${time}')">${time}</span>
 					</c:forEach>
 					</div>
 					
			 		<button type="button" onclick="moveNext(2);" class="btn reserv-ani-complete">선택 완료</button> 	
	     	 	</div>
 				
				<!-- 그외 선택 -->
  				//...
			<input type="hidden" name="uaseq">
			<input type="hidden" name="resdate">
			<input type="hidden" name="restime">
			<input type="hidden" name="hpseq" value="${hpseq}">
			</form>
			</div>
        </section>
        
        
        <footer>

		</footer>
    </main>
	
	<script>
	
		//아코디언
		$( function() {
			$('#reservation-accordion').accordion();
			 
		});
		
		$('#reservation-accordion').accordion({
			heightStyle: "content"
		});
		
		$('.hospital-reservation .card').click(function(){
			$('.card').css('border', '0px');
			$(event.target).parents('.card').css('border', '3px solid black');
			let name = $(event.target).parents('.card').children('.card-body').find('h1').text();
			$('.reservation-sel-animal').prev().children('span').text(': ' + name );
			$('input[name=uaseq]').val($(event.target).parents('.card').data('uaseq'));
			
			$('.reserv-ani-complete').first().css('display','block');
		});
		
		$('#reservation-accordion').accordion({
			beforeActivate: function( event, ui ) {}
		});
		
		
		//데이트피커
		$(function () {
        	$('#reservation-datepicker').datepicker();
        });
	
		
		$('#reservation-datepicker').datepicker({
			minDate: "+1d",
		  	maxDate: "+1m",
		  	 monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		  	dayNamesMin: [  "일" , "월", "화", "수", "목", "금", "토"],
		  	buttonImage: "/images/datepicker.gif",
		  	showMonthAfterYear: true,
		  	dateFormat: 'yy-mm-dd',
		    regional: "ko",
		    beforeShowDay: function(date){				
		    	let day = date.getDay();				
		    	return [(${restdays})];			
		    },			
		    onSelect: function(dateText, inst) {
		    	$('input[name=resdate]').val($(this).val());
		        $('.reservation-sel-time span.badge').css('display', 'inline-block');
		        
		        
		        if ($('input[name=restime]').val() != ''){
		        	$('.reservation-sel-date').prev().children('span').text(' : ' + $(this).val() + ' ' + $('input[name=restime]').val());
		        }
		        
		    },
		});
		
		
		//사용자 정의
		function moveNext(num) {
			$('#reservation-accordion').accordion("option", "active", num);
		}
		
		function setTime(time) {
			let span = $('.reservation-sel-date').prev().children('span');
			let date = $('input[name=resdate]').val();
			
			$('input[name=restime]').val(time);
			
			if(date != ''){
				span.text(' : ' + date + ' ' + time);
				$('.reservation-sel-time span.badge').css({'background-color': 'white', color: 'black'});
				$(event.target).css({ 'background-color': '#666', color: 'white' });			
				$('.reserv-ani-complete').eq(1).css('display','block');
			}
		}
		
		
		$('#reserv-complete').click(function() {
			
			if($('input[name=uaseq]').val() == '') {
				moveNext(0);
				alert('진료 동물을 선택해주세요.');
				return;
			} else if ($('input[name=resdate]').val() == '' || $('input[name=restime]').val() == '') {
				moveNext(1);
				alert('예약 날짜와 시간을 선택해주세요.');
				return;
			} else if ($('input[name=purpose]:checked').val() == null) {
				alert('방문 목적을 선택해주세요.')
				return;
			} 
			
			
			$.ajax({
				type: 'POST',
				url: '/fanimal/reservation/reservationadd.do',
				data: new FormData($('.hospital-reservation')[0]),
				dataType: 'json',
				contentType: false,
				processData: false,
				success: function(result) {
					if (result.result == 1){
						location.href = '/fanimal/user/mypage/viewreshos.do?rhseq=' + result.rhseq;
					} else {
						alert('예약 실패');
					}
				},
				error: function(a, b, c){
					console.log(a, b, c);
				}
			});
			
		});
		
		
		
		
	</script>
~~~

--Model
~~~java
~~~

---
</div>
</details> 
<br> 

 ### 📌 2. 케어일기 작성 및 조회
- <b>목적</b> 
    -  진료예약 후 동물병원에 방문시 관련 기록을 넘겨받아 일기를 작성할 수 있다.
- <b>기능</b> 
    1. 예약된 동물병원에 방문하면 케어일기에서 해당 진단서를 선택할 수 있다.
    2. 해당 진단서를 선택하고 케어일기를 작성할 수 있다.

</br>

## 5. 트러블 슈팅 및 경험
<details>
<summary>ajax 사용으로 리뷰 조회를 할 때 발생한 Uncaught TypeError 오류  </summary>
<div markdown="1">
- slim버전의 jquery를 사용하지 않음으로써 해결하였다.
- 참조: https://okky.kr/article/624496
</div>
</details>

<details>
<summary>ajax로 별점API 사용시  javascript가 호출되지 않는 문제</summary>
<div markdown="1">
- Document를 참조하여 $('.rateit').rateit(); 을 사용하여 자바스크립트 호출
- 참조: https://gjunge.github.io/rateit.js/examples/
</div>
</details> 

<details>
<summary>JDBC 사용으로 date 형식의 데이터를 문자열로 얻은 후 다시 select 쿼리문의 일부로 삽입하였을 경우 발생한 오류 </summary>
<div markdown="1">
- select 쿼리문의 일부로 삽입할 때 to_date를 사용하여 to_date('22-07-11 00:00:00', 'yy-mm-dd hh24:mi:ss')와 같이 삽입하였다.
</div>
</details> 

<details>
<summary>lombok 사용시 멤버변수의 첫번째 혹은 두번째가 대문자일 때  발생하는 javax.el.PropertyNotFoundException:</summary>
<div markdown="1">
- el을 적용할 때 변수명의 첫글자를 대문자로 하여 ${pSeq} 대신 ${PSeq}를 사용하였다.
- 참조: https://jdevil.tistory.com/10
</div>
</details> 

</br>

## 6. 구현 화면


## 7. 회고 / 느낀점


## 8. 문서 작업 자료
- [기획서](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/1.%20%EA%B8%B0%ED%9A%8D%EC%84%9C.pdf)
- [요구분석서](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/2.%20%EC%9A%94%EA%B5%AC%EB%B6%84%EC%84%9D%EC%84%9C.pdf)
- [순서도](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/4.%20%EC%88%9C%EC%84%9C%EB%8F%84.png)
- [화면설계서](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/5.%20%ED%99%94%EB%A9%B4%EC%84%A4%EA%B3%84%EC%84%9C.pdf)
- [발표자료](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/6.%20%EB%B0%9C%ED%91%9C%EC%9E%90%EB%A3%8C.pdf)
- [요악문서](https://github.com/Minji-Ko/portfolio/blob/main/Fanimal/%EB%AC%B8%EC%84%9C/7.%20%EC%9A%94%EC%95%BD%EB%B3%B8.pdf)

