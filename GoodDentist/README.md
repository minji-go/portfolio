# :hospital: 치과 예약 및 통합 관리 시스템

## 1. 제작 기간 & 참여 인원
- 2022.04.07 ~ 2022.04.18 
- 팀 프로젝트 (6명)

## 2. 사용 기술
- Java 11

## 3. ERD 설계
![](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/6.%20ERD.png)

## 4. 핵심 기능
### 📌  환자의 진료 예약 및 대기 기능 
- <b>목적</b> 
    - 환자가 방문 또는 전화예약 이외의 방법으로 예약 및 예약 변경을 할 수 있도록 하며, 예약이 불가할 경우 대기할 수 있도록 하여 편의성을 높이고자 하였다.
    - 환자의 갑작스러운 예약 취소로 인한 진료 가능 시간에 다른 환자가 예약할 수 있도록 하여 많은 환자를 진료할 수 있도록 하였다.
- <b>기능</b> 
    1. 의사 또는 환자가 직접 다음 진료 예약
    2. 환자의 메인화면에 예약 일정 표시
    3. 의사 개인의 업무 스케줄에서 진료예약 조회
    4. 환자의 실시간 예약 변경, 취소, 대기

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1. 오버로딩을 사용하여 의사 및 환자의 진료 예약  동시 구현

~~~java
public class Appointments {

    /** 환자 모드로 로그인하여 예약하기를 이용할 때 생성되는 생성자입니다.*/
    public Appointments() {
        this.thePatient = Login.currentPatient;
    }

    /** 관리자 모드로 로그인하여 예약하기를 이용할 때 생성되는 생성자입니다.
    * @param patient 다음 일정을 예약할 환자 객체 */
    public Appointments(Patient patient) {
        this.thePatient = patient;
    }
}
~~~

####  2.  java.time 패키지를 이용한 환자의 메인화면에 예약 일정 표시
~~~java
public void main() {
 
    if (hasAppointment() != null) {
        if (! String.format("%tF", now).equals(hasAppointment().getDate()) {
        
            System.out.printf("%s님, 검진일(%s)까지 %d일 남았습니다!\n", Login.currentPatient.getName()
                    , hasAppointment().getDate()
                    ,  daysBefore());
    }
}

private  int daysBefore() {
        String[] date = hasAppointment().getDate().split("-");
        
        LocalDate theDate = LocalDate.of(Integer.parseInt(date[0]), Integer.parseInt(date[1]), Integer.parseInt(date[2]));
        java.time.Period period = LocalDate.now().until(theDate);

        return period.getDays();
}
~~~
---
</div>
</details> 
<br> 

 ### 📌 의사의 진료 기록 작성 기능
- <b>목적</b> 
    - 환자 본인의 진료 결과에 대한 의사 소견을 구두로만 들을 수 있는 불편함을 해소하기 위해 진료기록을 자유롭게 조회할 수 있도록 한다.
- <b>기능</b> 
    1. 진료한 환자명을 검색하여 즉시 가장 최근 진료 기록 작성
    2. 환자는 진료 기록 조회 및 진단서 발급 가능

<!-- <details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
~~~java
~~~
---

</div>
</details>  -->

</br>

## 5. 트러블 슈팅 및 경험
<details>
<summary>csv형식의 데이터 파일 오류로 인해 발생하는 nullpointerException</summary>
<div markdown="1">
- 특정 시간에 예약된 진료가 취소되어도 환자입장에서는 알 수 없어서 예약 시간을 원하는대로 조정할 수 없는 불편함을 개선하길 바라는 마음으로 개발했습니다.

- <b>문제점</b>
    - RDBMS 대신 CSV형식의 파일입출력을 사용하다보니 
    - 대기취소가 발생할 경우 뒤의 대기자 순번 shift
    - 같은 아이디로 예약과 대기를 동시에 할 수 없도록
    - 대기 인원이 가득 찼을 경우 v와 x표시
    - 대기의

- <b>해결방법</b>

~~~java
/**
    * 예약 불가능한 일자에 예약 대기를 하는 메소드입니다.
    */
public void waiting() {

    String date = String.format("%tF", theDateTime);
    String time = theDateTime.get(Calendar.HOUR_OF_DAY) + ":00";
    
    String appointmentSeq = null;
    String appointmentPatientSeq = null; 
    
    for(Appointment a : appointments) {
        if(a.getDoctorNum().equals(theDoctor.getSeq())) {
            if(a.getTime().equals(time)) {
                appointmentSeq = a.getSeq();
                appointmentPatientSeq = a.getPatientNum(); 
            }
        }
    }
    
    if(appointmentPatientSeq.equals(thePatient.getSeq())) {
        Output.subMenuEnd();
        System.out.println("⚠ 이미 선택하신 날짜에 예약되어있습니다.");
        System.out.println();
        return;
    }
    
    for(WaitingList w : Data.wlist) {
        
        if(w.getAppointmentSeq().equals(appointmentSeq)) {
            
            if(w.getPatientSeq1().equals(thePatient.getSeq())
                ||w.getPatientSeq2().equals(thePatient.getSeq())
                ||w.getPatientSeq3().equals(thePatient.getSeq())){
                
                Output.subMenuEnd();
                System.out.println("⚠ 이미 선택하신 날짜에 대기되어있습니다.");
                System.out.println();
                return;
            }
                        
            if(w.getPatientSeq2().equals("null")) {
                checkWaiting(date, time, w, 2);
                return;
            } else if(w.getPatientSeq3().equals("null")) {
                checkWaiting(date, time, w, 3);
                return;
            } else {
                Output.subMenuEnd();
                System.out.println("⚠ 현재 대기 인원이 가득차서 대기할 수 없습니다.");
                System.out.println();
                return;
            }
        }
    }
    
    checkWaiting(date, time, new WaitingList(findMaxSeq_wlist(), appointmentSeq, thePatient.getSeq()) , 1);
}
~~~

</div>
</details>

    
<details>
<summary>통일된 파일 입출력 형식의 부재로 인한  코드의 중복 발생</summary>
<div markdown="1">
 - 여러가지 arrayList<T>타입을 받아서 각각의 상황에 맞게 쓰고 싶은데, 제네릭 타입을 입력받는 함수를 어떻게 구현하는지 모르겠다.
 - 메소드 두개 사용을 통해 해결
</div>
</details>  

<details>
<summary>예약일정이 오늘일자로 부터 며칠남았는지 정확한 계산이 안되는 오류</summary>
<div markdown="1">
- calendar 클래스로 조작하다보면 소수점까지는 컨트롤이 어려워서 며칠남았는지 계산할 때 오류가 발생
-  java.time패키지를 이용하여 해결
</div>
</details>  
    
</br>

## 6. 구현 화면
<img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%EC%B4%88%EA%B8%B0%ED%99%94%EB%A9%B4/%EB%A9%94%EC%9D%B8%ED%99%94%EB%A9%B4.png" width="400" height="400"/> <!--환자--><img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%ED%99%98%EC%9E%90/3.%20%EC%A7%84%EB%A3%8C%20%EC%98%88%EC%95%BD/3-1-2%20%EC%98%88%EC%95%BD%ED%95%98%EA%B8%B0%20%EC%8A%A4%EC%BC%80%EC%A4%84%20%EC%84%A0%ED%83%9D(2).png" width="300" height="400"/> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%ED%99%98%EC%9E%90/3.%20%EC%A7%84%EB%A3%8C%20%EC%98%88%EC%95%BD/3-1-7%20%EC%98%88%EC%95%BD%EB%8C%80%EA%B8%B0.png" width="300" height="400"/> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%ED%99%98%EC%9E%90/5.%20%EC%A7%84%EB%A3%8C%20%ED%9B%84%EA%B8%B0/5-2-3%20%EC%A7%84%EB%A3%8C%20%ED%9B%84%EA%B8%B0%20%EC%9E%91%EC%84%B1%20%ED%9B%84%20%EC%A1%B0%ED%9A%8C%20%EC%8B%9C%20%EB%B0%98%EC%98%81.png" width="300" height="400"/> <!-- 관리자--> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%EA%B4%80%EB%A6%AC%EC%9E%90/%EC%A7%84%EB%A3%8C%20%EC%A0%95%EB%B3%B4%20%EC%9E%91%EC%84%B1.png" width="300" height="400"/> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%EA%B4%80%EB%A6%AC%EC%9E%90/%EC%A7%84%EB%A3%8C%20%EC%A0%95%EB%B3%B4%20%EA%B2%80%EC%83%89_%EC%83%81%EC%84%B8_%EC%A7%84%EB%8B%A8%EC%84%9C.png" width="300" height="400"/> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%EA%B4%80%EB%A6%AC%EC%9E%90/%EC%9E%AC%EA%B3%A0%EA%B4%80%EB%A6%AC_%EC%88%98%EB%9F%89%ED%99%95%EC%9D%B8.png" width="400" height="300"/> <img src="https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%ED%99%94%EB%A9%B4%EC%BA%A1%EC%B2%98/%EA%B4%80%EB%A6%AC%EC%9E%90/%EB%A7%A4%EC%B6%9C%EC%95%A1%20%EC%A1%B0%ED%9A%8C.png" width="300" height="400"/> 

## 7. 회고 / 느낀점

<b>1. Github를 통한 프로젝트 관리 시 파일 충돌과 코드 취합의 어려움</b>

- 제안: Github을 사용하면 서로의 코드를 쉽게 공유하고 오류가 발생하면  버전을 돌려 복구할 수 있다는 장점때문에 협업툴로써 사용을 제안하였다. 
- 원인: 그러나 협업툴로써 사용해본 경험이 전무하여 Github를 혼자 사용할 때와 비슷할 것이라 예상하여 협업 가이드 등을 충분히 찾아서 읽어보지 못하였다.
- 문제: 결국 Github 컨벤션없이 commit이 이뤄져 버전 관리가 제대로 진행되지 못했으며, 여러 사람이 공통 파일을 동시에 수정함으로 인해 충돌이 복잡하게 발생하여 해결할 수가 없어서 Github 사용을 중단하였다.
- 해결: 이를 해결하기 위해 코드 취합 담당자를 정한 후 zoom의 화면 공유 기능을 통해 다 함께 프로젝트 파일을 비교 정리하여 구글 드라이브를 이용하여 코드 취합을 하였다.


<b>2. 사전 문서 작성과 회의가 부족한 상태로 업무 분담해 팀원 간 소통 오류 발생</b>
- 원인 : 공통으로 공유하는 코드 부분을 여러사람이 같이 작성하면 진행속도가 느리고 일부만이 참여한다고 판단하여 충분한 논의 없이 바로 분담을 하였다.
- 문제 : 같은 데이터를 이해하는 방식이 달랐고, 각자의 이해를 바탕으로 코드를 작성하여 서로 원활하게 데이터 처리가 연결되지 않았으며, 런타임 오류가 발생하여 문제의 원인을 찾는데 한참 걸렸다.
- 해결 : 추가 회의를 통한 팀원 간 코드 공유 및 다른 팀원의 코드를 리뷰함으로써 해결하였으며,  파일입출력과 저장, 여러 데이터의 DTO 등 공통코드를 자발적으로 맡아서 작성하였다.

<b>3. 모바일 애플리케이션과 콘솔의 환경 차이를 고려한 프로그램 설계의 중요성</b>
- 원인 : 실제로 자주사용하는 웹 또는 모바일 어플리케이션에서의 기능과 콘솔에서 구현가능한 동작의 차이를 고려하지 않고 요구 분석서를 작성하였다.
- 문제:  콘솔 화면 내에서 동시 접속이 불가능하고 한번에 한 사람만 기능을 이용할 수 있기 때문에 예약 대기 및 자동 확정 시 알림 등을 구현하는게 불가능하였다.

<b>4. CSV형식의 파일입출력을 사용으로 인한 무결성 검증의 어려움</b>
- 원인:  CSV형식의 파일 입출력은 데이터 이상현상이 발생하여도 즉각적으로 에러가 나지 않는다.
- 문제 : 프로그램 기능 수행 중에 에러가 발생하면 업무 코드의 문제인지 파일 데이터의 무결성 문제인지 알기 위해 많은 시간이 소요되었다.
- 해결: CSV형식의 파일을 엑셀로 변환하여 시각적으로 확인하여 조금 더 발견하기 쉽도록 하였다. 그러나 여전히 프로그램이 검증하는게 아니라 RDBMS의 필요성을 느꼈다.


## 8. 문서 작업 자료
- [기획서](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/1.%20%EA%B8%B0%ED%9A%8D%EC%84%9C.pdf)
- [요구분석서](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/2.%20%EC%9A%94%EA%B5%AC%EB%B6%84%EC%84%9D%EC%84%9C.pdf)
- [순서도](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/3.%20%EC%88%9C%EC%84%9C%EB%8F%84.png)
- [화면설계서](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/4.%20%ED%99%94%EB%A9%B4%EC%84%A4%EA%B3%84%EC%84%9C.pdf)
- [기능명세서](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/5.%20%EA%B8%B0%EB%8A%A5%EB%AA%85%EC%84%B8%EC%84%9C.pdf)
- [발표자료](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/7.%20%EB%B0%9C%ED%91%9C%EC%9E%90%EB%A3%8C.pdf)
- [요악문서](https://github.com/Minji-Ko/portfolio/blob/main/GoodDentist/%EB%AC%B8%EC%84%9C/8.%20%EC%9A%94%EC%95%BD%EB%AC%B8%EC%84%9C.pdf)

