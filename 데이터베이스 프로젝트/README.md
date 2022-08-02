# :pencil: IT 교육센터 운영 프로그램

## 1. 제작 기간 & 참여 인원
- 2022.05.11 ~ 2022.05.20 
- 팀 프로젝트 (6명)

## 2. 사용 기술 및 협업 툴
- Oracle 11g
- Oracle Cloud, Google Drive, ERD Cloud

## 3. ERD 설계
![](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20ERD.png)

## 4. 핵심 기능
### 📌  1.	교육생의 출결 기록 및  출결 상황 조회
- <b>목적</b> 
    - 교육생의 입/퇴실 및 외출기록을 바탕으로 전체 출결 현황을 조회할 수 있도록 한다.
- <b>기능</b> 
    1. 교육생의 입/퇴실 및 외출현황을 기록한다.
    2. 교육생의 출결 현황을 과정별, 기간별로 확인할 수 있다.

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1. 뷰를 사용하여 날짜별 교육생의 출결 현황 파악

~~~SQL
create or replace view attendance_info
as
select 
    a.student_seq as "학생번호",
    a.seq as "출결번호", 
    a.attendance_date as "날짜",
    case
        when min(d.checkin) is not null then '출석'
        when to_char(a.attendance_date, 'd') = 7 or to_char(a.attendance_date, 'd') = 1 then '(주말)'
        when (select sick_or_etc from sick_or_etc where attendance_seq = a.seq) = '병가' then '병가'
        when (select sick_or_etc from sick_or_etc where attendance_seq = a.seq) = '기타' then '기타'
        when (select count(*) from holiday where holiday_date = a.attendance_date) > 0 then '(공휴일)'
        else '결석'
    end as "출석",
    case
        when to_date(min(d.checkin), 'hh24:mi') >= to_date('09:10', 'hh24:mi') then '지각'
        else '.'
    end as "지각",
    case 
        when to_date(max(d.checkout), 'hh24:mi') < to_date('17:50', 'hh24:mi') then '조퇴'
        else '.'
    end as "조퇴",
    case
        when (select count(*) from attendance_detail where attendance_seq = a.seq ) > 1 then '외출'
        else '.'
    end as "외출"
from attendance a
    left outer join attendance_detail d 
        on d.attendance_seq = a.seq
            inner join student s
                on s.seq = a.student_seq
                    where a.attendance_date < sysdate
                        group by a.seq, a.attendance_date, a.student_seq;

~~~

#### 2.  Procedure를 사용하여 특정 개설과정의 모든 교육생 출결현황 조회
~~~SQL
create or replace procedure admin_attendance_inquiry_P(
      p_open_curs_seq in number,   
      p_result      out sys_refcursor
)
is
begin
    open p_result
    for
    select 
        "학생번호",
        count(decode("출석", '출석', 1)) as "출석일수",
        count(decode("지각조퇴", '출석..', 1)) as "정상일수",
        count(decode("지각조퇴", '출석지각.', 1)) as "지각일수",
        count(decode("지각조퇴", '출석.조퇴', 1)) as "조퇴일수",
        count(decode("지각조퇴", '출석지각조퇴', 1)) as "지각 및 조퇴일수",
        count(decode("지각조퇴", '외출', 1)) as "외출일수",
        count(decode("지각조퇴", '결석', 1)) as "결석일수",
        count(decode("출석", '병가', 1)) as "병가일수",
        count(decode("출석", '기타', 1)) as "기타일수"
    from
        (select i.*, 출석||지각||조퇴 as "지각조퇴" from attendance_info i 
            where "학생번호" in (select seq from student where open_curs_seq = p_open_curs_seq))
                group by "학생번호";
        
end admin_attendance_inquiry_P;
~~~

---
</div>
</details> 
<br> 

 ### 📌 2. 교사의 시험 배점 및 성적 입력과 조회
- <b>목적</b> 
    -  교사는 특정개설 과목의 실기, 필기, 출결 배점을 등록하고 각각의 성적 배점 이하로 입력하고 조회할 수 있다.
- <b>기능</b> 
    1. 교사는 특정과목의 배점을 입력한다.
    2. 교육생별 성적을 배점 하에서 등록할 수 있다.
    3. 성적을 등록하기 전에만 배점을 수정, 삭제할 수 있다.

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1. Trigger를 사용하여 배점 및 성적의 무결성 유지
~~~SQL
    create or replace trigger teacher_point_T
    before update or delete
    on point
    for each row
declare
    v_score_num number;
    v_subject_seq number;
begin
    
    if updating then 
        v_subject_seq := :new.open_subject_seq;
    elsif deleting then  
        v_subject_seq := :old.open_subject_seq;
    end if;
    
    select count(*) into v_score_num from subject_score s where s.open_subject_seq = v_subject_seq;
    
    if v_score_num > 0 
    then raise_application_error(-20100, '학생의 성적 데이터가 존재하여 배점 수정에 실패하였습니다.'); 
    end if;
end;

~~~
~~~SQL
create or replace trigger teacher_score_T
    before insert or update
    on subject_score
    for each row
declare
    v_attend_point point.attend_point%type;
    v_written_point point.written_point%type; 
    v_skill_point point.skill_point%type;
begin
    
    select p.attend_point, p.written_point, p.skill_point  
        into v_attend_point, v_written_point, v_skill_point
    from point p where p.open_subject_seq = :new.open_subject_seq;
    
    
    if :new.attendance_score > v_attend_point
        or :new.written_score > v_written_point
        or :new.skill_score > v_skill_point
    then raise_application_error(-20101, '배점이상의 성적은 입력하여 성적 등록 및 수정에 실패하였습니다.'); 
    end if;
    
end;
~~~

---
</div>
</details> 
<br> 


</br>

## 5. 트러블 슈팅 및 경험
<details>
<summary>join의 사용으로 일부 컬럼의 중복된 데이터가 반복하여 출력되는 문제</summary>
<div markdown="1">
- 중복을 발생시키는 테이블의 조인을 분리하고, Cursor를 두개 사용하여 각각 출력한다.

~~~SQL
    dbms_output.put_line('==================================강의 스케줄 조회===================================');
    
    loop
        fetch v_result into v_open_subject_seq, v_open_subject_state, v_curriculum_name, v_open_curs_begin, v_open_curs_end, v_lectureroon_name, 
                            v_subject_name, v_open_subject_begin, v_open_subject_end, v_student_num;
        exit when v_result%notfound;
        
        dbms_output.put_line('-----------------------------------------------------------------------------------');
        dbms_output.put_line(v_seq ||'. '||'['||v_open_subject_state||'] '||v_subject_name||' (과목번호: '||v_open_subject_seq||')');
        dbms_output.put_line('              - 기간: '||v_open_subject_begin||' ~ '||v_open_subject_end);
        dbms_output.put_line('              - 인원: '||v_student_num||'명');
        
        open_subject_book_P (v_open_subject_seq, v_book_name);
       
        v_book_seq := 1;
        loop
            fetch v_book_name into v_temp;
            exit when v_book_name%notfound;
            dbms_output.put_line('              - 교재'||v_book_seq||': '||v_temp);
            v_book_seq := v_book_seq + 1;
        end loop;
        close v_book_name;
        
        dbms_output.put_line('              - 과정: '||v_curriculum_name || ' ('||v_open_curs_begin||' ~ '||v_open_curs_end||')');
        dbms_output.put_line('              - 강의실: '||v_lectureroon_name);
        
         v_seq := v_seq + 1;

    end loop;
~~~

</div>
</details>

<details>
<summary>다른 테이블을 참조하여 각각의 레코드를 다른 값으로 update할 때 발생한 오류</summary>
<div markdown="1">
- update문 작성시 수정하려는 다중컬럼(A, B, C)의 값을 select문으로 select a, b, c from X 와 같이  하나의 서브 쿼리를 사용한다.
</div>
</details> 

</br>

## 6. 구현 화면



## 7. 회고 / 느낀점
-	[협업툴 사용 관련] 비대면으로 진행된 프로젝트임에도 구글 드라이브, 오라클 클라우드 등을 활용하여 여러 사람이 적극적으로 자신의 의견을 표현하기 유연했고, 실시간으로 팀원들과 상호작용이 가능했으며, 별도의 자료 취합이 필요하지 않아서 업무의 효율성이 높았다. 앞으로도 더 다양한 협업 툴을 활용해 팀 작업을 해보면 좋을 것 같다. 

-	[ERD 설계 관련] 요구사항 또는 현실세계의 개념을 객체로 추상화하여 ERD를 설계하는 과정과 정규화를 하는 과정이 쉽지 않았고, 실제로 갱신이상이 발생하기도 했었다. 또한 테이블 간의 적절한 관계를 맺는데 생소한 용어들로 인해 의사소통에 어려움이 있었으나, 여러 시행착오를 겪어가며 점차 개선되기도 했다. 설계한 erd를 기반으로 테이블을 사상한 이후 그에 따른 더미데이터의 생성도 오래 걸리고 어려웠지만, 팀원들과 함께 작업하며 실력적으로 부족한 부분을 보완하고, 차근차근 하나씩 해결해가면서 뿌듯함을 많이 느꼈다. 다음 프로젝트에는 이번의 경험을 바탕으로 ERD설계가 완료된 후 더욱 검토하는 등 더 발전된 모습으로 임하여 시행착오를 줄이면 좋을 것 같다.

-	[업무SQL 구현 관련] ERD설계를 바탕으로 기능을 구현하고 출력하는 과정속에서 DB에 대한 이해도가 높아졌으며, 익숙하지 않았던 프로시저 등의 SQL작성을 다른 팀원의 도움을 받아 구현하는 과정에서 많은걸 배울 수 있었다.

-	[협업 및 프로젝트 진행 관련] 프로젝트 진행 일정이 당초에 계획했던 것보다 밀리기도 했지만 팀원 모두의 적극적인 참여로 기한 내에 여유롭게 작업을 마무리할 수 있게 되었다. 기존에 정해진 계획대로 무리하게 진행하기보다는 그때그때 팀원들과 협업하며 상황에 따라 유연하게 판단하면 더 좋은 결과를 얻을 수 있다는 것을 배웠다. 이 프로젝트를 통해 좋은 프로젝트 결과물을 산출하려면 개발자 한 명의 힘으로는 부족하고 다 같이 협업하여 개발해야 한다고 느꼈다. 덧붙여 원활하게 협업하려면 소통을 할 때 추상적인 내용을 구체적으로, 그리고 시각적으로 보여주면 도움이 된다고 느꼈다.


## 8. 문서 작업 자료
- [요구분석서]()
- [순서도](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20%EC%88%9C%EC%84%9C%EB%8F%84.drawio)
- [DDL 정의서](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20%EA%B5%90%EC%9C%A1%EC%84%BC%ED%84%B0%EA%B4%80%EB%A6%AC%EC%8B%9C%EC%8A%A4%ED%85%9C%20DDL%EC%A0%95%EC%9D%98%EC%84%9C%20.docx)
- [ANSI-SQL 스크립트](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20%EC%97%85%EB%AC%B4%20SQL%20(%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%BF%BC%EB%A6%AC%EB%AC%B8).docx)
- [오브젝트 스크립트](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20DB%20%EC%98%A4%EB%B8%8C%EC%A0%9D%ED%8A%B8%20%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8(PLSQL).docx)
-[발표자료](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20%EC%8C%8D%EC%9A%A9%EA%B5%90%EC%9C%A1%EC%84%BC%ED%84%B0%EA%B4%80%EB%A6%AC%EC%8B%9C%EC%8A%A4%ED%85%9C%20%EB%B0%9C%ED%91%9C%20%EC%B5%9C%EC%A2%85%20PPT.pdf)
- [요악문서](https://github.com/Minji-Ko/portfolio/blob/main/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1%EC%A1%B0%20%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20%EC%9A%94%EC%95%BD%EB%B3%B8.docx)