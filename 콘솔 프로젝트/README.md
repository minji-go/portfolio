# :pushpin: 치과 통합 관리/예약 시스템
</br>

## 1. 제작 기간 & 참여 인원
- 2022.04.07 ~ 2022.04.18 
- 팀 프로젝트 (6명)

</br>

## 2. 사용 기술
- Java 11


</br>

## 3. ERD 설계
![](https://github.com/Minji-Ko/portfolio/tree/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/ERD.png)


## 4. 핵심 기능
이 서비스의 핵심 기능은 컨텐츠 등록 기능입니다.  
사용자는 단지 컨텐츠의 카테고리를 선택하고, URL만 입력하면 끝입니다.  
이 단순한 기능의 흐름을 보면, 서비스가 어떻게 동작하는지 알 수 있습니다.  

치과 환자 본인이 원하는 방식(날짜/시간/의사/방문목적)으로 진료 예약 및 대기하는 기능
- 환자의 상황에 따른 실시간 예약 정보 변경 및 취소 가능
- 환자의 예약상황을 관리자 모드에서 의사 개인의 업무스케줄에서 실시간으로 조회 가능
- 환자의 예약이 메인 상단에 남은시간과 함께 표시됌




<details>
<summary><b>핵심 기능 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 전체 흐름
![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow1.png)

### 4.2. 사용자 요청
![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_vue.png)

- **URL 정규식 체크** :pushpin: [코드 확인](https://github.com/Integerous/goQuality/blob/b587bbff4dce02e3bec4f4787151a9b6fa326319/frontend/src/components/PostInput.vue#L67)
  - Vue.js로 렌더링된 화면단에서, 사용자가 등록을 시도한 URL의 모양새를 정규식으로 확인합니다.
  - URL의 모양새가 아닌 경우, 에러 메세지를 띄웁니다.

- **Axios 비동기 요청** :pushpin: [코드 확인]()
  - URL의 모양새인 경우, 컨텐츠를 등록하는 POST 요청을 비동기로 날립니다.

### 4.3. Controller

![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_controller.png)

- **요청 처리** :pushpin: [코드 확인](https://github.com/Integerous/goQuality/blob/b2c5e60761b6308f14eebe98ccdb1949de6c4b99/src/main/java/goQuality/integerous/controller/PostRestController.java#L55)
  - Controller에서는 요청을 화면단에서 넘어온 요청을 받고, Service 계층에 로직 처리를 위임합니다.

- **결과 응답** :pushpin: [코드 확인]()
  - Service 계층에서 넘어온 로직 처리 결과(메세지)를 화면단에 응답해줍니다.

### 4.4. Service

![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_service1.png)

- **Http 프로토콜 추가 및 trim()** :pushpin: [코드 확인]()
  - 사용자가 URL 입력 시 Http 프로토콜을 생략하거나 공백을 넣은 경우,  
  올바른 URL이 될 수 있도록 Http 프로토콜을 추가해주고, 공백을 제거해줍니다.

- **URL 접속 확인** :pushpin: [코드 확인]()
  - 화면단에서 모양새만 확인한 URL이 실제 리소스로 연결되는지 HttpUrlConnection으로 테스트합니다.
  - 이 때, 빠른 응답을 위해 Request Method를 GET이 아닌 HEAD를 사용했습니다.
  - (HEAD 메소드는 GET 메소드의 응답 결과의 Body는 가져오지 않고, Header만 확인하기 때문에 GET 메소드에 비해 응답속도가 빠릅니다.)

  ![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_service2.png)

- **Jsoup 이미지, 제목 파싱** :pushpin: [코드 확인]()
  - URL 접속 확인결과 유효하면 Jsoup을 사용해서 입력된 URL의 이미지와 제목을 파싱합니다.
  - 이미지는 Open Graphic Tag를 우선적으로 파싱하고, 없을 경우 첫 번째 이미지와 제목을 파싱합니다.
  - 컨텐츠에 이미지가 없을 경우, 미리 설정해둔 기본 이미지를 사용하고, 제목이 없을 경우 생략합니다.


### 4.5. Repository

![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_repo.png)

- **컨텐츠 저장** :pushpin: [코드 확인]()
  - URL 유효성 체크와 이미지, 제목 파싱이 끝난 컨텐츠는 DB에 저장합니다.
  - 저장된 컨텐츠는 다시 Repository - Service - Controller를 거쳐 화면단에 송출됩니다.

</div>
</details>

</br>

## 5. 핵심 트러블 슈팅
### 5.1. 진료 예약 대기 서비스의 구현
- 특정 시간에 예약된 진료가 취소되어도 환자입장에서는 알 수 없어서 예약 시간을 원하는대로 조정할 수 없는 불편함을 개선하길 바라는 마음으로 개발했습니다.

문제점
- 대기인원이 없을 경우 null
- 대기취소가 발생할 경우 뒤의 대기자 순번 shift
- 같은 아이디로 예약과 대기를 동시에 할 수 없도록
- 대기 인원이 가득 찼을 경우 v와 x표시
- 대기의

해결방법


- 하지만 [무한스크롤, 페이징 혹은 “더보기” 버튼? 어떤 걸 써야할까](https://cyberx.tistory.com/82) 라는 글을 읽고 무한 스크롤의 단점들을 알게 되었고,  
다양한 기준(카테고리, 사용자, 등록일, 인기도)의 게시물 필터 기능을 넣어서 이를 보완하고자 했습니다.

- 그런데 게시물이 필터링 된 상태에서 무한 스크롤이 동작하면,  
필터링 된 게시물들만 DB에 요청해야 하기 때문에 아래의 **기존 코드** 처럼 각 필터별로 다른 Query를 날려야 했습니다.

<details>
<summary><b>기존 코드</b></summary>
<div markdown="1">

~~~java

~~~

</div>
</details>

- 이 때 카테고리(tag)로 게시물을 필터링 하는 경우,  
각 게시물은 최대 3개까지의 카테고리(tag)를 가질 수 있어 해당 카테고리를 포함하는 모든 게시물을 질의해야 했기 때문에  
- 아래 **개선된 코드**와 같이 QueryDSL을 사용하여 다소 복잡한 Query를 작성하면서도 페이징 처리를 할 수 있었습니다.

<details>
<summary><b>개선된 코드</b></summary>
<div markdown="1">

~~~java
~~~

</div>
</details>

</br>

## 6. 그 외 트러블 슈팅 및 경험

<details>
<summary> 태그 선택후 등록하기 누를 때 `object references an unsaved transient instance - save the transient instance before flushing` 오류</summary>
<div markdown="1">
  - 처음에 분산된 load()와 save()클래스
  - Data 클래스의 load() save()를 제네릭함수로 모든 걸 받아서 쓰는 법을 모르겠어서 다른 방식으로 했는데... 
- 
</div>
</details>    
    
</br>

## 6. 회고 / 느낀점
프로젝트 후 느낀점, 배운 점 

- 공통으로 공유하는 코드 부분을 여러사람이 같이 작성하면 진행속도가 더디다고 판단되어 바로 분담을 했는데 그러다보니 서로 다르게 이해해서 혼란이 있어서 사전회의의 중요성이 새삼느껴졌다.
- 깃허브를 사용하는게 좋기는 하지만 이 역시 공통부분은 공유 중에 수정하면 충돌이 자주발생하여 현업에서도 그렇게 하지 않는다는 걸 처음 알게되었다.
- 타인의 코드를 보았을 때 다른 식으로 작성하면 더 가독성이 좋을 것 같다고 느끼는 부분이 있었으나 얘기하기가 어려운 부분인 것 같다.
- 의견 충돌이 있을 때는 중요한 부분인지 판단 후에 핵심 기능 구현에 문제가 없다면 양보하는게 팀프로젝트의 원활한 진행에 도움이 되는 것 같다.

프로젝트의 부족한 점, 보완했으면 하는 점 등등

- 예약을 의사에게 한 시간대당 한명으로 정했으나, 실제와 다른 점이 있다는 게 아쉽다.
- 예약 대기 기능 및 자동 확정 기능을 넣으려 했으나, 콘솔 프로젝트다 보니 예약이 이미 있는 환자에게 자동 확정기능을 적용할 경우 2개의 예약이 생기는 문제가 있었다. 모바일 어플과 콘솔 프로젝트는 동시 접속 가능, 알람 등의 면에서 차이가 있었다.

코드 관련 어려웠던 점

- 여러가지 arrayList<T>타입을 받아서 각각의 상황에 맞게 쓰고 싶은데, 제네릭 타입을 입력받는 함수를 어떻게 구현하는지 모르겠다.
- 하나의 기능을 구현하고 다른 비슷한 기능을 구현하려고 할 때, 수정하는 방식으로 하다보니 생각하지 못한 부분들이 많아 nullpointerException과 ArrayIndexOutOfBounds 예외가 자주 발생하였다.


1. 발생 문제
Github를 통한 프로젝트 관리 시 파일 충돌과 코드 취합의 어려움
> 코드 취합 담당자를 정한 후 zoom 화면 공유 기능을 통해 다 함께 프로젝트 파일을 정리하여 해결

사전 문서 작성과 회의가 부족한 상태로 업무 분담해 팀원 간 소통 오류 발생
> 추가 회의, 팀원 간 코드 공유, 팀원의 코드 스터디를 통해 해결, 효율적인 결과물 도출

2. 깨달은 점
요구분석서 및 기능명세서 등 문서 작업과 공통 코드 작성의 중요성
형상 관리의 중요성
팀원 간 정확한 의견 전달과 이해, 소통의 중요성
모바일 애플리케이션과 콘솔의 환경 차이를 고려한 프로그램 설계의 중요성

3. 보완할 점
매끄럽지 못한 출력 결과
업무 담당자별 상이한 출력 라벨 및 디자인 등을 보완해 통일성 부여
