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

~~~java
~~~

#### 2. ajax를 사용하여 동물병원 리뷰 조회

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
- [요구분석서]()
- [순서도]()
- [DDL 정의서]()
- [ANSI-SQL 스크립트]()
- [오브젝트 스크립트]()
- [요악문서]()